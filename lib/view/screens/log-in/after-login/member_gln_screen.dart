import 'package:flutter/material.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/view-model/login/after-login/gln_services.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MemberGLNScreen extends StatefulWidget {
  const MemberGLNScreen({super.key});
  static const String routeName = "/member-gln";

  @override
  State<MemberGLNScreen> createState() => _MemberGLNScreenState();
}

class _MemberGLNScreenState extends State<MemberGLNScreen> {
  // scaffold key
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final response = args['response'] as DashboardModel;
    final userId = args['userId'];
    return WillPopScope(
      onWillPop: () async {
        scaffoldKey.currentState?.openDrawer();
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawerWidget(
          userId: response.memberData?.user?.id ?? userId,
          response: response,
        ),
        appBar: AppBar(
          title: const Text("Member GLN"),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: GLNServices.getGLN(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.deepPurple,
                  size: 60,
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline_sharp,
                      size: 100,
                    ),
                    Text('No Data'),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_sharp,
                      size: 100,
                    ),
                    Text('${snapshot.error}')
                  ],
                ),
              );
            }

            final snap = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(
                    // border: TableBorder.symmetric(
                    //   inside: const BorderSide(
                    //     width: 1,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                        ),
                        children: const [
                          Text(
                            'gcp_GLNID',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Location Name [Eng]',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Location Name [Ar]',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'GLN Barcode',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                    itemCount: snap?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        // border: TableBorder.symmetric(
                        //   inside: const BorderSide(
                        //     width: 1,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            children: [
                              Text('${snap?[index].gcpGLNID}'),
                              Text('${snap?[index].locationNameEn}'),
                              Text('${snap?[index].locationNameAr}'),
                              Text('${snap?[index].gLNBarcodeNumber}'),
                            ],
                          ),
                        ],
                      );
                    },
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
