import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LocationMap extends StatelessWidget {
  const LocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
    );
    th(controller);
    return Scaffold(
        appBar: AppBar(
          title: Text('Karte'),
        ),
        body: Column(
          children: [
            OSMFlutter(
              controller: controller,
              userTrackingOption: UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              initZoom: 12,
              minZoomLevel: 8,
              maxZoomLevel: 14,
              stepZoom: 1.0,
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadOption(
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              )),
            ),
            ElevatedButton(
              onPressed: () {
                dispose(controller);
              },
              child: null,
            )
          ],
        ));
  }

  th(controller) async {
    await controller.currentLocation();
  }

  dispose(MapController controller) {
    controller.initPosition;
    controller.dispose();
    //controller.
  }
}
