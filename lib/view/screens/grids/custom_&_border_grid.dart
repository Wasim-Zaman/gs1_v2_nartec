// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/recipe/recipe_grid_services.dart';
import 'package:hiring_task/view/screens/recipe_screen.dart';

class CustomAndBorderGridScreen extends StatelessWidget {
  const CustomAndBorderGridScreen({super.key});
  static const routeName = "/custom-and-border-grid";

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
      body: FutureBuilder(
        future: RecipeGridServices.getFutureData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final recipeModel = snapshot.data;

          return ListView.builder(
            itemCount: recipeModel!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  RecipeScreen.routeName,
                  arguments: recipeModel[index],
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
                      recipeModel[index].title!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    subtitle: Text(
                      recipeModel[index].description!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 15),
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
