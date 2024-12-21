import 'dart:convert';
import 'dart:io';
import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/models/Auth/RegisterRequest.dart';
import 'package:book_network_flutter/models/Auth/TokenResponse.dart';
import 'package:book_network_flutter/services/Apis.dart';
import 'package:book_network_flutter/services/token_service.dart';
import 'package:http/http.dart' as http;

import 'package:book_network_flutter/models/Auth/AuthenticationRequest.dart';
import 'package:book_network_flutter/models/Auth/AuthenticationResponse.dart';

class _AuthService{
  Future<Authenticationresponse> login(Authenticationrequest auth) async{
   try{
     final response = await  http.post(Uri.parse(Apis.loginUrl),
     headers: {
    'Content-Type': 'application/json',
  },body: jsonEncode(auth.toJson()));
    if (response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      Authenticationresponse authenticationresponse = Authenticationresponse.fromJson(responseBody);
      await tokenService.saveToken(authenticationresponse.token);
      return authenticationresponse;
    }else if(response.statusCode == 401){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],responseBody["businessErrorDescription"],  responseBody["error"]);
    }else{
      throw HttpException('${response.statusCode}');
    }
   }catch(e){
    rethrow ;
   }
  }

  Future<bool> register(Registerrequest request) async{
    try{
      final response =  await http.post(Uri.parse(Apis.registerUrl),
      headers: {
        'content-type':'application/json'
      },
      body: jsonEncode(request.toJson())
      );
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      rethrow;
    }

  }

  Future<Tokenresponse> getToken(String code) async{
    final response = await http.get(Uri.parse(Apis.acticatioTokenrUrl).replace(queryParameters: {
      "code":code
    }));
    if(response.statusCode == 200){
      return Tokenresponse.fromJson(jsonDecode(response.body));
    
  }else{
    throw Exception("no token load");
  }

}
  Future<void> activationAccount(String token) async{
    try{
      final response = await http.get(Uri.parse(Apis.activationAccount).replace(queryParameters: {
        "token":token
      }));
      if(response.statusCode == 400){
        final responseBody = jsonDecode(response.body);
        throw Businessexception(responseBody["businessErrorCode"],responseBody["businessErrorDescription"],  responseBody["error"]);
      }

    }catch(e){
      rethrow;
    }
  }
}

final authService = _AuthService();