import 'package:hiring_task/view-model/base-api/base_api_service.dart';
import 'package:hiring_task/widgets/custom_appbar_widget.dart';

import 'widgets/item.dart';

import 'package:flutter/material.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';

import 'widgets/expansion_panel_widget.dart';
import 'widgets/first_expansion_widget.dart';
import 'widgets/second_expansion_widget.dart';

class CustomAndBorderCheckScreen extends StatelessWidget {
  const CustomAndBorderCheckScreen({super.key});
  static const routeName = '/custom-&-border-check-Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: FutureBuilder(
        future: BaseApiService.getData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data found'),
            );
          }
          final data = snapshot.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  customAppBarWidget(
                    backgroundColor: Colors.green[900],
                    title: "Custom & Border Check",
                  ),
                  ExpansionPanelWidget(
                    items: [
                      Item(
                        headers: 'Company Verification',
                        body: FirstExpansionWidget(
                          companyName: data?.companyName,
                          licenseKey: data?.licenceKey,
                          licenseType: data?.licenceType,
                          companyAddress: data?.address,
                          companyWebsite: data?.website,
                          globalLocationNumber: data?.gcpGLNID,
                        ),
                        isExpanded: false,
                      ),
                    ],
                  ),
                  ExpansionPanelWidget(
                    items: [
                      Item(
                        headers: 'Product Verification',
                        body: SecondExpansionWidget(
                          brandName: data?.brandName,
                          gtin: data?.gtin,
                          imgURL: data?.productImageUrl,
                          productName: data?.productName,
                          productDescription: data?.productDescription,
                          companyName: data?.companyName,
                          countryOfSale: data?.countryOfSaleCode,
                          globalProductContent: data?.gpcCategoryCode,
                          netContent: data?.gcpGLNID,
                        ),
                        isExpanded: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
