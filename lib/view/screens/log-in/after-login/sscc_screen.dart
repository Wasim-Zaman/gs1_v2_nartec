import 'package:flutter/material.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/view-model/login/after-login/sscc_services.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_widgets/table_header_text.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SSCCScreen extends StatefulWidget {
  const SSCCScreen({super.key});
  static const String routeName = 'sscc-screen';

  @override
  State<SSCCScreen> createState() => _SSCCScreenState();
}

class _SSCCScreenState extends State<SSCCScreen> {
  final scaffodKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
    scaffodKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final response = args['response'] as DashboardModel;
    final userId = args['userId'];
    return WillPopScope(
      onWillPop: () async {
        scaffodKey.currentState?.openDrawer();
        return false;
      },
      child: Scaffold(
        key: scaffodKey,
        drawer: CustomDrawerWidget(
          userId: response.memberData?.user?.id ?? userId,
          response: response,
        ),
        appBar: AppBar(
          title: const Text("Member SSCC"),
          elevation: 0,
        ),
        body: FutureBuilder(
          future: SSCCServices.getSSCC(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Something went wring.'),
                        TextButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }

            final snap = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Table(
                  //   defaultVerticalAlignment: TableCellVerticalAlignment.top,

                  //   // border: TableBorder.symmetric(
                  //   //   inside: const BorderSide(
                  //   //     width: 1,
                  //   //     color: Colors.white,
                  //   //   ),
                  //   // ),
                  //   children: [
                  //     TableRow(
                  //       decoration: BoxDecoration(
                  //         color: Colors.cyan.shade300,
                  //       ),
                  //       children: const [
                  //         Text(
                  //           'gcp_GLNID',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'SSCC Barcode Number',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'SSCC Type',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          dataRowColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.08);
                              }
                              return Colors.white;
                            },
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          dividerThickness: 2,
                          border: const TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          columns: const [
                            DataColumn(
                              label: TableHeaderText(text: 'gcp_GLNID'),
                            ),
                            DataColumn(
                              label:
                                  TableHeaderText(text: 'SSCC Barcode Number'),
                            ),
                            DataColumn(
                              label: TableHeaderText(text: 'SSCC Type'),
                            ),
                          ],
                          rows: snap!
                              .map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(Text(e.gcpGLNID.toString())),
                                    DataCell(
                                        Text(e.sSCCBarcodeNumber.toString())),
                                    DataCell(Text(e.ssccType.toString())),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 10),
                  // Expanded(
                  //     child: ListView.builder(
                  //   itemCount: snap?.length ?? 0,
                  //   itemBuilder: (context, index) {
                  //     return Table(
                  //       // border: TableBorder.symmetric(
                  //       //   inside: const BorderSide(
                  //       //     width: 1,
                  //       //     color: Colors.black,
                  //       //   ),
                  //       // ),
                  //       defaultVerticalAlignment:
                  //           TableCellVerticalAlignment.top,
                  //       children: [
                  //         TableRow(
                  //           decoration: BoxDecoration(
                  //             border: const Border(
                  //               bottom: BorderSide(
                  //                 color: Colors.black,
                  //                 width: 1,
                  //               ),
                  //               top: BorderSide(
                  //                 color: Colors.black,
                  //                 width: 1,
                  //               ),
                  //             ),
                  //             boxShadow: [
                  //               BoxShadow(color: Colors.grey.shade200),
                  //             ],
                  //             shape: BoxShape.rectangle,
                  //             gradient: SweepGradient(colors: [
                  //               Colors.grey.shade300,
                  //               Colors.grey.shade200,
                  //               Colors.grey.shade300,
                  //             ]),
                  //           ),
                  //           children: [
                  //             Text('${snap?[index].gcpGLNID}'),
                  //             Text('${snap?[index].sSCCBarcodeNumber}'),
                  //             Text('${snap?[index].ssccType}'),
                  //           ],
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
