import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/image_repository_imp.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final postEditViewModelProvider =
    ChangeNotifierProvider.family<PostEditViewModel, String>((ref, id) {
  return PostEditViewModel(ref.read, id);
});

class PostEditViewModel extends ChangeNotifier {
  PostEditViewModel(this._reader, this.id) {
    _load();
  }

  final String id;

  final Reader _reader;

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  late final PostRepository _postRepository = _reader(postRepositoryProvider);

  late final ImageRepository _imageRepository =
      _reader(imageRepositoryProvider);

  LatLng _location = LatLng(35.680400, 139.769017);

  LatLng get location => _location;

  Post _post = Post();

  Post get post => _post;

  String _name = "";

  String get name => _name;

  String _address = "";

  String get address => _address;

  String _memo = "";

  String get memo => _address;

  List<String> _uploadedImages = [];
  List<String> get uploadImages => _uploadedImages;

  List<Uint8List> _appendImages = [];
  List<Uint8List> get appendImages => _appendImages;

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

  void _load() async {
    try {
      _post = await _postRepository.findById(id);
      final user = await _userRepository.getCurrentUser().first;

      if (_post.userId != user?.id) {
        print("この投稿は権限がないため編集できません");
        //エラー
      }

      _name = _post.name;
      _address = _post.address;
      // _memo = _post.memo;
      // _uploadedImages = _post.imageUrls;


    } catch (e) {
      print("データの取得に失敗しました:" + e.toString());
    }
    notifyListeners();
  }

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
    _appendImages = imgs.take(5).toList();
    notifyListeners();
  }

  void postEdit(BuildContext context) async {
    _loading = true;
    notifyListeners();

    final imageUrls = await _imageRepository.uploadImages(id, appendImages);

    // final post = Post(
    //     id: id,
    //     name: _name,
    //     memo: _memo,
    //     address: _address,
    //     imageUrls: imageUrls);
    // await _postRepository.create(post);
    //
    // AppRouter.router.pop(context);
    //
    // _loading = false;
    // notifyListeners();
  }
}
