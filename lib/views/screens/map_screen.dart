import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_shop_app/views/screens/main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //현재 위치 권한 확인
  Future<String> checkPermission() async {
    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return '위치 서비스를 활성화 해주세요';
    }
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();
      if (checkPermission == LocationPermission.denied) {
        return '위치권한을 허가해 주세요.';
      }
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return '앱의 위치권한을 세팅에서 허가해 주세요.';
    }
    return '위치권한이 허가되었습니다.';
  }

  //현재 위치 가져오기
  late Position currentPosition;
  getUserCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 16);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: checkPermission(),
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshot.data == '위치권한이 허가되었습니다.') {
                return GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  padding: EdgeInsets.only(bottom: 150),
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                    mapController = controller;
                    getUserCurrentLocation();
                  },
                );
              }
              return Center(
                child: Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.offAll(() => MainScreen()
                        );
                        // offAll() 메서드는 현재 화면을 제외한 모든 화면을 제거하고 새로운 화면을 표시합니다.
                        // 뒤로 가기를 눌러도 돌아갈수 없다.(이전 화면 위에 배치되지 않는다)
                      },
                      icon: Icon(CupertinoIcons.shopping_cart),
                      label: Text(
                        'SHOP NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
