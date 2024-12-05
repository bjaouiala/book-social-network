emailValidators(value){
  if(value.isEmpty){
    return 'Email is required';
  }
  if(!value.contains('@')){
    return 'invalid email';
  }
  return null;
}

passwordValidator(value) {
  if(value.isEmpty) {
    return 'Password is required';
  }
  if(value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

fieldValidators(value,message){
   if(value.isEmpty){
    return message;
  }
}