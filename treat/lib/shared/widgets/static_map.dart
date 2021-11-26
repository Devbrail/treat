import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
as L;
import 'package:map_launcher/map_launcher.dart';
import 'package:treat/api/api_constants.dart';
import 'package:treat/shared/constants/colors.dart';

class StaticMapWidget extends StatelessWidget {
  final Location latLng;
  final String label;

  StaticMapWidget({
    required this.latLng,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = L.StaticMapController(
      googleApiKey: ApiConstants.API_KEY,
      width: Get.width.toInt(),
      height: (Get.height * .35).toInt(),
      zoom: 15,
      center: latLng,

    );

    return InkWell(
      onTap: () {
        MapsSheet.show(
            context: context,
            title: label,
            cordinates: Coords(latLng.latitude, latLng.longitude),
            onMapTap: (map)
        {
          map.showMarker(
            coords: Coords(latLng.latitude, latLng.longitude),
            title: label,
            zoom: 15,
          );
        },);
      },
      child: Image(
        width: Get.width,
        height: Get.height * .35,
        image: _controller.image,
      ),
    );
  }
}

class MapsSheet {
  static show({
    required BuildContext context,
    required Function(AvailableMap map) onMapTap,
    required String title, required Coords cordinates,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.length == 1) {
      availableMaps.first.showMarker(
        coords: cordinates,
        title: title,
        zoom: 15,
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () => onMapTap(map),
                            title: Text(map.mapName),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
