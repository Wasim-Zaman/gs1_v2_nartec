import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/view-model/ingredients/ingredients_services.dart';
import 'package:hiring_task/view/screens/ingredients_and_allergens_scree.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view/screens/logistic_information_screen.dart';

class LogisticInfoGridScreen extends StatelessWidget {
  static const routeName = "/logistic_info_grid_screen";
  const LogisticInfoGridScreen({super.key});

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
              future: IngredientsServices.getFutureData(
                context,
                gtin: dataModel.gtin,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data;
                final dataModel = ModalRoute.of(context)!.settings.arguments
                    as ProductContentsListModel;
                return data == null
                    ? const Center(child: Text('No data found'))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              LogisticInformationScreen.routeName,
                              arguments: {
                                "id": data[index].iD,
                                "gtin": dataModel.gtin,
                                'dataModel': dataModel,
                              },
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
                                leading: CircleAvatar(
                                  backgroundColor: darkBlue,
                                  child: Text(
                                    data[index].iD.toString(),
                                    style: const TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  data[index].productAllergenInformation ??
                                      "null",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
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
