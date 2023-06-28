import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../main.dart';
import '../home/search_box.dart';

class MapScreen extends StatefulWidget {
  final subtype;

  MapScreen({Key? key, subtype})
      : subtype = subtype ?? {"type": "offline", "title": "Hệ K12", "image": "", "icon": Icons.school_outlined},
        super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.78604, 106.70123),
    zoom: 11.0,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 11.0);
  void initState() {
    super.initState();
    try {
      Future.wait([_detectCurrentPosition()]).then((List<dynamic> futureResult) {
        final currentPos = futureResult[0];
        _initPosition = CameraPosition(target: LatLng(currentPos.latitude, currentPos.longitude));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> _detectCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Dịch vụ định vị đang tắt.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Không có quyền truy cập vị trí.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Quyền truy cập vị trí đang tắt, không thể yêu cầu quyền truy cập.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(
            children: [
              AppBar(
                title: Text(widget.subtype["title"]),
                titleSpacing: 0,
                centerTitle: false,
                elevation: 0,
              ),
              Container(
                // height: 100.0,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 50.0,
                        child: SearchBox(user: user),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _findAround,
        label: const Text('Tìm trường gần tôi'),
        icon: const Icon(Icons.location_searching_outlined),
      ),
    );
  }

  Future<void> _findAround() async {
    final GoogleMapController controller = await _controller.future;
    Position currentPos = await _detectCurrentPosition();
    print(currentPos);
    final currentCamera = CameraPosition(
      bearing: 192,
      target: LatLng(currentPos.latitude, currentPos.longitude),
      zoom: 10,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(currentCamera));
  }
}
