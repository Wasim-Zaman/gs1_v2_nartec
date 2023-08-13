import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/view-model/package-composition/pkg_comp_grid_services.dart';
import 'package:hiring_task/view/screens/packaging_composition_screen.dart';

class PackageCompositionGridScreen extends StatelessWidget {
  static const routeName = "/package-composition-grid-screen";
  const PackageCompositionGridScreen({super.key});

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
        future: PkgCompGridServices.getData(context, gtin: dataModel.gtin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong, please try again later"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data found"),
            );
          }
          final pkgCompModel = snapshot.data;

          return pkgCompModel!.isEmpty
              ? const Center(child: Text('No data found'))
              : ListView.builder(
                  itemCount: pkgCompModel.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        PackagingCompositionScreen.routeName,
                        arguments: pkgCompModel[index],
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
                            pkgCompModel[index].title.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                            ),
                          ),
                          // subtitle: Text(
                          //   pkgCompModel[index].title.toString(),
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
