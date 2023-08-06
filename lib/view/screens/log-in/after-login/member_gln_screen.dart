import 'package:flutter/material.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/view-model/login/after-login/gln_services.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_widgets/table_header_text.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';
import 'package:hiring_task/widgets/loading/loading_widget.dart';

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
          elevation: 0,
        ),
        body: FutureBuilder(
          future: GLNServices.getGLN(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
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
                  SizedBox(
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
                                label: TableHeaderText(text: 'gpc_GLNID'),
                              ),
                              DataColumn(
                                label: TableHeaderText(
                                    text: 'Location Name [Eng]'),
                              ),
                              DataColumn(
                                label:
                                    TableHeaderText(text: 'Location Name [Ar]'),
                              ),
                              DataColumn(
                                label: TableHeaderText(text: 'GLN Barcode'),
                              ),
                            ],
                            rows: snap!.map<DataRow>((e) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(e.gcpGLNID ?? ''),
                                  ),
                                  DataCell(
                                    Text(e.locationNameEn ?? ''),
                                  ),
                                  DataCell(
                                    Text(e.locationNameAr ?? ''),
                                  ),
                                  DataCell(
                                    Text(e.gLNBarcodeNumber ?? ''),
                                  ),
                                ],
                              );
                            }).toList()),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
