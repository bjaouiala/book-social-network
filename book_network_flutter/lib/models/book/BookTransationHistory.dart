class BooktransactionhistoryResponse {

    int id;
    String title;
    String authorName;
    String isbn;
    double rate;
    bool returned;
    bool returnApproved;


    BooktransactionhistoryResponse({
      required this.id,
      required this.title,
      required this.authorName,
      required this.isbn,
      required this.rate,
      required this.returned,
      required this.returnApproved,
    });


    factory BooktransactionhistoryResponse.fromJson(Map<String,dynamic> json){
      return BooktransactionhistoryResponse
      (id: json["id"], title:json["title"], authorName: json["authorName"], isbn: json["isbn"], rate: json["rate"], returned: json["returned"], returnApproved: json["returnApproved"]);
    }
}