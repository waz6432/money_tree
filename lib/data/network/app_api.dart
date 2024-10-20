import 'package:dio/dio.dart';
import 'package:financial_ledger/app/constant.dart';
import 'package:financial_ledger/data/logger/logger.dart';
import 'package:financial_ledger/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login({
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("imei") required String imei,
    @Field("deviceType") required String deviceType,
  });

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword({
    @Field("email") required String email,
  });

  @POST("/customers/register")
  Future<AuthenticationResponse> register({
    @Field("country_mobile_code") required String countryMobileCode,
    @Field("user_name") required String userName,
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("mobile_number") required String mobileNumber,
    @Field("profile_picture") required String profilePicture,
  });

  @GET("/home")
  Future<HomeResponse> getHome();

  @POST("/customers/newTransaction")
  Future<NewTransactionResponse> newTransaction({
    @Field("amount") required int amount,
    @Field("note") required String note,
    @Field("category") required String category,
    @Field("date") required String date,
  });
}
