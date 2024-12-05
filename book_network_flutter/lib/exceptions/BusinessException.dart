class Businessexception implements Exception{
   int businessErrorCode ;
   String businessErrorDescription;
   String error;

   Businessexception(
    this.businessErrorCode,
    this.businessErrorDescription,
    this.error
   );

     @override
  String toString() => 'BusinessException: $businessErrorDescription';
}