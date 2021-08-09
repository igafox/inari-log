import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/image_repository_imp.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';

final postViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => PostEditViewModel(ref.read));

class PostEditViewModel extends ChangeNotifier {
  PostEditViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  late final PostRepository _poreRepository = _reader(postRepositoryProvider);

  late final ImageRepository _imageRepository = _reader(imageRepositoryProvider);

  LatLng _location = LatLng(35.680400, 139.769017);

  LatLng get location => _location;

  String _name = "";
  String get name => _name;

  String _address = "";
  String get address => _address;

  String _memo = "";
  String get memo => _address;

  List<Uint8List> _uploadImages = [];

  List<Uint8List> get uploadImages => _uploadImages;

  bool _loading = false;
  bool get loading => _loading;

  Set<Marker> _marker = {
    Marker(
      position: LatLng(35.680400, 139.769017),
      markerId: MarkerId("pin"),
    )
  };

  Set<Marker> get marker => _marker;

  // void changeAddress(String address) async {
  //   print(address);
  //   var locations = await locationFromAddress(address);
  //   _location = LatLng(locations.first.latitude, locations.first.longitude);
  //   notifyListeners();
  // }

  void onChangeName(String text) {
    _name = text;
  }

  void onChangeAddress(String text) {
    _address = text;
  }

  void onChangeMemo(String text) {
    _memo = text;
  }

  // void changeLocation(LatLng latLng) async {
  //   _location = latLng;
  //   // var places =
  //   //     await placemarkFromCoordinates(_location.latitude, _location.longitude);
  //   // var place = places.first;
  //   // _address = place.street ?? "";
  //
  //   _marker = {
  //     Marker(
  //       position: latLng,
  //       markerId: MarkerId(DateTime.now().toIso8601String()),
  //     )
  //   };
  //
  //   print(marker.first.position.latitude.toString());
  //
  //   _address = latLng.latitude.toString() + ":" + latLng.longitude.toString();
  //
  //   notifyListeners();
  // }

  void addUploadImage(List<Uint8List> imgs) {
    _uploadImages = imgs.take(5).toList();
    notifyListeners();
  }

  void post(BuildContext context) async {
    _loading = true;
    notifyListeners();

    final id = await _poreRepository.generateId();
    final imageUrls = await _imageRepository.uploadImages(id, _uploadImages);

    final post = Post(
        id: id,
        name: _name,
        memo: _memo,
        address: _address,
        imageUrls: imageUrls);
    await _poreRepository.create(post);

    AppRouter.router.pop(context);

    _loading = false;
    notifyListeners();
  }
}
