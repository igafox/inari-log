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

  factory Address.from(Map<String, dynamic> map) {
    final result = map["result"] as Map<String, dynamic>?;
    final prefecture = result?["prefecture"];
    final municipality = result?["municipality"];
    final local = result?["local"];

    return Address(
        prefecture: prefecture["pname"],
        municipality: municipality["mname"],
        localSection: local["section"],
        homeNumber: local["homenumber"]
    );
  }

}