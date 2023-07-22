import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hiring_task/models/lat_long_model.dart';
import 'package:hiring_task/providers/gtin.dart';
import 'package:hiring_task/view-model/retail-information/lat_long_service.dart';
import 'package:hiring_task/view/screens/single_event_screen.dart';
import 'package:provider/provider.dart';

class OffersNearMeScreen extends StatefulWidget {
  const OffersNearMeScreen({super.key});

  @override
  _OffersNearMeScreenState createState() => _OffersNearMeScreenState();
  static const routeName = "/offers_nearMe_screen";
}

class _OffersNearMeScreenState extends State<OffersNearMeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.future.then((value) => value.dispose());
  }

  singleEventScreen(LatLongModel latLongData, String trxGLNIDTo) {
    Navigator.of(context).pushNamed(SingleEventScreen.routeName, arguments: {
      'latLongData': latLongData,
      'trxGLNIDTo': trxGLNIDTo,
    });
  }

  void addMarker(
      double lat, double lng, LatLongModel latLongData, String trxGLNIDTo) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_markers.length.toString()),
          position: LatLng(lat, lng),
          // onTap: () {
          //  display a dialog with the marker's information
          //   showDialog(
          //     context: context,
          //     builder: (context) => Dialog(
          //       child: SizedBox(
          //         height: 200,
          //         child: Center(
          //           child: Text('No of markers: ${_markers.length}'),
          //         ),
          //       ),
          //     ),
          //   );
          // },
          onTap: () => singleEventScreen(latLongData, trxGLNIDTo),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LatLongService.getFutureData(
            gtin: Provider.of<GTIN>(context, listen: false).gtinNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          final data = snapshot.data as List<LatLongModel>;
          return GoogleMap(
            markers: _markers,
            buildingsEnabled: true,
            // mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              // addMarker(37.7749, -122.4194); // San Francisco
              // addMarker(40.7128, -74.0060); // New York City
              data.forEach((element) {
                double lat = double.parse(element.itemGPSOnGoLat.toString());
                double lng = double.parse(element.itemGPSOnGoLon.toString());
                addMarker(lat, lng, element, element.trxGLNIDTo.toString());
              });
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(23.885942, 45.079163),
              zoom: 12.0,
            ),
          );
        },
      ),
    );
  }
}
