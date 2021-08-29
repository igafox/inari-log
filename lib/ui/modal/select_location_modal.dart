import 'dart:developer';
import 'dart:math';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectLocationModal extends ModalRoute<LatLng> {
  SelectLocationModal(this.latLng) {
    if (latLng == null) {
      return;
    }
    addMarker(latLng!);
  }

  LatLng? latLng;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  Location _location = new Location();

  GoogleMapController? _controller;

  int _markerCount = 0;

  Map<MarkerId, Marker> markers = {};

  bool _isSatelliteMap = false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    print(markers.values.length.toString());
    // This makes sure that text and other content follows the material style
    return Scaffold(
      appBar: AppBar(
        title: Text("場所を選択"),
        actions: [
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: 15, right: 15))),
              child: const Text(
                'マップ切り替え',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onPressed: () {
                toggleMapType();
              }),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: 15, right: 15))),
              child: const Text(
                '決定',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              onPressed: () {
                final marker = markers.values.firstOrNull;
                final location = marker!.position;
                Navigator.pop(context, location);
              }),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.my_location),
      //   onPressed: () {
      //     moveMyLocation(context);
      //   },
      // ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: latLng ?? LatLng(35.680400, 139.769017), zoom: 17),
            markers: markers.values.toSet(),
            mapType: (_isSatelliteMap) ? MapType.satellite : MapType.normal,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              _controller = controller;
              moveMyLocation(context);
            },
            onTap: (latLng) async {
              addMarker(latLng);
              changedExternalState();
            },
          )),
    );
  }

  void addMarker(LatLng latLng) {
    _markerCount++;
    final markerId = MarkerId(_markerCount.toString());
    final marker = Marker(markerId: markerId, position: latLng);

    markers = {};
    markers[markerId] = marker;
  }

  void toggleMapType() {
    _isSatelliteMap = !_isSatelliteMap;
    changedExternalState();
  }

  void moveMyLocation(BuildContext context) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.requestService();
    _permissionGranted = await _location.requestPermission();

    if (!_serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("位置情報が無効です"),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    if (_permissionGranted != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("位置情報が許可されていません"),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    // try {
    //   _serviceEnabled = await location.serviceEnabled();
    //   if (!_serviceEnabled) {
    //     _serviceEnabled = await location.requestService();
    //     if (!_serviceEnabled) {
    //       return;
    //     }
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("取得エラー"),
    //       duration: const Duration(seconds: 3),
    //     ),
    //   );
    // }
    //
    // try {
    //   _permissionGranted = await location.hasPermission();
    //   if (_permissionGranted == PermissionStatus.denied) {
    //     _permissionGranted = await location.requestPermission();
    //     if (_permissionGranted != PermissionStatus.granted) {
    //       return;
    //     }
    //   }
    // } catch(e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("権限エラー"),
    //       duration: const Duration(seconds: 3),
    //     ),
    //   );
    // }

    //位置情報取得
    try {
      _locationData = await _location.getLocation();
      final latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
      _controller?.moveCamera(CameraUpdate.newLatLngZoom(latLng, 19));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("位置情報の取得に失敗しました"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: GoogleMap(
//           initialCameraPosition: CameraPosition(
//               target: LatLng(37.24704658724978, 140.24538176453262),
//               zoom: 17),
//           markers: markers.values.toSet(),
//           mapType: MapType.normal,
//           onMapCreated: (controller) {
//             _controller = controller;
//           },
//           onTap: (latLng) async {
//             _markerCount++;
//             final markerId = MarkerId(_markerCount.toString());
//             final marker = Marker(markerId: markerId, position: latLng);
//
//             markers = {};
//             markers[markerId] = marker;
//
//             changedExternalState();
//           },
//         )),
// SizedBox(
//   width: 100,
//   height: 35,
//   child: ElevatedButton(
//     child: Text("決定"),
//     style: ElevatedButton.styleFrom(),
//     onPressed: markers.isEmpty
//         ? null
//         : () async {
//             final marker = markers.values.firstOrNull;
//             final location = marker!.position;
//             Navigator.pop(context, location);
//           },
//   ),
// ),
// Align(
//     alignment: Alignment.bottomRight,
//     child: SizedBox(
//       width: 100,
//       height: 35,
//       child: ElevatedButton(
//         child: Text("地図切り替え"),
//         style: ElevatedButton.styleFrom(),
//         onPressed: () async {
//
//         },
//       ),
//     )),
// Align(
//     alignment: Alignment.bottomRight,
//     child: SizedBox(
//       width: 100,
//       height: 35,
//       child: ElevatedButton(
//         child: Text("現在地"),
//         style: ElevatedButton.styleFrom(),
//         onPressed: () async {
//           Location location = new Location();
//
//           bool _serviceEnabled;
//           PermissionStatus _permissionGranted;
//           LocationData _locationData;
//
//           _serviceEnabled = await location.serviceEnabled();
//           if (!_serviceEnabled) {
//             _serviceEnabled = await location.requestService();
//             if (!_serviceEnabled) {
//               return;
//             }
//           }
//
//           _permissionGranted = await location.hasPermission();
//           if (_permissionGranted == PermissionStatus.denied) {
//             _permissionGranted = await location.requestPermission();
//             if (_permissionGranted != PermissionStatus.granted) {
//               return;
//             }
//           }
//
//           _locationData = await location.getLocation();
//
//           final latLng = LatLng(_locationData.latitude!,_locationData.longitude!);
//           _controller?.moveCamera(CameraUpdate.newLatLng(latLng));
//         },
//       ),
//     ))
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildOverlayContent(BuildContext context) {
//   return Center(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(
//           'This is a nice overlay',
//           style: TextStyle(color: Colors.white, fontSize: 30.0),
//         ),
//         RaisedButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Dismiss'),
//         )
//       ],
//     ),
//   );
// }

// @override
// Widget buildTransitions(
//     BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//   // You can add your own animations for the overlay content
//   return FadeTransition(
//     opacity: animation,
//     child: ScaleTransition(
//       scale: animation,
//       child: child,
//     ),
//   );
// }
// }
