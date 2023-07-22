// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/base-api/base_api_service.dart';
import 'package:hiring_task/view-model/gtin-reporter/gtin_reporter_services.dart';
import 'package:hiring_task/view/screens/widgets/expansion_row_widget.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';

class GtinReporterScreen extends StatelessWidget {
  static const routeName = "/gtin-reporter";
  const GtinReporterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "GS1 Saudi Arabia",
          style: TextStyle(
            color: darkBlue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: darkBlue,
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Screen(),
          ),
        ],
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController reportBarcodeController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  ProductContentsListModel? data;
  String? selectedOption;

  // List of Images
  List<File>? imageList = [];
  List<String>? imageListUrl = [];
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
            future: BaseApiService.getData(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {}
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageWidget(imageUrl: data?.productImageUrl),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data?.productName} - ${data?.productDescription}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // gtin
                        Text(
                          "GTIN: ${data?.gtin}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridWidget(
                    gtinNumber: data?.gtin.toString(),
                    productBrand: data?.brandName,
                    productDescription: data?.productDescription,
                    productImageUrl: data?.productImageUrl,
                    globalProductCategory: data?.gpcCategoryCode,
                    netContent: data?.gcpGLNID,
                    countryOfSale: data?.countryOfSaleCode,
                  ),
                  const Divider(thickness: 2),
                ],
              );
            }),

        const SizedBox(height: 10),
        // Comments section
        const CustomTextWidget(text: "Write your comment here"),
        TextFormField(
          maxLines: 5,
          controller: _commentController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        const CustomTextWidget(text: "Report Barcode"),
        TextFormField(
          maxLines: 3,
          controller: reportBarcodeController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        const CustomTextWidget(text: "Mobile Number"),
        TextFormField(
          controller: mobileNoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        const CustomTextWidget(text: "Email"),
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        // action section
        const CustomTextWidget(text: "Select your action"),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: darkBlue),
          ),
          child: FittedBox(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: const FittedBox(
                  child: Text(
                    'Select an action',
                  ),
                ), // Optional text to show as a hint
                value: selectedOption,
                onChanged: (newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Photos Are Not Correct',
                    child: Text(
                      'Photos Are Not Correct',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Missing GPC Brick Code',
                    child: Text(
                      'Missing GPC Brick Code',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Brand Owner Is Incorrect',
                    child: Text(
                      'Brand Owner Is Incorrect',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Country Of Sale Is Wrong',
                    child: Text(
                      'Country Of Sale Is Wrong',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Unit Of Measuremet Is Incorrect',
                    child: Text(
                      'Unit Of Measuremet Is Incorrect',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'Product Description Not Matching On Physical Product',
                    child: Text(
                      'Product Description Not Matching On Physical Product',
                      style: TextStyle(color: darkBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // photo button
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TakePhotoButton(
              onPressed: () async {
                Common.pickFileFromCamera().then((value) {
                  imageList?.add(value!);
                  imageList?.forEach((image) {
                    Common.convertFileToWebpUrl(image)
                        .then((value) => imageListUrl?.add(value));
                    setState(() {});
                  });
                });
              },
            ),
          ],
        ),
        // multiple images
        imageList!.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList?.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            imageList![index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            child: CloseButton(
                              onPressed: () {
                                setState(() {
                                  imageList?.removeAt(index);
                                  imageListUrl?.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
        // proceed button
        const SizedBox(height: 30),
        ProceedButton(
          data: data,
          comments: _commentController.text,
          reportBarcode: reportBarcodeController.text,
          email: emailController.text,
          mobileNo: mobileNoController.text,
          option: selectedOption,
          images: imageList,
        ),
      ],
    );
  }
}

class ProceedButton extends StatelessWidget {
  const ProceedButton({
    super.key,
    this.data,
    this.comments,
    this.reportBarcode,
    this.mobileNo,
    this.email,
    this.option,
    this.images,
  });
  final ProductContentsListModel? data;
  final String? comments;
  final String? reportBarcode;
  final String? mobileNo;
  final String? email;
  final String? option;
  final List<File>? images;

  onPressed() async {
    Common.showToast("Just a moment...");
    try {
      await GtinReporterServices.proceesGtin(
        email: email,
        gtinComment: comments,
        gtinReportAction: option,
        mobileNo: mobileNo,
        reportBarcode: reportBarcode,
        reporterImages: images,
      );
      Common.showToast('Thank you for your submission!');
    } catch (e) {
      Common.showToast(e.toString(), backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.arrow_forward,
          color: whiteColor,
        ),
        onPressed: onPressed,
        label: const Text(
          "Proceed",
          style: TextStyle(
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: orangeColor,
      ),
      child: const Text('Take Photo of'),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text ?? "Write your comments here",
          style: const TextStyle(
            color: darkBlue,
            fontSize: 18,
          ),
          children: const [
            TextSpan(
              text: " *",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ]),
      softWrap: true,
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.gtinNumber,
    required this.productBrand,
    required this.productDescription,
    required this.productImageUrl,
    required this.globalProductCategory,
    required this.netContent,
    required this.countryOfSale,
  });

  final String? gtinNumber;
  final String? productBrand;
  final String? productDescription;
  final String? productImageUrl;
  final String? globalProductCategory;
  final String? netContent;
  final String? countryOfSale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionRowWidget(
          keyy: "GTIN",
          value: gtinNumber ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),
        ExpansionRowWidget(
          keyy: "Brand Name",
          value: productBrand ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),

        ExpansionRowWidget(
          keyy: "Product Description",
          value: productDescription ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),

        ExpansionRowWidget(
          keyy: "Product Image Url",
          value: productImageUrl ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),

        ExpansionRowWidget(
          keyy: "Global Product Category",
          value: globalProductCategory ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),

        ExpansionRowWidget(
          keyy: "Net Content",
          value: netContent ?? "null",
          fontSize: 18,
        ),
        const Divider(thickness: 2),

        ExpansionRowWidget(
            keyy: "Country of Sale",
            value: countryOfSale ?? "null",
            fontSize: 18),
        // CustomKeyValueWidget(
        //   heading: "GTIN",
        //   value: gtinNumber ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Brand Name",
        //   value: productBrand ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Product Description",
        //   value: productDescription ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Product Image Url",
        //   value: productImageUrl ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Global Product Category",
        //   value: globalProductCategory ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Net Content",
        //   value: netContent ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
        // CustomKeyValueWidget(
        //   heading: "Country of Sale",
        //   value: countryOfSale ?? "1234567890123",
        //   headFlex: 2,
        //   valueFlex: 3,
        // ),
      ],
    );
  }
}
