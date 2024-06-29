import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trinity_wizard/helpers/shared_pref_helper.dart';
import 'package:trinity_wizard/model/contact/contact_model.dart';
import 'package:trinity_wizard/model/contact/list_contact.dart';
import 'package:trinity_wizard/provider/home/load_data_json.dart';
import 'package:trinity_wizard/screen/detail_contact/detail_contact_screen.dart';

const String keyListContact = 'list_contact';

enum ResultGetContactState { loading, noData, hasData, error }

class HomeProvider extends ChangeNotifier with LoadDataJson {
  HomeProvider(BuildContext context) {
    initCOntroller();
    refresh();
  }

  initCOntroller() {
    _searchCtrl = TextEditingController();
  }

  // ----------- GET CONTACT ------------------

  List<ContactModel>? _listContact = [];
  List<ContactModel>? get listContact => _listContact;

  ListContact? _dataContact;
  ListContact? get dataContact => _dataContact;

  ResultGetContactState? _stateContact;
  ResultGetContactState? get stateContact => _stateContact;

  String _msgContact = '';
  String get msgContact => _msgContact;

  Future<bool> loadDataFromJson() async {
    var resultData = await loadDataJson();

    if (resultData == null) {
      return false;
    } else {
      print('result data : $resultData');
      var listContact = ListContact.fromMap(resultData);

      _dataContact = listContact;
      _listContact?.addAll(listContact.data!);

      notifyListeners();

      await saveListContact();

      return true;
    }
  }

  // ----------- SAVE TO LOCAL -----------------

  saveListContact() async {
    if (_dataContact != null) {
      var json = _dataContact?.toJson();

      var result = await SharedPrefHelper.writeDataString(
        keyName: keyListContact,
        dataName: '$json',
      );

      print('save to local : $result');
    }
  }

  // ---------- LOAD CONTACT FROM LOCAL --------------

  Future<bool> loadListContact() async {
    var result = await SharedPrefHelper.readDataString(
      keyName: keyListContact,
    );

    if (result != null) {
      var listContact = ListContact.fromJson(result);
      _dataContact = listContact;
      _listContact?.addAll(listContact.data!);
      notifyListeners();

      print('load data : $_listContact');
      return true;
    } else {
      var result = await loadDataFromJson();

      if (result) {
        return true;
      } else {
        return false;
      }
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

  // ------------ GOTO DETAIL CONTACT ------------------

  goToDetailContact(BuildContext context, {int? index}) async {
    if (index != null) {
      context.goNamed(
        DetailContactScreen.routeName,
        extra: _listContact?[index],
      );
    } else {
      context.goNamed(
        DetailContactScreen.routeName,
      );
    }
  }

  // ------------ SEARCH CONTROLLER -------------------

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  changeValSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
    clearSearch();
  }

  TextEditingController? _searchCtrl;
  TextEditingController? get searchCtrl => _searchCtrl;

  searchByName() {
    var where = _dataContact?.data?.where(
      (element) {
        var firstName = element.firstName!.toLowerCase();
        var lastName = element.lastName!.toLowerCase();
        var search = _searchCtrl!.text.toLowerCase();

        var contains = firstName.contains(search);
        var contains2 = lastName.contains(search);

        return contains || contains2;
      },
    ).toList();

    print('result search : $where');
    _listContact = [];
    notifyListeners();
    _listContact?.addAll(where!);
  }

  clearSearch() {
    _listContact = [];
    _searchCtrl?.clear();
    notifyListeners();
    _listContact = _dataContact?.data;
    notifyListeners();
  }

  // // ------------ SAVE NEW CONTACT --------------------

  // ContactModel? _newContact;

  // saveNewContact({ContactModel? newContact}) {
  //   if (newContact != null) {
  //     _newContact = newContact;
  //     notifyListeners();

  //     print('new contact : $newContact');
  //   }
  // }

  // addDataNewContact() {
  //   if (_listContact != null && _newContact != null) {
  //     for (var element in _listContact!) {
  //       if (element.id == _newContact?.id) {
  //         print('new contact : $_newContact');
  //         print('old contact : $element');
  //       }
  //     }
  //   }
  // }
}
