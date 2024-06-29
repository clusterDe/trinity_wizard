import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin LoadDataJson on ChangeNotifier {
  dynamic loadDataJson() async {
    var response = await rootBundle.loadString('assets/data/data.json');

    if (response != null) {
      var decode = json.decode(response);
      return decode;
    } else {
      return null;
    }
  }
}
