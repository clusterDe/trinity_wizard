import 'package:flutter/material.dart';

Color orangeColor = const Color(0xFFff8c00);

var defPadding = 16.0;
var defBorderRadius = 10.0;

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9].+[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kInvalidEmailError = "Please Enter Valid Email";
const String kInvalidFirstNameError = "Please Enter First Name";
const String kInvalidLastNameError = "Please Enter Last Name";
const String kInvalidDobNameError = "Please Enter Date of Birth";
