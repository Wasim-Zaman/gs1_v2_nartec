import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/ingredientsModel.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:hiring_task/widgets/custom_appbar_widget.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';
import 'package:http/http.dart' as http;

class LogisticInformationScreen extends StatelessWidget {
  const LogisticInformationScreen({super.key});

  static const routeName = '/logistic-information';

  Future<IngredientsModel> getFutureData(BuildContext context) async {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String? id = args['id'];
    final String? gtin = args['gtin'];

    final response = await http.post(
      Uri.parse(URL.digitalLink),
      body: json.encode(
        {
          "gtin": gtin ?? 6281000000113,
          "digitalLinkType": "tblProductContents",
          "ID": id,
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'] as List;
      final data = IngredientsModel.fromJson(responseData[0]);

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // final String gtin = args['gtin'];
    final ProductContentsListModel dataModel = args['dataModel'];
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: FutureBuilder(
        future: getFutureData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data;

          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customAppBarWidget(title: "Logistic Information"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageWidget(imageUrl: dataModel.productImageUrl),
                        const SizedBox(height: 10),
                        Text(
                          "${dataModel.productName} - ${dataModel.productDescription}",
                          softWrap: true,
                          style: const TextStyle(
                            color: purpleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "GTIN: ${dataModel.gtin}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomListTileWidget(
                          heading: "GLNID",
                          data: dataModel.gcpGLNID,
                        ),
                        CustomListTileWidget(
                          heading: "Batch",
                          data: data?.batch,
                        ),
                        CustomListTileWidget(
                          heading: "Expiry",
                          data: data?.expiry,
                        ),
                        CustomListTileWidget(
                          heading: "Manuf. Date",
                          data: data?.manufacturingDate,
                        ),
                        CustomListTileWidget(
                          heading: "Best Before Date",
                          data: data?.bestBeforeDate,
                        ),
                        CustomListTileWidget(
                          heading: "Serial Number",
                          data: data?.serial,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    this.heading,
    this.data,
  });

  final String? heading;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              heading ?? "Heading",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(data ?? "Data"),
          ),
        ],
      ),
    );
  }
}
