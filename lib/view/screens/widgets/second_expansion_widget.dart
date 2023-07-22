import 'package:flutter/material.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';

import 'expansion_row_widget.dart';

class SecondExpansionWidget extends StatelessWidget {
  const SecondExpansionWidget({
    super.key,
    this.gtin,
    this.brandName,
    this.imgURL,
    this.productName,
    this.productDescription,
    this.companyName,
    this.globalProductContent,
    this.netContent,
    this.countryOfSale,
  });

  final String? gtin;
  final String? brandName;
  final String? imgURL;
  final String? productName;
  final String? productDescription;
  final String? companyName;
  final String? globalProductContent;
  final String? netContent;
  final String? countryOfSale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Image.asset("assets/images/gs1-logo.png"),
          title: const Text(
            "This product is registered to:",
          ),
          subtitle: Text(
            companyName ?? "Dal Giardino Ltd.",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: blackColor,
            ),
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1),
        // a container with an image
        const SizedBox(height: 20),

        CustomImageWidget(imageUrl: imgURL),
        const SizedBox(height: 10),
        Text(
          "$productName - $productDescription",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green[900],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'GTIN',
          value: gtin ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Brand Name',
          value: brandName ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),
        ExpansionRowWidget(
          keyy: 'Image URL',
          value: imgURL ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),

        ExpansionRowWidget(
          keyy: 'Product Description',
          value: productDescription ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),

        ExpansionRowWidget(
          keyy: 'Global Product Category',
          value: globalProductContent ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),

        ExpansionRowWidget(
          keyy: 'Net Content',
          value: netContent ?? 'null',
        ),
        const Divider(color: Colors.grey, thickness: 1),

        ExpansionRowWidget(
          keyy: 'Country Of Sale',
          value: countryOfSale ?? 'null',
        ),
      ],
    );
  }
}
