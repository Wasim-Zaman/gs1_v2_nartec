import 'package:flutter/material.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/view/screens/log-in/after-login/dashboard/widgets/rectagular_widget.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_widgets/primary_text_widget.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  static const String routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final response = args['response'] as DashboardModel;
    final userId = args['userId'];

    return WillPopScope(
      onWillPop: () {
        _scaffoldKey.currentState!.openDrawer();
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Dashboard"),
          centerTitle: true,
        ),
        drawer: CustomDrawerWidget(
          userId: response.memberData?.user?.id ?? userId,
          response: response,
        ),
        body: ListView(
          children: [
            Screen(
              companyId: response.memberData?.user?.companyID,
              gcpGLNID: response.memberData?.user?.gcpGLNID,
              gcpExpiry: response.memberData?.user?.gcpExpiry,
              category: response
                  .memberData?.memberCategory?.memberCategoryDescription,
              totalNoOfBarcodes:
                  response.memberData?.memberCategory?.totalNoOfBarcodes,
              gtinRange: response.memberData?.gtinRange,
              issuedGTIN: response.memberData?.issuedGTIN,
              remainingGTIN: response.memberData?.remainingGTIN,
              issuedGLN: response.memberData?.issuedGLN,
              glnTotalBarcodes: response.memberData?.glnTotalBarcode,
              issuedSSC: response.memberData?.issuedSSCC,
              sscTotalBarcodes: response.memberData?.ssccTotalBarcode,
            ),
          ],
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.companyId,
    this.gcpGLNID,
    this.gcpExpiry,
    this.issuedGTIN,
    this.remainingGTIN,
    this.category,
    this.totalNoOfBarcodes,
    this.gtinRange,
    this.issuedGLN,
    this.glnTotalBarcodes,
    this.issuedSSC,
    this.sscTotalBarcodes,
  });

  final String? companyId;
  final String? gcpGLNID;
  final String? gcpExpiry;
  final int? issuedGTIN;
  final int? remainingGTIN;
  final String? gtinRange;
  final int? issuedGLN;
  final int? glnTotalBarcodes;
  final int? issuedSSC;
  final int? sscTotalBarcodes;

  // member category
  final String? category;
  final String? totalNoOfBarcodes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const PrimaryTextWidget(text: "Your Subscription Will Expire On"),
          PrimaryTextWidget(text: gcpExpiry.toString()),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/dashboard_user.png"),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PrimaryTextWidget(text: "GCP:"),
                            PrimaryTextWidget(text: gcpGLNID.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PrimaryTextWidget(text: "Member Id:"),
                            PrimaryTextWidget(text: companyId.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(thickness: 3, color: Theme.of(context).primaryColor),
          Image.asset("assets/images/dashboard_barcode.png"),
          const SizedBox(height: 10),
          RectangularWidget(
            text1: category.toString(),
            text2: "$gtinRange Range Of Barcodes",
            text3: "$issuedGTIN Barcodes Issued",
            text4: "$remainingGTIN Barcodes Remaining",
          ),
          const SizedBox(height: 10),
          Divider(thickness: 3, color: Theme.of(context).primaryColor),
          const SizedBox(height: 10),
          Image.asset("assets/images/dashboard_location.png"),
          const SizedBox(height: 10),
          RectangularWidget(
            text1: "$issuedGLN GLN Issued",
            text2: "$glnTotalBarcodes GLN Total Barcodes",
            text3: "$issuedSSC Issued SSC",
            text4: "$sscTotalBarcodes SSC Total Barcodes",
          ),
          const SizedBox(height: 10),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.purple,
          //       Colors.deepPurple,
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          //   // trailing: CustomText(
          //   //   text:
          //   //       'Your Subscription Will Expire On\n${DateFormat.yMMMd().format(DateTime.parse(gcpExpiry.toString()))}',
          //   // ),
          //   trailing: RichText(
          //     text: TextSpan(
          //       text: 'Your Subscription Will Expire On\n',
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //       ),
          //       children: [
          //         TextSpan(
          //           text: DateFormat.yMMMd().format(
          //               DateTime.parse(gcpExpiry ?? DateTime.now().toString())),
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // CustomCard(
          //   // trailing: CustomText(text: 'GCP: $gcpGLNID\nMember ID: $companyId'),
          //   trailing: RichText(
          //     text: TextSpan(
          //       text: 'GCP: ',
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //       ),
          //       children: [
          //         TextSpan(
          //           text: '$gcpGLNID\n',
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         const TextSpan(text: 'Member ID: '),
          //         TextSpan(
          //           text: '$companyId',
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.orange,
          //       Colors.orangeAccent,
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          //   trailing: CustomText(text: "$totalNoOfBarcodes\n$category"),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.red,
          //       Colors.redAccent,
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          //   trailing: CustomText(text: '$gtinRange\nRange Of Barcode'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.green,
          //       Colors.greenAccent,
          //     ],
          //   ),
          //   trailing: CustomText(text: '$issuedGTIN\nBarcodes Issued'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.lightBlue,
          //       Colors.lightBlueAccent,
          //     ],
          //   ),
          //   trailing: CustomText(text: '$remainingGTIN\nBarcodes Remaining'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.pink,
          //       Colors.pinkAccent,
          //     ],
          //   ),
          //   trailing: CustomText(text: '$issuedGLN\nGLN Issued'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.cyan,
          //       Colors.cyanAccent,
          //     ],
          //   ),
          //   trailing: CustomText(text: '$glnTotalBarcodes\nGLN Total Barcodes'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.indigo,
          //       Colors.indigoAccent,
          //     ],
          //   ),
          //   trailing: CustomText(text: '$issuedSSC\nIssued SSCC'),
          // ),
          // CustomCard(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Colors.lime,
          //       Colors.limeAccent,
          //     ],
          //   ),
          //   trailing:
          //       CustomText(text: '$sscTotalBarcodes\nSSCC Total Barcodes'),
          // ),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final LinearGradient? gradient;

  const CustomCard({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: gradient ??
              LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue.shade900,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        ),
        // child: ListTile(
        //   dense: true,
        //   isThreeLine: true,
        //   leading: leading ?? const SizedBox.shrink(),
        //   title: title ?? const SizedBox.shrink(),
        //   subtitle: subtitle ?? const SizedBox.shrink(),
        //   trailing: trailing ?? const SizedBox.shrink(),
        // ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20),
          child: trailing,
        ));
  }
}
