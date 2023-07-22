import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/providers/gtin.dart';
import 'package:hiring_task/view-model/base-api/base_api_service.dart';
import 'package:hiring_task/view/screens/custom_and_border_check_screen.dart';
import 'package:hiring_task/view/screens/grids/custom_&_border_grid.dart';
import 'package:hiring_task/view/screens/grids/package_composition_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/product_safety_grid.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/widgets/custom_appbar_widget.dart';
import 'package:hiring_task/widgets/custom_image_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';
import 'package:provider/provider.dart';

class RegulatoryAffairsScreen extends StatelessWidget {
  const RegulatoryAffairsScreen({super.key});

  static const routeName = '/regulatory-Affairs-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: FutureBuilder(
        future: BaseApiService.getData(context,
            gtin: Provider.of<GTIN>(context).gtinNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView(
              children: [
                customAppBarWidget(
                  title: "Regulatory Affairs",
                  backgroundColor: Colors.green[900],
                ),
                Screen(data: data),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Center(
                child: Text(snapshot.error.toString()),
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

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    required this.data,
  });

  final ProductContentsListModel? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageWidget(imageUrl: data?.productImageUrl),
            const SizedBox(height: 10),
            Text(
              "${data?.productName} - ${data?.productDescription}",
              style: const TextStyle(
                color: purpleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "GTIN: ${data?.gtin}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(thickness: 2),
            TabsWidget(data: data!),
          ],
        ),
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
          title: "Product Safety (Conformance)",
          onPressed: () {
            Navigator.of(context).pushNamed(
              ProductSafetyGrid.routeName,
              arguments: data,
            );
          },
        ),
        CustomListTileButton(
          title: "Packaging Composition",
          onPressed: () {
            Navigator.of(context).pushNamed(
              PackageCompositionGridScreen.routeName,
              arguments: data,
            );
          },
        ),
        CustomListTileButton(
          title: "Customs & Border Check",
          onPressed: () {
            // Navigator.of(context)
            //     .pushNamed(CustomAndBorderCheckScreen.routeName);
            Navigator.of(context).pushNamed(
              CustomAndBorderCheckScreen.routeName,
              arguments: data,
            );
          },
        ),
        CustomListTileButton(
          title: "Quality Assurance",
          onPressed: () {},
        ),
        CustomListTileButton(
          title: "ISO Compliance",
          onPressed: () {},
        ),
        CustomListTileButton(
          title: "SASO Conformance",
          onPressed: () {},
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
