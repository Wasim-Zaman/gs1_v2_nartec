// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/providers/product.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/base-api/base_api_service.dart';
import 'package:hiring_task/view/screens/grids/logistic_info_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/product_contents_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/recipe_grid_screen.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';
import 'package:hiring_task/widgets/secondary_appbar_widget.dart';
import 'package:provider/provider.dart';

class RetailorShopperScreen extends StatelessWidget {
  const RetailorShopperScreen({super.key});

  static const routeName = '/retailor_shopper_screen';

  // ProductContentsListModel? myData;

  // Future<ProductContentsListModel> getData(BuildContext context) async {
  //   final String? gtinCode =
  //       ModalRoute.of(context)!.settings.arguments as String?;
  //   final http.Response response = await http.post(
  //     Uri.parse(URL.baseUrl),
  //     body: json.encode(
  //       {
  //         "gtin": gtinCode ?? 6281000010037,
  //       },
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> body = json.decode(response.body);
  //     final responseData = body['gtinArr'];
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: const Text("api is working"),
  //       ),
  //     );
  //     myData = ProductContentsListModel.fromJson(responseData);
  //     return myData!;
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: const Text("api is not working"),
  //       ),
  //     );
  //     throw Exception('Failed to load data');
  //   }
  // }

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
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ChangeNotifierProvider(
              create: (context) => Product(
                gtin: data.gtin!,
                productImageUrl: data.productImageUrl!,
                productDescription: data.productDescription!,
                productName: data.productName!,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SecondaryAppBarWidget(
                      title1: "Retailer",
                      title2: "",
                      color: pinkColor,
                      leadingIcon: Icons.shopping_cart,
                      backgroundColor: yellowAppBarColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageWidget(imageUrl: data!.productImageUrl),
                          const SizedBox(height: 10),
                          Text(
                            "${data.productName} - ${data.productDescription}",
                            softWrap: true,
                            style: const TextStyle(
                              color: purpleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "GTIN: ${data.gtin}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TabsWidget(data: data),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return RefreshIndicator(
              onRefresh: () => BaseApiService.getData(context),
              child: Center(
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              ),
            );
          } else {
            return const Center(
              child: Center(
                child: Text('Something went wrong!'),
              ),
            );
          }
        },
      ),
    );
  }
}

class TabsWidget extends StatelessWidget {
  const TabsWidget({
    super.key,
    required this.data,
  });
  final ProductContentsListModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTileButton(
          title: "Ingredients & Allergens",
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProductContentsGridScreen.routeName,
              arguments: data,
            );
          },
        ),
        CustomListTileButton(
          title: "Recipes",
          onPressed: () {
            Navigator.pushNamed(
              context,
              RecipeGridScreen.routeName,
              arguments: data,
            );
          },
        ),
        CustomListTileButton(
          title: "Logistics information",
          onPressed: () {
            Navigator.pushNamed(
              context,
              LogisticInfoGridScreen.routeName,
              arguments: data,
            );
          },
        ),
      ],
    );
  }
}

class CustomListTileButton extends StatelessWidget {
  const CustomListTileButton({
    super.key,
    this.title,
    this.onPressed,
  });

  final String? title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(title ?? 'Title'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: pinkColor,
          size: 15,
        ),
        onTap: onPressed ?? () {},
      ),
    );
  }
}

// class ProductImage extends StatelessWidget {
//   const ProductImage({
//     super.key,
//     required this.data,
//   });

//   final ProductContentsListModel? data;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: MediaQuery.of(context).size.height * 0.3,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Card(
//           elevation: 6,
//           child: Image.network(
//             data!.productImageUrl!,
//             fit: BoxFit.contain,
//             alignment: Alignment.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
