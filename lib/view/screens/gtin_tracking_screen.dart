import 'package:flutter/material.dart';
import 'package:hiring_task/view/screens/home/home_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GtinTrackingScreen extends StatefulWidget {
  const GtinTrackingScreen({super.key});
  static const routeName = 'gtin-tracking';

  @override
  State<StatefulWidget> createState() => _GtinTrackingScreenState();
}

class _GtinTrackingScreenState extends State<GtinTrackingScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scanned QR Code: $qrText',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
        if (qrText ==
            'http://localhost:5000/01/GS1DL/?linkType=tblProductContents&GTIN=6281000000120') {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
