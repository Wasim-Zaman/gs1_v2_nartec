import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:hiring_task/constants/icons/app_icons.dart';
import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/models/login-models/profile/member_profile_model.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/app_dialogs.dart';
import 'package:hiring_task/view-model/login/after-login/profile/member_profile_services.dart';
import 'package:hiring_task/view-model/login/after-login/validate_cr_services.dart';
import 'package:hiring_task/view/screens/log-in/widgets/text_widgets/primary_text_widget.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/widgets/buttons/primary_button_widget.dart';
import 'package:hiring_task/widgets/custom_drawer_widget.dart';
import 'package:hiring_task/widgets/images/image_widget.dart';
import 'package:hiring_task/widgets/loading/loading_widget.dart';
import 'package:hiring_task/widgets/required_text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key});
  static const String routeName = 'member-profile-screen';

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  late Map? args;
  late DashboardModel? response;
  late int? userId;
  String? title = 'Member Details';
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    response = args?['response'];
    userId = args?['userId'];
    return WillPopScope(
      onWillPop: () async {
        _scaffoldKey.currentState?.openDrawer();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(title!),
        ),
        drawer: CustomDrawerWidget(
          userId: response?.memberData?.user?.id ?? userId,
          response: response,
        ),
        body: FutureBuilder(
          future: MemberProfileServices.getMemberProfile(userId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            }
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  Text(snapshot.error.toString()),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh The Page"),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    Text(snapshot.error.toString()),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh The Page"),
                    ),
                  ],
                ),
              );
            }
            final MemberProfileModel? memberProfileModel = snapshot.data;
            return SizedBox.expand(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  if (_selectedIndex == 0) {
                    title = 'Member Details';
                  } else if (_selectedIndex == 1) {
                    title = 'Member Profile';
                  }
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: <Widget>[
                  _selectedIndex == 0
                      ? DetailsScreen(
                          memberProfileModel: memberProfileModel,
                        )
                      : ProfileScreen(
                          memberProfileModel: memberProfileModel,
                          userId: userId.toString(),
                        ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              title = 'Member Details';
            } else if (_selectedIndex == 1) {
              title = 'Member Profile';
            }
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Details'),
              activeColor: Theme.of(context).primaryColor,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.memberProfileModel, this.userId});
  final MemberProfileModel? memberProfileModel;
  final String? userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final otherMobileController = TextEditingController();
  final otherLandlineController = TextEditingController();
  final districtController = TextEditingController();
  final websiteController = TextEditingController();
  final noOfStaffController = TextEditingController();
  final buildingNoController = TextEditingController();
  final unitNoController = TextEditingController();
  final qrCodeNoController = TextEditingController();
  final companyIdController = TextEditingController();
  final mobileExtensionController = TextEditingController();
  final countryNameController = TextEditingController();
  final crNumberController = TextEditingController();
  final activitiesController = TextEditingController();

  File? imageFile;
  String? imageFileName;
  File? addressImageFile;
  String? addressImageFileName;

  String? img, addImg;

  bool isValidate = false;

  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final MemberProfileModel? memberProfileModel = widget.memberProfileModel;
    final profile = memberProfileModel?.memberProfile;

    addressLine1Controller.text = profile?.address1 ?? '';
    otherMobileController.text = profile?.additionalNumber ?? '';
    otherLandlineController.text = profile?.otherLandline ?? '';
    districtController.text = profile?.district ?? '';
    websiteController.text = profile?.website ?? '';
    noOfStaffController.text = profile?.noOfStaff ?? '';
    buildingNoController.text = profile?.buildingNo ?? '';
    unitNoController.text = profile?.unitNumber ?? '';
    qrCodeNoController.text = profile?.qrCorde ?? '';
    companyIdController.text = profile?.companyID ?? '';
    countryNameController.text = profile?.address?.countryName ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState?.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    otherMobileController.dispose();
    otherLandlineController.dispose();
    districtController.dispose();
    websiteController.dispose();
    noOfStaffController.dispose();
    buildingNoController.dispose();
    unitNoController.dispose();
    qrCodeNoController.dispose();
    companyIdController.dispose();
    mobileExtensionController.dispose();
    countryNameController.dispose();
    crNumberController.dispose();
    activitiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    img =
        "${widget.memberProfileModel?.memberProfile?.imagePath}/${widget.memberProfileModel?.memberProfile?.image}";
    addImg =
        "${widget.memberProfileModel?.memberProfile?.imagePath}/${widget.memberProfileModel?.memberProfile?.addressImage}";

    Common.urlToFile(img!).then((value) => imageFile = value);
    Common.urlToFile(addImg!).then((value) => addressImageFile = value);

    return WillPopScope(
      onWillPop: () {
        // Navigator.pop(context);
        _scaffoldKey.currentState?.openDrawer();
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionPanelList.radio(
                animationDuration: const Duration(seconds: 1),
                children: [
                  ExpansionPanelRadio(
                    value: 1,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}image_section.png"),
                        title: const Text(
                          'Image',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Stack(
                      fit: StackFit.loose,
                      children: [
                        imageFile?.path != null
                            ? Image.file(
                                imageFile!,
                                width: 256,
                                height: 256,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                img ?? "",
                                height: 256,
                                width: 256,
                                filterQuality: FilterQuality.high,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const LoadingWidget();
                                },
                                // frameBuilder: (context, child, frame,
                                //         wasSynchronouslyLoaded) =>
                                //     LoadingAnimationWidget.threeArchedCircle(
                                //   color: Colors.pink,
                                //   size: 50,
                                // ),
                                cacheHeight: 256,
                                cacheWidth: 256,
                                errorBuilder: (context, error, stackTrace) =>
                                    Placeholder(
                                  color: Colors.pink.shade400,
                                  fallbackHeight: 256,
                                  fallbackWidth: 256,
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) {
                                  if (value == null) return;
                                  setState(() {
                                    imageFile = File(value.path);
                                    imageFileName = value.path.split('/').last;
                                  });
                                });
                              },
                              child: const Text('Choose Image'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 2,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}company_details_section.png"),
                        title: const Text('Company Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(
                                title: "Company Name [English]"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.companyNameEng,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(
                                title: "Company Name [Arabic]"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.companyNameArabic,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Mobile"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget
                                  .memberProfileModel?.memberProfile?.mobile,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Extension"),
                            TextFormField(
                              enabled: true,
                              controller: mobileExtensionController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 3,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}country_details_section.png"),
                        title: const Text(
                          'Country Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "County"),
                            TextField(
                              enabled: true,
                              controller: countryNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(
                                title: "Country Short Name"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.address?.countryShortName,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "State"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.address?.stateName,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "City"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.address?.cityName,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 4,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}country_zip_and_mobile_section.png"),
                        title: const Text(
                          'Country Zip, & Mobile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "Zip"),
                            TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget.memberProfileModel
                                  ?.memberProfile?.address?.zip,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Address Line 1"),
                            TextFormField(
                              enabled: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              initialValue: widget
                                  .memberProfileModel?.memberProfile?.address1,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(
                                title: "Other Mobile Number"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          showCountryPicker(
                                              context: context,
                                              onSelect: (Country country) {
                                                otherMobileController.text =
                                                    "+${country.phoneCode}";
                                              });
                                        },
                                        icon: Icon(
                                          Icons.flag_sharp,
                                          size: 40,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    controller: otherMobileController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter mobile number";
                                      }
                                      if (value.length < 13 ||
                                          value.length > 13) {
                                        return "Please enter valid mobile number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 5,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}other_details_section.png"),
                        title: const Text(
                          'Other Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(
                                title: "Other Landline Number"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          showCountryPicker(
                                              context: context,
                                              onSelect: (Country country) {
                                                otherLandlineController.text =
                                                    "+${country.phoneCode}";
                                              });
                                        },
                                        icon: Icon(
                                          Icons.flag_sharp,
                                          size: 40,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    controller: otherLandlineController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter mobile number";
                                      }
                                      if (value.length < 13 ||
                                          value.length > 13) {
                                        return "Please enter valid mobile number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "District"),
                            TextFormField(
                              controller: districtController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Website"),
                            CustomTextField(
                              hintText: "Website",
                              controller: websiteController,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 6,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}building_and_unit_section.png"),
                        title: const Text(
                          'Building & Unit',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "Building Number"),
                            CustomTextField(
                              hintText: "Building Number",
                              controller: buildingNoController,
                            ),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Unit Number"),
                            CustomTextField(
                              hintText: "Unit Number",
                              controller: unitNoController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 7,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}qrcode_section.png"),
                        title: const Text(
                          'QR Code',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "QR-Code Number"),
                            CustomTextField(
                              hintText: "QR-Code Number",
                              controller: qrCodeNoController,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 8,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}company_id_section.png"),
                        title: const Text(
                          'Company ID',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "Company Id"),
                            CustomTextField(
                              hintText: "Company Id",
                              controller: companyIdController,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ExpansionPanelRadio(
                    value: 9,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        leading: Image.asset(
                            "${AppIcons.membershipIconsBasePath}company_id_section.png"),
                        title: const Text(
                          'CR Number and Activities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RequiredTextWidget(title: "CR Number"),
                            CustomTextField(
                              hintText: "CR Number",
                              controller: crNumberController,
                              readOnly: false,
                            ),
                            const SizedBox(height: 10),
                            PrimaryButtonWidget(
                              onPressed: () async {
                                // call api to validate cr number
                                if (crNumberController.text.trim().isEmpty) {
                                  Common.showToast("Please enter CR Number");
                                  return;
                                }
                                AppDialogs.loadingDialog(context);
                                isValidate =
                                    await ValidateCrServices.validateCr(
                                        crNumberController.text);
                                if (isValidate) {
                                  AppDialogs.closeDialog();
                                  Common.showToast(
                                      "CR Number is valided, you can now update",
                                      backgroundColor: Colors.green);
                                } else {
                                  AppDialogs.closeDialog();
                                  Common.showToast(
                                      "CR Number is not valid, please enter valid CR Number",
                                      backgroundColor: Colors.red);
                                }
                              },
                              caption: "Validate CR Number",
                            ).box.make().wFull(context),
                            const SizedBox(height: 10),
                            const RequiredTextWidget(title: "Activities"),
                            CustomTextField(
                              hintText: "Activities",
                              controller: activitiesController,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    // close the application
                    FlutterExitApp.exitApp();
                  },
                  leading: Image.asset(
                    "${AppIcons.membershipIconsBasePath}logout_section.png",
                  ),
                  title: const Text(
                    "Log out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Address Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    addressImageFile?.path != null
                        ? Image.file(addressImageFile!)
                        : Image.network(
                            addImg ?? "",
                            height: 80,
                            width: 80,

                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.image_outlined,
                              size: 80,
                            ),
                            cacheHeight: 80,
                            cacheWidth: 80,
                            // loadingBuilder: (context, child, loadingProgress) =>
                            //     LoadingAnimationWidget.prograssiveDots(
                            //   color: Colors.pink,
                            //   size: 30,
                            // ),
                          ),
                    TextButton(
                      onPressed: () async {
                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          if (value == null) return;
                          setState(() {
                            addressImageFile = File(value.path);
                            addressImageFileName = value.path.split('/').last;
                          });
                        });
                      },
                      child: const Text(
                        'Upload',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (isValidate) {
              AppDialogs.loadingDialog(context);
              await update(context);
              AppDialogs.closeDialog();
            } else {
              Common.showToast("Please validate CR Number");
            }
          },
          label: const Text('Update'),
          icon: const Icon(Icons.update),
        ),
      ),
    );
  }

  update(BuildContext context) async {
    if (imageFile == null && addressImageFile == null) {
      Common.showToast('Please select image');
      return;
    }
    AppDialogs.loadingDialog(context);
    try {
      final int status = await MemberProfileServices.updateProfile(
        userId: widget.userId,
        image: imageFile,
        addressImage: addressImageFile,
        additionalNo: otherMobileController.text,
        address1: addressLine1Controller.text,
        address: addressLine2Controller.text,
        buildingNo: widget.memberProfileModel?.memberProfile?.buildingNo,
        companyNameEng:
            widget.memberProfileModel?.memberProfile?.companyNameEng,
        companyNameAr:
            widget.memberProfileModel?.memberProfile?.companyNameArabic,
        mobile: widget.memberProfileModel?.memberProfile?.mobile,
        mobileExtension: mobileExtensionController.text,
        countryName: countryNameController.text,
        cityName: widget.memberProfileModel?.memberProfile?.address?.cityName,
        countryShortName:
            widget.memberProfileModel?.memberProfile?.address?.countryShortName,
        stateName: widget.memberProfileModel?.memberProfile?.address?.stateName,
        zip: widget.memberProfileModel?.memberProfile?.address?.zip,
        otherLandline: otherLandlineController.text,
        district: districtController.text,
        website: websiteController.text,
        companyId: companyIdController.text,
        numberOfStaff: noOfStaffController.text,
        qrCode: qrCodeNoController.text,
        unitNo: unitNoController.text,
      );

      AppDialogs.closeDialog();
      if (status == 200) {
        Common.showToast(
          'Successfully Updated Profile',
          backgroundColor: Colors.purple,
        );
      } else {
        Common.showToast(
          'Failed to Update Profile',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      AppDialogs.closeDialog();
      Common.showToast(
        'Failed to Update Profile',
        backgroundColor: Colors.red,
      );
    }
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.memberProfileModel,
  });

  final MemberProfileModel? memberProfileModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // body: ListView(
        //   children: [
        //     ExpansionTile(
        //       initiallyExpanded: false,
        //       clipBehavior: Clip.hardEdge,
        //       childrenPadding: const EdgeInsets.all(10),
        //       title: const Text(
        //         'Company Information',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           // color: Colors.white,
        //           fontSize: 20,
        //         ),
        //       ),
        //       backgroundColor: Colors.pink.shade100,
        //       collapsedBackgroundColor: Colors.pink[300],
        //       children: [
        //         TwoTextWidget(
        //           title: "CR Number",
        //           subTitle: memberProfileModel?.memberDetails?.crNumber,
        //         ),
        //         TwoTextWidget(
        //           title: "CR Document",
        //           subTitle: memberProfileModel?.memberDetails?.crDocument,
        //         ),
        //         TwoTextWidget(
        //           title: "Company Name [English]",
        //           subTitle: memberProfileModel?.memberProfile?.companyNameEng,
        //         ),
        //         TwoTextWidget(
        //           title: "Company GCP",
        //           subTitle: memberProfileModel?.memberDetails?.companyGcp,
        //         ),
        //         TwoTextWidget(
        //           title: "Mobile",
        //           subTitle: memberProfileModel?.memberProfile?.mobile,
        //         ),
        //         TwoTextWidget(
        //           title: "Membership Type",
        //           subTitle: memberProfileModel?.memberDetails?.memberCategory,
        //         ),
        //         const SizedBox(height: 20),
        //         const Text(
        //           'Products',
        //           style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Column(
        //           children: [
        //             FittedBox(
        //               child: Row(
        //                 children: memberProfileModel?.memberDetails?.products
        //                         ?.map((e) => FittedBox(
        //                               child: Container(
        //                                 margin: const EdgeInsets.all(5),
        //                                 padding: const EdgeInsets.all(5),
        //                                 decoration: BoxDecoration(
        //                                   color: Colors.pink.shade300,
        //                                   borderRadius: BorderRadius.circular(10),
        //                                 ),
        //                                 child: Text(e),
        //                               ),
        //                             ))
        //                         .toList() ??
        //                     [],
        //               ),
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //     ExpansionTile(
        //       initiallyExpanded: false,
        //       clipBehavior: Clip.hardEdge,
        //       childrenPadding: const EdgeInsets.all(10),
        //       title: const Text(
        //         'Company Activity',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           // color: Colors.white,
        //           fontSize: 20,
        //         ),
        //       ),
        //       backgroundColor: Colors.purple.shade100,
        //       collapsedBackgroundColor: Colors.purple[300],
        //       children: [
        //         TwoTextWidget(
        //           title: "CR Activity",
        //           subTitle: memberProfileModel?.memberDetails?.crActivity,
        //         ),
        //         TwoTextWidget(
        //           title: "CR Document Number",
        //           subTitle: memberProfileModel?.memberDetails?.documentNumber,
        //         ),
        //         TwoTextWidget(
        //           title: "Company Name [Arabic]",
        //           subTitle: memberProfileModel?.memberProfile?.companyNameArabic,
        //         ),
        //         TwoTextWidget(
        //           title: "Contact Person Name",
        //           subTitle: memberProfileModel?.memberDetails?.contactPerson,
        //         ),
        //         TwoTextWidget(
        //           title: "Company Landline",
        //           subTitle: memberProfileModel?.memberDetails?.companyLandLine,
        //         ),
        //         TwoTextWidget(
        //           title: "GCP (GLOBAL PRODUCT CLASSIFICATION)",
        //           subTitle: memberProfileModel?.memberDetails?.gpc,
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Text(
                "Company Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Company Activities",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ImageWidget(
                      context,
                      imageUrl: "assets/images/company_information_image.png",
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    Row(
                      children: [
                        const PrimaryTextWidget(text: "CR Number: "),
                        PrimaryTextWidget(
                          text: memberProfileModel?.memberDetails?.crNumber ??
                              "null",
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    Row(
                      children: [
                        const PrimaryTextWidget(text: "CR Document: "),
                        PrimaryTextWidget(
                          text: memberProfileModel
                                  ?.memberDetails?.documentNumber ??
                              "null",
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Company Name [Eng]:"),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberProfile?.companyNameEng ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    Row(
                      children: [
                        const PrimaryTextWidget(text: "Company GCP: "),
                        PrimaryTextWidget(
                          text: memberProfileModel?.memberDetails?.companyGcp ??
                              "null",
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    Row(
                      children: [
                        const PrimaryTextWidget(text: "Mobile: "),
                        PrimaryTextWidget(
                          text: memberProfileModel?.memberProfile?.mobile ??
                              "null",
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Membership Type: "),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberDetails?.memberCategory ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Products: "),
                    Column(
                      children: [
                        FittedBox(
                          child: Row(
                            children: memberProfileModel
                                    ?.memberDetails?.products
                                    ?.map((e) => FittedBox(
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList() ??
                                [],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    ImageWidget(
                      context,
                      imageUrl: "assets/images/company_activity_image.png",
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "CR Activity: "),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberDetails?.crActivity ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "CR Document Number: "),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberDetails?.crDocument ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Company Name [Arabic]: "),
                    PrimaryTextWidget(
                      text: memberProfileModel
                              ?.memberProfile?.companyNameArabic ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Contact Person: "),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberDetails?.contactPerson ??
                          "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "Company Landline: "),
                    PrimaryTextWidget(
                      text:
                          memberProfileModel?.memberDetails?.companyLandLine ??
                              "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                    const PrimaryTextWidget(text: "GCP: "),
                    PrimaryTextWidget(
                      text: memberProfileModel?.memberDetails?.gpc ?? "null",
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoTextWidget extends StatelessWidget {
  const TwoTextWidget({
    super.key,
    this.title,
    this.subTitle,
  });

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title ?? "null",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subTitle ?? 'null',
        ),
        const SizedBox(height: 15),
        const Divider(thickness: 1),
      ],
    );
  }
}
