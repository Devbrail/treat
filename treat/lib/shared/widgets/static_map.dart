import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart'
    as L;
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
      googleApiKey: "AIzaSyDsaPA8h1O6afo6J5ZuJFQDORVHo1fsFSU",
      width: Get.width.toInt(),
      height: (Get.height * .35).toInt(),
      zoom: 15,
      center: latLng,
      markers: [
        L.Marker(
          color: ColorConstants.violet,
          label: label[0].capitalize,
          locations: [
            latLng,
          ],
        ),
      ],
    );
    ImageProvider image = _controller.image;

    return Image(
      width: Get.width,
      height: Get.height * .35,
      image: image,
    );
  }
}
