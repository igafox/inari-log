import 'dart:js';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/address_repository.dart';
import 'package:inari_log/repository/address_repository_imp.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/image_repository_imp.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';
import 'package:inari_log/ui/post_edit/post_image_source.dart';

import '../../constant.dart';

final postEditViewModelProvider =
    ChangeNotifierProvider.family<PostEditViewModel, String>((ref, id) {
  return PostEditViewModel(ref.read, id);
});

enum PostEditDialogType {
  PERMISSION_ERROR,
  FAILED_LOAD_DATA,
  FILE_SIZE_OVER_ERROR,
  FAILED_POST,
  SUCCESS_POST,
}

class PostEditViewModel extends ChangeNotifier {
  PostEditViewModel(this._reader, this.id) {
    load();
  }

  final String id;

  final Reader _reader;

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  late final PostRepository _postRepository = _reader(postRepositoryProvider);

  late final AddressRepository _addressRepository =
      _reader(addressRepositoryProvider);

  late final ImageRepository _imageRepository =
      _reader(imageRepositoryProvider);

  PostEditDialogType? _currentDialogType;

  PostEditDialogType? get currentDialogType => _currentDialogType;

  bool _loading = false;

  bool get loading => _loading;

  Post _post = Post();

  Post get post => _post;

  String _name = "";

  String get name => _name;

  String _prefecture = "";

  String get prefecture => _prefecture;

  String _municipality = "";

  String get municipality => _municipality;

  String _houseNumber = "";

  String get houseNumber => _houseNumber;

  LatLng? _location;

  LatLng? get location => _location;

  DateTime _visitedDate = DateTime.now();

  DateTime get visitedDate => _visitedDate;

  List<PostImageSource> _postImages = [UrlImageSource("", "")];

  List<PostImageSource> get postImages => _postImages;

  void onCompleteShowDialog() {
    _currentDialogType = null;
  }

  void load() async {
    _loading = true;
    try {
      _post = await _postRepository.findById(id);
      final user = await _userRepository.getCurrentUser().first;

      if (_post.userId != user?.id) {
        _currentDialogType = PostEditDialogType.PERMISSION_ERROR;
        notifyListeners();
        return;
      }

      _name = _post.name;
      _visitedDate = post.visitedDate!;
      _prefecture = post.prefecture;
      _municipality = post.municipality;
      _houseNumber = post.houseNumber;
      _location = LatLng(_post.location!.latitude, _post.location!.longitude);
      // _memo = _post.memo;
      // _uploadedImages = _post.imageUrls;

      final initialPostImages =
          _post.memos.map((e) => UrlImageSource(e.imageUrl, e.text));
      _postImages.clear();
      _postImages.addAll(initialPostImages);
    } catch (e) {
      _currentDialogType = PostEditDialogType.FAILED_LOAD_DATA;
    }

    _loading = false;
    notifyListeners();
  }

  void onChangeName(String text) {
    _name = text;
  }

  void onChangePrefecture(String text) {
    _prefecture = text;
  }

  void onChangeMunicipality(String text) {
    _municipality = text;
  }

  void onChangeLocalSection(String text) {
    _houseNumber = text;
  }

  void onChangeAddress(String text) {
    // _address = text;
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

  void postEdit(BuildContext context) async {
    _loading = true;
    notifyListeners();

    //final imageUrls = await _imageRepository.uploadImages(id, appendImages);

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

  void onChangeVisitedAt(DateTime pickedDate) {
    _visitedDate = pickedDate;
    notifyListeners();
  }

  void onChangeLocation(LatLng latLng) async {
    _location = latLng;

    final address = await _addressRepository.findByLocation(
        latLng.latitude, latLng.longitude);

    _prefecture = address.prefecture;
    _municipality = address.municipality + address.localSection;
    _houseNumber = address.homeNumber;

    notifyListeners();
  }

  void addNewMemo(String s, Uint8List image) {
    if (image.lengthInBytes > Const.IMAGE_UPLOAD_BYTE_LIMIT) {
      _currentDialogType = PostEditDialogType.FILE_SIZE_OVER_ERROR;
      notifyListeners();
      return;
    }

    _postImages.add(ByteImageSource(image, ""));
    notifyListeners();
  }

  void onRemoveMemo(int index) {
    _postImages.removeAt(index);

    if (_postImages.isEmpty) {
      _postImages.add(UrlImageSource("", ""));
    }

    notifyListeners();
  }

  void onChangeMemoText(int index, String text) {
    _postImages[index].text = text;
  }

  void onChangeMemoImage(index, Uint8List image) {
    final text = postImages[index].text;
    _postImages[index] = ByteImageSource(image, text);
    notifyListeners();
  }
}
