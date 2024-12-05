class Authenticationresponse {
  String token;

  Authenticationresponse({
    required this.token
  });

  factory Authenticationresponse.fromJson(Map<String,dynamic> json){
    return Authenticationresponse(token:json['token']);
  }
}