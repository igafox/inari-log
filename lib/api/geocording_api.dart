import 'package:inari_log/model/address.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'geocording_api.g.dart';

@RestApi(baseUrl: "https://aginfo.cgk.affrc.go.jp")
abstract class GeocordingApi {

  factory GeocordingApi(Dio dio, {String baseUrl}) = _GeocordingApi;

  @GET("/ws/rgeocode.php?json")
  Future<Address> geocording(
      @Query("lat") String latitude, @Query("lon") String longitude);
}
