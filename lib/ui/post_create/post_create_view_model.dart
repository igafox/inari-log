import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/post_memo.dart';
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

final postCreateViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => PostCreateViewModel(ref.read));

enum PostCreateDialogType {
  FILE_SIZE_OVER_ERROR,
  NOT_SET_IMAGE,
  FAILED_POST,
  SUCCESS_POST
}

class PostCreateViewModel extends ChangeNotifier {
  PostCreateViewModel(this._reader);

  final Reader _reader;

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  late final PostRepository _poreRepository = _reader(postRepositoryProvider);

  late final AddressRepository _addressRepository =
      _reader(addressRepositoryProvider);

  late final ImageRepository _imageRepository =
      _reader(imageRepositoryProvider);

  PostCreateDialogType? _currentDialogType;

  PostCreateDialogType? get currentDialogType => _currentDialogType;

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
    // try {
    //   final user = await _userRepository.getCurrentUser().first;
    //   if(user == null) {
    //     AppRouter.router.navigateTo(context, "/login",clearStack: true);
    //   }
    //
    // } catch (e) {
    //
    // }

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
      _currentDialogType = PostCreateDialogType.FILE_SIZE_OVER_ERROR;
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

  void createPost(BuildContext context) async {
    _loading = true;
    notifyListeners();

    try {
      final postId = await _poreRepository.generateId();

      //未設定画像チェック
      final hasNoImageMemo =
          postImages.where((element) => !element.hasImage()).isNotEmpty;
      if (hasNoImageMemo) {
        _currentDialogType = PostCreateDialogType.NOT_SET_IMAGE;
        notifyListeners();
        return;
      }

      //画像アップロード処理
      final uploadMemos = await Future.wait(_postImages.map((image) async {
        final source = image as ByteImageSource;
        final imageUrl =
            await _imageRepository.uploadImage(postId, source.data);
        final text = source.text;
        return PostMemo(text: text, imageUrl: imageUrl);
      }).toList());

      //投稿データ作成
      final post = Post(
          id: postId,
          name: _name,
          prefecture: _prefecture,
          municipality: _municipality,
          houseNumber: _houseNumber,
          location: GeoPoint(_location!.latitude, _location!.longitude),
          memos: uploadMemos,
          visitedDate: _visitedDate);
      //データ登録
      await _poreRepository.create(post);
      _currentDialogType = PostCreateDialogType.SUCCESS_POST;
    } catch (e) {
      _currentDialogType = PostCreateDialogType.FAILED_POST;
    } finally {
      notifyListeners();
      _loading = false;
    }
  }
}
