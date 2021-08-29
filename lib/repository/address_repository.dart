import 'package:inari_log/model/address.dart';

abstract class AddressRepository {

  Future<Address> findByLocation(double latitude,double longitude);

}
