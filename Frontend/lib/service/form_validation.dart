bool isIncludeNumber(String? text) {
  return false;
}

String? validateEmail(String? text) {
  if (text!.isEmpty) {
    return "Email should not be empty";
  } else if (text!.length < 12) {
    return "Email should be at least 15 chars long";
  } else if (!text!.endsWith("@gmail.com")) {
    // || !text!.endsWith("@outlook.com") || !text!.endsWith("@hotmail.com")
    return "Enter valid email id";
  }
  return null;
}

String? validateName(String? text) {
  if (text!.isEmpty) {
    return "Name should not be empty";
  } else if (text!.length < 3) {
    return "Name should be at least 3 chars long";
  }
  return null;
}

String? validatePassword(String? text) {
  if (text!.isEmpty) {
    return "Password should not be empty";
  } else if (text!.length < 8) {
    return "Password should be at least 8 chars long";
  } else if (true) {}
  return null;
}

String? validatePhone(String? text) {
  if (text!.isEmpty) {
    return "Mobile number should not be empty";
  } else if (text!.length != 10 ||
      text.startsWith("1") ||
      text.startsWith("2")) {
    return "Enter valid mobile number";
  }
  return null;
}

String? validateField(String? text) {
  if (text!.isEmpty) {
    return "Field should not be empty";
  } else if (text!.length < 3) {
    return "Field should be at least 3 chars long";
  }
  return null;
}

String? validateAddress(String? text) {
  if (text!.isEmpty) {
    return "Address should not be empty";
  } else if (text!.length < 30) {
    return "Address should be at least 30 chars long";
  }
  return null;
}

String? validatePincode(String? text) {
  if (text!.isEmpty) {
    return "Pincode should not be empty";
  } else if (text!.length != 6) {
    return "Enter valid pincode";
  }
  return null;
}

String? validateCity(String? text) {
  if (text!.isEmpty) {
    return "City should not be empty";
  } else if (text!.length < 3) {
    return "Address should be at least 3 chars long";
  }
  return null;
}

String? validateState(String? text) {
  if (text!.isEmpty) {
    return "State should not be empty";
  } else if (text!.length < 3) {
    return "State should be at least 3 chars long";
  }
  return null;
}

String? validateCourt(String? text) {
  if (text!.isEmpty) {
    return "Court should not be empty";
  } else if (text!.length < 5) {
    return "Court should be at least 5 chars long";
  }
  return null;
}

String? validateBarCouncilId(String? text) {
  if (text!.isEmpty) {
    return "Bar Council Id should not be empty";
  } else if (text!.length < 8) {
    return "Enter valid Bar Council Id";
  }
  return null;
}

String? validateFees(String? text) {
  if (text!.isEmpty) {
    return "Fees should not be empty";
  } else if (text!.length < 3) {
    return "Enter valid fees";
  }
  return null;
}

String? validateExperience(String? text) {
  if (text!.isEmpty) {
    return "Experience should not be empty";
  } else if (text!.length > 2) {
    return "Enter valid year of experience";
  }
  return null;
}

String? validateShortIntro(String? text) {
  if (text!.isEmpty) {
    return "Intro should not be empty";
  } else if (text!.length < 50) {
    return "Intro should be at least 50 chars long";
  }
  return null;
}

String? validateDetailedIntro(String? text) {
  if (text!.isEmpty) {
    return "Intro should not be empty";
  } else if (text!.length < 150) {
    return "Intro should be at least 150 chars long";
  }
  return null;
}
