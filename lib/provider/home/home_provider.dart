import 'package:flutter/material.dart';
import 'package:trinity_wizard/helpers/shared_pref_helper.dart';
import 'package:trinity_wizard/model/contact/list_contact.dart';
import 'package:trinity_wizard/provider/home/load_data_json.dart';

enum ResultGetContactState { loading, noData, hasData, error }

class HomeProvider extends ChangeNotifier with LoadDataJson {
  HomeProvider(BuildContext context) {
    loadDataFromJson();
  }

  // ----------- GET CONTACT ------------------

  ListContact? _dataContact;
  ListContact? get dataContact => _dataContact;

  ResultGetContactState? _stateContact;
  ResultGetContactState? get stateContact => _stateContact;

  String _msgContact = '';
  String get msgContact => _msgContact;

  loadDataFromJson() async {
    try {
      _stateContact = ResultGetContactState.loading;
      notifyListeners();

      var resultData = await loadDataJson();

      if (resultData == null) {
        _msgContact = 'no data';
        _stateContact = ResultGetContactState.noData;
        notifyListeners();
      } else {
        print('result data : $resultData');
        var listContact = ListContact.fromMap(resultData);

        _dataContact = listContact;
        _msgContact = 'has data';
        _stateContact = ResultGetContactState.hasData;
        notifyListeners();

        await saveListContact();
      }
    } catch (e) {
      _msgContact = '$e';
      _stateContact = ResultGetContactState.error;
      notifyListeners();
    }
  }

  // ----------- SAVE TO LOCAL -----------------

  final String _keyListContact = 'list_contact';

  saveListContact() async {
    if (_dataContact != null) {
      var json = _dataContact?.toJson();

      var result = await SharedPrefHelper.writeDataString(
        keyName: _keyListContact,
        dataName: '$json',
      );

      print('save to local : $result');
    }
  }

  // ---------- LOAD CONTACT FROM LOCAL --------------

  Future<bool> loadListContact() async {
    var result = await SharedPrefHelper.readDataString(
      keyName: _keyListContact,
    );

    if (result != null) {
      var listContact = ListContact.fromJson(result);
      _dataContact = listContact;
      notifyListeners();

      print('load data : $listContact');
      return true;
    } else {
      return false;
    }
  }

  // ---------- REFRESH -----------------

  refresh() async {
    try {
      _stateContact = ResultGetContactState.loading;
      notifyListeners();

      var resultData = await loadListContact();

      if (resultData == false) {
        _msgContact = 'no data';
        _stateContact = ResultGetContactState.noData;
        notifyListeners();
      } else {
        _msgContact = 'has data';
        _stateContact = ResultGetContactState.hasData;
        notifyListeners();

        await saveListContact();
      }
    } catch (e) {
      _msgContact = '$e';
      _stateContact = ResultGetContactState.error;
      notifyListeners();
    }
  }
}
