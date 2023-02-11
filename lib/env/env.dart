import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_SECRET')
  static const apiSecret = _Env.apiSecret;
  @EnviedField(varName: 'BASE_URL')
  static const baseURL = _Env.baseURL;
  @EnviedField(varName: 'API_URL')
  static const apiURL = _Env.apiURL;
}