bool isIncludeNumber(String? text){
  return false;
}

String? validateEmail(String? text){
  if(text!.isEmpty){
    return "Email not be Empty";
  }else if(text!.length < 13){
    return "Email must be greater than 12";
  }else if(!text!.contains("@") || !text!.contains(".com")){
    return "Enter valid email id";
  }
  return null;
}

String? validateName(String? text){
  if(text!.isEmpty){
    return "Name not be Empty";
  }else if(text!.length < 4){
    return "Name must be greater than 3";
  }
  return null;
}

String? validatePass(String? text){
  if(text!.isEmpty){
    return "Name not be Empty";
  }else if(text!.length < 9){
    return "Password should be at least 8 characters long";
  }else if(true){

  }
  return null;
}

String? validatePhone(String? text){
  return null;
}