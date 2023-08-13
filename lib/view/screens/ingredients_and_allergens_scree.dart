import 'package:flutter/material.dart';
import 'package:hiring_task/models/ingredientsModel.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';
import 'package:hiring_task/widgets/two_app_bars.dart';

class IngredientsAndAllergensScreen extends StatelessWidget {
  const IngredientsAndAllergensScreen({super.key});

  static const routeName = '/ingredientsAndAllergens';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final IngredientsModel? ingModel = args['ingModel'];
    final String? gtin = args['gtin'];
    final ProductContentsListModel dataModel = args['dataModel'];

    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TwoAppBars(
                secondBgColor: purpleColor,
                secondText: "Ingredients & Allergens",
                firstBgColor: yellowAppBarColor,
                firstLeadingIcon: Icons.shopping_bag_outlined,
                firstText: "Retailer",
                firstActions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Screen(
                  gtin: gtin!,
                  fat: ingModel?.fat,
                  calories: ingModel?.calories,
                  sugar: ingModel?.sugar,
                  salt: ingModel?.salt,
                  ingredients: ingModel?.ingredients,
                  allergenInformation: ingModel?.allergenInfo,
                  productName: dataModel.productName,
                  productDescription: dataModel.productDescription,
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
    required this.gtin,
    this.calories,
    this.fat,
    this.salt,
    this.sugar,
    this.ingredients,
    this.allergenInformation,
    this.productName,
    this.productDescription,
  });
  final String gtin;
  final String? calories;
  final String? fat;
  final String? salt;
  final String? sugar;
  final String? ingredients;
  final String? allergenInformation;
  final String? productName;
  final String? productDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$productName - $productDescription",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: purpleColor,
          ),
          softWrap: true,
        ),
        const SizedBox(height: 10),
        // GTIN
        Text(
          'GTIN: $gtin',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBoxWidget(
                type: "Calories",
                quantity: calories,
                percentage: (double.parse(calories!) / 100).toStringAsFixed(2)),
            CustomBoxWidget(
                type: "Fat",
                quantity: fat,
                percentage: (double.parse(fat!) / 100).toStringAsFixed(2)),
            CustomBoxWidget(
                type: "Salt",
                quantity: salt,
                percentage: (double.parse(salt!) / 100).toStringAsFixed(2)),
            CustomBoxWidget(
                type: "Sugar",
                quantity: sugar,
                percentage: (double.parse(sugar!) / 100).toStringAsFixed(2)),
          ],
        ),
        const SizedBox(height: 10),
        // Ingredients
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ingredients",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(ingredients.toString()),
            const SizedBox(height: 20),
            const Text(
              "Allergen Information",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(allergenInformation.toString()),
          ],
        ),
      ],
    );
  }
}

class CustomBoxWidget extends StatelessWidget {
  const CustomBoxWidget({super.key, this.type, this.quantity, this.percentage});

  final String? type;
  final String? quantity;
  final String? percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: 80,
      // height: MediaQuery.of(context).size.height * 0.20,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: blackColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(child: Text(type ?? 'Ingredient Name')),
          const SizedBox(height: 10),
          FittedBox(
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                color: redColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            thickness: 2,
            color: blackColor,
          ),
          const SizedBox(height: 10),
          FittedBox(
            child: Text(
              "$percentage %",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
