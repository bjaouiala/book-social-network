class Tokenresponse {
  String token;

  Tokenresponse({ required this.token});

  factory Tokenresponse.fromJson(Map<String,dynamic> json){
    return Tokenresponse(token: json['token']); 

  }
}