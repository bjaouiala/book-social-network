class Apis {
  //Base Api
  static const String baseUrl = "http://localhost:8080/api/v1/";

  //Auth EndPoints
  static const String authBaseUrl = "${baseUrl}auth/";

  static const String loginUrl = "${authBaseUrl}authenticate";
  static const String registerUrl= "${authBaseUrl}register";
  static const String acticatioTokenrUrl= "${authBaseUrl}activation_account-code";
  static const String activationAccount="${authBaseUrl}activate-account";

  //Book Apis
  static const String bookBaseUrl = "${baseUrl}books";
  static const String allBookUrl= bookBaseUrl;
  static const String addBookToWaitingList="$bookBaseUrl/waiting-list/";
  static const String myWaitingListUrl="$bookBaseUrl/waiting-list";
}