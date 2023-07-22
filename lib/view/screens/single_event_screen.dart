import 'package:flutter/material.dart';
import 'package:hiring_task/models/lat_long_model.dart';
import 'package:hiring_task/models/single_event_model.dart';
import 'package:hiring_task/view-model/retail-information/single_event_service.dart';
import 'package:hiring_task/view/direction_mark_screen.dart';
import 'package:hiring_task/widgets/custom_elevated_button.dart';

class SingleEventScreen extends StatelessWidget {
  const SingleEventScreen({super.key});
  static const String routeName = '/single-event-screen';
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final LatLongModel latLongData = args['latLongData'];
    final String trxGLNIDTo = args['trxGLNIDTo'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single Event"),
      ),
      body: FutureBuilder(
        future: SingleEventService.getFutureData(trxGLNIDTo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          final data = snapshot.data as List<SingleEventModel>;
          return ListView(
            children: [
              Screen(
                address: data[0].addressEn,
                gcpGLNID: data[0].gcpGLNID,
                image: data[0].image,
                locationName: data[0].locationNameEn,
                officeTel: data[0].officeTel,
                pobox: data[0].pobox,
                latLongModel: latLongData,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.gcpGLNID,
    this.image,
    this.locationName,
    this.address,
    this.pobox,
    this.officeTel,
    this.latLongModel,
  });
  final String? gcpGLNID;
  final String? image;
  final String? locationName;
  final String? address;
  final String? pobox;
  final String? officeTel;
  final LatLongModel? latLongModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    image.toString(),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Placeholder(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Text(
                  "$locationName - $address",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ADDRESS",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$address'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomElevatedButton(
                  bgColor: Theme.of(context).primaryColor,
                  caption: "View",
                  onPressed: () {
                    // navigate to the direction mark screen
                    Navigator.of(context).pushNamed(
                      DirectionMarkScreen.routeName,
                      arguments: {
                        "latLongModel": latLongModel,
                        "address": address,
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
