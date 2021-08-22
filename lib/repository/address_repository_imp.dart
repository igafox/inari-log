import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/api/geocording_api.dart';
import 'package:inari_log/model/address.dart';
import 'package:inari_log/repository/address_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

final addressRepositoryProvider =
    Provider((ref) => AddressRepositoryImp(ref.read));

class AddressRepositoryImp implements AddressRepository {
  AddressRepositoryImp(this._reader);

  final Reader _reader;

  @override
  Future<String> findByLocation(double latitude, double longitude) async {
    final url =
        "https://aginfo.cgk.affrc.go.jp/ws/rgeocode.php?json&lat=$latitude&lon=$longitude";

    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    final address = Address.fromJson(data);

    // final result = map["result"] as Map<String, dynamic>;
    // final prefecture = result["prefecture"]["pname"];
    // final municipality = result["municipality"]["mname"];
    // final section = result["local"][0]["section"];
    // final homeNumber = result["local"][0]["homenumber"];

    return address.toString();
  }
}
