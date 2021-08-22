abstract class AddressRepository {

  Future<String> findByLocation(double latitude,double longitude);

}
