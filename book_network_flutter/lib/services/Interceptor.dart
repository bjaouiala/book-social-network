import 'dart:async';

import 'package:book_network_flutter/services/token_service.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Interceptor extends InterceptorContract{
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async{
    String? token = await tokenService.getToken();
    if(token != null){
      request.headers['Authorization'] = 'Bearer $token';
      print(request);
      return request;
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if(response.statusCode == 401){
      await tokenService.removeToken();
    }
    return response;
  }

}
 final Client client = InterceptedClient.build(interceptors: [Interceptor()],requestTimeout: const Duration(seconds: 5));