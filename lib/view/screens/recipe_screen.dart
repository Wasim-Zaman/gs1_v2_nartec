import 'package:flutter/material.dart';
import 'package:hiring_task/models/recipe_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  static const routeName = '/recipe-screen';

  @override
  Widget build(BuildContext context) {
    final recipeModel =
        ModalRoute.of(context)!.settings.arguments as RecipeModel;
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('Recipes'),
                backgroundColor: purpleColor.shade600,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Screen(
                  title: "${recipeModel.title}",
                  imageUrl: recipeModel.logo,
                  ingredients: recipeModel.ingredients,
                  description: recipeModel.description,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.imageUrl,
    this.title,
    this.ingredients,
    this.description,
  });

  final String? imageUrl;
  final String? title;
  final String? ingredients;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image
        CustomImageWidget(imageUrl: imageUrl),
        // second section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const Text(
              'From our chef:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: pinkColor,
                  fontStyle: FontStyle.italic),
              softWrap: true,
            ),
            const SizedBox(height: 10),
            // description
            Text(
              title ?? 'Pumpkin And Mashroom Risotto',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: purpleColor,
              ),
              softWrap: true,
            ),
            // amount
            Text(
              description ??
                  'Dal Fiardino Mushroom Rice with Mushrooms is great on its own, but you can also use it as an ingredient in many dishes like this great for Wild Squash and Mushroom Risotto. And it is so simple to do',
              style: const TextStyle(
                fontSize: 15,
              ),
              softWrap: true,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 5,
            ),
          ],
        ),
        // third section
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ingredients",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              // ingredients
              Text(
                ingredients ?? '1 cup of rice',
                style: const TextStyle(
                  fontSize: 15,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
