import 'package:flutter/material.dart';
import 'package:hiring_task/models/safety_info_model.dart';
import 'package:hiring_task/utils/colors.dart';
import 'package:hiring_task/widgets/custom_appbar_widget.dart';
import 'package:hiring_task/widgets/home_appbar_widget.dart';

class SafetyInformationScreen extends StatelessWidget {
  static const routeName = "/safety-information-page";
  const SafetyInformationScreen({super.key});

  // Future<List<SafetyInformationModel>> getFutureData(
  //     BuildContext context) async {
  //   List<SafetyInformationModel> futureData = [];
  //   final response = await http.post(Uri.parse(URL.digitalLink),
  //       body: json.encode({
  //         "gtin": 6281000000113,
  //         "digitalLinkType": "tblProductSafetyInformation",
  //       }),
  //       headers: {
  //         "Content-Type": "application/json",
  //       });

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> body = json.decode(response.body);
  //     final responseData = body['digitalLinkData'];
  //     for (var i = 0; i < responseData.length; i++) {
  //       futureData.add(SafetyInformationModel.fromJson(responseData[i]));
  //     }
  //     return futureData;
  //   } else {
  //     return futureData;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<SafetyInfoModel> safetyInfoModel =
        ModalRoute.of(context)!.settings.arguments as List<SafetyInfoModel>;
    return Scaffold(
      appBar: HomeAppBarWidget(context),
      body: Column(
        children: [
          customAppBarWidget(
            title: "Safety Information",
            // backgroundColor: Colors.green[900],
            backgroundColor: darkBlue,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: safetyInfoModel.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageSingleInstance(
                  title: safetyInfoModel[index].companyName,
                  imageUrl: safetyInfoModel[index].logo,
                  certifiedProcesses: safetyInfoModel[index].process,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageSingleInstance extends StatelessWidget {
  const PageSingleInstance({
    super.key,
    this.imageUrl,
    this.title,
    this.certifiedProcesses,
  });

  final String? imageUrl;
  final String? title;
  final String? certifiedProcesses;

  firstSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey),
            image: DecorationImage(
              image: NetworkImage(imageUrl ?? ""),
              onError: (exception, stackTrace) => const Placeholder(),
              fit: BoxFit.contain,
            ),
          ),
          // child: Image.network(
          //   imageUrl ?? "",
          //   fit: BoxFit.contain,
          //   errorBuilder: (context, error, stackTrace) => const Placeholder(),
          // ),
        ),
        const SizedBox(height: 10),
        Text(
          title ?? "null",
          softWrap: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 3),
      ],
    );
  }

  secondSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: const Text(
                "Cerrified Processes",
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                certifiedProcesses ?? "null",
                softWrap: true,
              ),
            ),
          ],
        ),
        const Divider(thickness: 3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        firstSection(),
        secondSection(context),
      ],
    );
  }
}
