class Registerrequest {
  String firstname;
  String lastname;
  String email;
  String password;

  Registerrequest(this.firstname,this.lastname,this.email,this.password);

  Map<String,String> toJson(){
    return {
      "firstname":firstname,
      "lastname":lastname,
      "email":email,
      "password":password
    };
  }
}