class Apis {
  //Base Api
  static const String baseUrl = "http://localhost:9500/api/v1/";

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
  static const String removeItemFromWaitingList="$bookBaseUrl/waiting-list";
  static const String getBookByOwner = "$bookBaseUrl/owner";
  static const String borrowBook = "$bookBaseUrl/borrow";
  static const String shareBook = "$bookBaseUrl/shareable";
  static const String archivedBook = "$bookBaseUrl/archived";
  static const String upploadPicture = "$bookBaseUrl/cover";
  static const String borrowedBook = "$bookBaseUrl/borrowed";
  static const String returnBook = "$bookBaseUrl/borrow/return";
  static const String returnedBook = "$bookBaseUrl/returned";
  static const String returnedApprouvedBook = "$bookBaseUrl/borrow/return/approved";
}