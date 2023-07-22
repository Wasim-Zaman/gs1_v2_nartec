import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hiring_task/constants/icons/app_icons.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/view-model/login/after-login/create_ticker_service.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';
import 'package:hiring_task/widgets/images/image_widget.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});
  static const String routeName = 'create-ticket-screen';

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  // scaffold key
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? file;
  String? fileName;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    formKey.currentState?.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  String getFileName(String fileName) {
    return fileName.length > 15
        ? "${fileName.substring(0, 15)}---  ${fileName.substring(
            fileName.length - 4,
            fileName.length,
          )}"
        : fileName;
  }

  Future chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      file = File(result.files.single.path ?? "");
      setState(() {
        fileName = file?.path.split('/').last;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final response = args['response'] as DashboardModel;
    final userId = args['userId'];
    return WillPopScope(
      onWillPop: () async {
        scaffoldKey.currentState?.openDrawer();
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Create Ticket"),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        drawer: CustomDrawerWidget(
          userId: response.memberData?.user?.id ?? userId,
          response: response,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(context,
                  imageUrl: "assets/images/create_ticket_image.png"),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequiredTextWidget(
                        title: "Title",
                      ),
                      TextFormField(
                        controller: titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter title";
                          }
                          return null;
                        },
                        focusNode: titleFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          titleFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(descriptionFocusNode);
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const RequiredTextWidget(
                        title: "Description",
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 7,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter description";
                          }
                          return null;
                        },
                        focusNode: descriptionFocusNode,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onFieldSubmitted: (value) {
                          descriptionFocusNode.unfocus();
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const RequiredTextWidget(title: "Documents/Screenshots"),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await chooseFile();
                              },
                              icon: Image.asset(
                                  '${AppIcons.createTicketIconsBasePath}upload_icon.png'),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              fileName != null
                                  ? getFileName(fileName!)
                                  : "Browse folders / choose files",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.25,
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              if (file == null) {
                                Common.showToast(
                                  "Please choose file",
                                  backgroundColor: Colors.red,
                                );
                              } else {
                                Common.showToast(
                                  "Please wait...",
                                );
                                await CreateTicketService.createTicket(
                                  description: descriptionController.text,
                                  title: titleController.text,
                                  file: file,
                                  userId: userId.toString(),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                            fixedSize: const Size(double.infinity, 50),
                          ),
                          label: const Text("Save"),
                          icon: const Icon(
                            Icons.save_outlined,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
