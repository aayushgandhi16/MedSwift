import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medswift/models/near_by_model.dart';
import 'package:medswift/services/device/get_location.dart';
import 'package:medswift/services/firebase/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../../shared/colors.dart';

final _database = Database();

class NearByView extends StatefulWidget {
  const NearByView({super.key});

  @override
  State<NearByView> createState() => _NearByViewState();
}

class _NearByViewState extends State<NearByView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLocation().checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Med",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "swift",
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: _database.getNearByTestCenters(),
        builder: (context, AsyncSnapshot<List<NearByModel>> nearBy) {
          if (nearBy.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (nearBy.hasData) {
            print(nearBy.data);
            return StreamBuilder(
              stream: GetLocation().getLocationStream(),
              builder: (context, AsyncSnapshot<Position> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  var postiton = snapshot.data!;
                  return GoogleMap(
                    markers: nearBy.data!
                        .map(
                          (e) => Marker(
                            markerId: MarkerId(const Uuid().v4()),
                            infoWindow: InfoWindow(title: e.name),
                            onTap: () async {
                              await launchUrl(
                                Uri.parse(
                                  "https://www.google.com/search?q=${double.parse(e.latitude)} ${double.parse(e.longitude)}",
                                ),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            position: LatLng(
                              double.parse(e.latitude),
                              double.parse(e.longitude),
                            ),
                          ),
                        )
                        .toSet(),
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      zoom: 16,
                      target: LatLng(
                        postiton.latitude,
                        postiton.longitude,
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
