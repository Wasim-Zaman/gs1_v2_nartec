// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/view-model/base-api/base_api_service.dart';
import 'package:hiring_task/view/screens/widgets/expansion_row_widget.dart';
import 'package:hiring_task/widgets/custom_appbar_widget.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';

class VerifyByGS1Screen extends StatelessWidget {
  const VerifyByGS1Screen({super.key});
  static const routeName = "/verify_by_gs1_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: FutureBuilder(
        future: BaseApiService.getData(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          return Screen(
            countryOfSale: data?.countryOfSaleCode,
            globalProductCategory: data?.gpcCategoryCode,
            gtinNumber: data?.gtin,
            netContent: data?.gcpGLNID,
            productBrand: data?.brandName,
            productDescription: data?.productDescription,
            productImageUrl: data?.productImageUrl,
            data: data,
          );
        },
      ),
    );
  }
}

class Screen extends StatelessWidget {
  Screen({
    super.key,
    this.productImageUrl,
    this.gtinNumber,
    this.productDescription,
    this.productBrand,
    this.globalProductCategory,
    this.netContent,
    this.countryOfSale,
    this.data,
  });

  final String? productImageUrl;
  final String? gtinNumber;
  final String? productDescription;
  final String? productBrand;
  final String? globalProductCategory;
  final String? netContent;
  final String? countryOfSale;
  ProductContentsListModel? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                    customAppBarWidget(
                      backgroundColor: Colors.green.shade400,
                      title: "GS1 Saudi Arabia",
                    ),
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
                            "GTIN: ${data?.gtin ?? "6281000000113"}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 2),
                  ],
                );
              }),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GridWidget(
                  gtinNumber: gtinNumber,
                  productBrand: productBrand,
                  productDescription: productDescription,
                  productImageUrl: productImageUrl,
                  globalProductCategory: globalProductCategory,
                  netContent: netContent,
                  countryOfSale: countryOfSale,
                ),
              ],
            ),
          ),
        ],
      ),
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

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        leading: Image.asset(
          "assets/images/gs1-logo.png",
          width: 100,
        ),
        title: const Text(
          "Complete Data",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "This number is registered to company. Al Wifaq Factory For Children Cosmetics",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
