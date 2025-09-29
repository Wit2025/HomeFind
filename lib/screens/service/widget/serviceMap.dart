import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ServiceMap extends StatelessWidget {
  final MapController mapController;
  final LatLng initialCenter;
  final double initialZoom;

  const ServiceMap({
    Key? key,
    required this.mapController,
    required this.initialCenter,
    this.initialZoom = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // แผนที่หลัก
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: initialZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.androidApp.homefind',
            ),
          ],
        ),

        // เข็มหมุดกลางจอ
        const Center(
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 50,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
