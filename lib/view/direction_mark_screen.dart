import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hiring_task/models/lat_long_model.dart';

class DirectionMarkScreen extends StatelessWidget {
  const DirectionMarkScreen({super.key});
  static const routeName = "/direction_mark_screen";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final LatLongModel latLongModel = args['latLongModel'];
    final String address = args['address'];
    final double lat = double.parse(latLongModel.itemGPSOnGoLat.toString());
    final double long = double.parse(latLongModel.itemGPSOnGoLon.toString());
    Marker marker = Marker(
      markerId: MarkerId(address),
      position: LatLng(lat, long),
      infoWindow: const InfoWindow(
        title: 'My Marker',
        snippet: 'This is my marker',
      ),
    );
    Set<Marker> markers = {marker};
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(23.885942, 45.079163), // Default location
        zoom: 12,
      ),
      markers: markers,
      polylines: {
        Polyline(
          polylineId: const PolylineId('MyPolyline'),
          points: [
            LatLng(lat, long),
            const LatLng(23.885942, 45.079163),
          ],
          color: Colors.blue,
        ),
      },
      myLocationButtonEnabled: true,
    );
  }
}
