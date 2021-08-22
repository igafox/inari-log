import 'dart:html';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

@freezed
abstract class Address implements _$Address {

  const Address._();

  const factory Address({
    @Default("") String prefecture,
    @Default("") String municipality,
    @Default("") String localSection,
    @Default("") String homeNumber,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> map) {
    print(map);
    final result = map["result"] as Map<String, dynamic>?;

    final prefecture = result?["prefecture"]?["pname"] ?? "";
    final municipality = result?["municipality"]?["mname"] ?? "";
    final local = result?["local"] as List<dynamic>?;
    final section = local?.firstOrNull["section"] ?? "";
    final homeNumber = local?.firstOrNull["homenumber"] ?? "";

    return Address(
        prefecture: prefecture,
        municipality: municipality,
        localSection: section,
        homeNumber: homeNumber
    );
  }

  @override
  String toString() {
    return prefecture + municipality + localSection + homeNumber;
  }

}