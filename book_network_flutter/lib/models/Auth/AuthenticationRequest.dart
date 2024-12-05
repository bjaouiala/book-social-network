class Authenticationrequest {
  String email;
  String password;

  Authenticationrequest({
    required this.email,
    required this.password
  });

  Map<String,String> toJson(){
    return {
      'email':email,
      'password':password,
    };
  }
  
}