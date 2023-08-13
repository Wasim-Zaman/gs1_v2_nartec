// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/models/safety_info_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/product-safety/product_safety_services.dart';
import 'package:hiring_task/view/screens/safety_information_screen.dart';

class ProductSafetyGrid extends StatelessWidget {
  static const routeName = "/product-safety-grid-screen";
  const ProductSafetyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductContentsListModel dataModel =
        ModalRoute.of(context)!.settings.arguments as ProductContentsListModel;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: darkBlue,
          foregroundColor: whiteColor,
          title: Column(
            children: [
              const Text("GTIN:"),
              Text(dataModel.gtin!),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: dataModel == null
          ? const Center(
              child: Text("Data list is empty"),
            )
          : FutureBuilder(
              future: ProductSafetyServices.getFutureData(context,
                  gtin: dataModel.gtin!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final List<SafetyInfoModel>? safetyModel = snapshot.data;

                return safetyModel == null
                    ? const Center(child: Text("No data found"))
                    : ListView.builder(
                        itemCount: safetyModel.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              SafetyInformationScreen.routeName,
                              arguments: safetyModel,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Card(
                              elevation: 5,
                              shadowColor: darkBlue,
                              child: ListTile(
                                title: Text(
                                  "${safetyModel[index].safetyDetailedInformation}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
                                // subtitle: Text(
                                //   "${safetyModel[index].process}",
                                //   textAlign: TextAlign.justify,
                                //   style: const TextStyle(fontSize: 15),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
    );
  }
}
