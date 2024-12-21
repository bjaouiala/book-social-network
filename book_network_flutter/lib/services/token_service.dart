import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _TokenService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> saveToken(String token) async{
    await _secureStorage.write(key: "token", value: token);
  }

  Future<String?> getToken() async{
    try{
      return await _secureStorage.read(key: "token");
    }catch (e){
      return null;
    }
  }

  Future<void> removeToken()async{
    await _secureStorage.delete(key: "token");
  }
}
final tokenService = _TokenService();