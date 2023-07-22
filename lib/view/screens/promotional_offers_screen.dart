import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/promotional_offers_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class PromotionalOffersScreen extends StatelessWidget {
  PromotionalOffersScreen({super.key});
  static const routeName = "/promotional-offer";

  List<PromotionalOffersModel> futureData = [];

  Future<List<PromotionalOffersModel>> getFutureData(
      BuildContext context) async {
    final response = await http.post(Uri.parse(URL.digitalLink),
        body: json.encode({
          "gtin": 6281000000113,
          "digitalLinkType": "tblPromotionalOffers",
        }),
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'];
      for (var i = 0; i < responseData.length; i++) {
        futureData.add(PromotionalOffersModel.fromJson(responseData[i]));
      }
      return futureData;
    } else {
      return futureData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Promotional Offers"),
      ),
      body: FutureBuilder(
        future: getFutureData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          "Product ID: ${data[index].iD}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Language: ${data[index].lang}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Target URL: ${data[index].targetURL}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "GTIN:\t ${data[index].gTIN}",
                          softWrap: true,
                        ),
                        const SizedBox(height: 10),
                        Card(
                          child: ListTile(
                            title: const Text('Expiry Date'),
                            subtitle: Text("${data[index].expiryDate}"),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "LinkType:\n ${data[index].linkType}",
                          softWrap: true,
                        ),
                        const SizedBox(height: 60),
                      ],
                    );
                  },
                  itemCount: data!.length,
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
