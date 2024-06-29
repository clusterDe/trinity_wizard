import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trinity_wizard/helpers/date_time_helper.dart';
import 'package:trinity_wizard/model/contact/contact_model.dart';
import 'package:trinity_wizard/widget/loading/pop_loading.dart';

import '../../helpers/shared_pref_helper.dart';
import '../../model/contact/list_contact.dart';
import '../home/home_provider.dart';

class DetailContactProvider extends ChangeNotifier {
  DetailContactProvider(
    BuildContext context, {
    ContactModel? contact,
  }) {
    loadDataContact(contact);
  }

  // ------------ LOAD CONTACT --------------

  ContactModel? _dataContact;
  ContactModel? get dataContact => _dataContact;

  loadDataContact(ContactModel? data) {
    if (data != null) {
      _dataContact = data;
      notifyListeners();
    }

    initController();
  }

  // --------- INIT CONTROLLER -----------------

  initController() {
    _formKey = GlobalKey<FormState>();
    _firstNameCtrl = TextEditingController(text: _dataContact?.firstName);
    _lastNameCtrl = TextEditingController(text: _dataContact?.lastName);
    _emailCtrl = TextEditingController(text: _dataContact?.email);
    _phoneCtrl = TextEditingController(text: _dataContact?.phone);
    if (_dataContact?.dob != null) {
      var formatDateFromString = DateTimeHelper.formatDateFromString(
        date: '${_dataContact?.dob}',
      );

      _dobCtrl = TextEditingController(text: formatDateFromString);
    } else {
      _dobCtrl = TextEditingController();
    }
  }

  // ---------- FORM CONTROLLER -----------------

  GlobalKey<FormState>? _formKey;
  GlobalKey<FormState>? get formKey => _formKey;

  // ------------ FIRST NAME CONTROLLER -------------

  TextEditingController? _firstNameCtrl;
  TextEditingController? get firstNameCtrl => _firstNameCtrl;

  // ------------ LAST NAME CONTROLLER -------------

  TextEditingController? _lastNameCtrl;
  TextEditingController? get lastNameCtrl => _lastNameCtrl;

  // ------------ EMAIL CONTROLLER -------------

  TextEditingController? _emailCtrl;
  TextEditingController? get emailCtrl => _emailCtrl;

  // ------------ PHONE CONTROLLER -------------

  TextEditingController? _phoneCtrl;
  TextEditingController? get phoneCtrl => _phoneCtrl;

  // ------------ DOB CONTROLLER -------------

  TextEditingController? _dobCtrl;
  TextEditingController? get dobCtrl => _dobCtrl;

  // ------------ SELECT DOB -----------------

  selectDob(BuildContext context) async {
    var dateTime = DateTime.now();
    var resultDate = await showDatePicker(
      context: context,
      firstDate: dateTime.subtract(const Duration(days: 30000)),
      lastDate: dateTime,
    );

    print('date : $resultDate');

    if (resultDate == null) return;

    var formatDate = DateTimeHelper.formatDate(dateTime: resultDate);

    _dobCtrl?.text = formatDate;
    notifyListeners();
  }

  // ----------- SAVE CONTACT ----------------

  saveContact(BuildContext context) async {
    if (_formKey!.currentState!.validate()) {
      popLoading(context);

      var formatDateToDb = DateTimeHelper.formatDateToDb(
        date: '${_dobCtrl?.text}',
      );

      String? contactId;

      if (_dataContact != null) {
        contactId = _dataContact?.id;
      } else {
        var random = Random.secure();

        contactId = '$random';
      }

      print('contact id : $contactId');

      var contactModel = ContactModel(
        id: contactId,
        firstName: _firstNameCtrl?.text,
        lastName: _lastNameCtrl?.text,
        email: _emailCtrl?.text,
        phone: _phoneCtrl?.text,
        dob: formatDateToDb,
      );

      await loadLocalListContact();

      print('new contact : $contactModel');

      await addNewData(newContact: contactModel);

      if (!context.mounted) return;
      context
        ..pop()
        ..pop();
    }
  }

  // ---------- LOAD CONTACT FROM LOCAL --------------

  ListContact? _dataListContact;

  Future<bool> loadLocalListContact() async {
    var result = await SharedPrefHelper.readDataString(
      keyName: keyListContact,
    );

    if (result != null) {
      var listContact = ListContact.fromJson(result);

      _dataListContact = listContact;
      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  addNewData({required ContactModel newContact}) async {
    if (_dataListContact?.data != null && _dataContact != null) {
      var list = _dataListContact?.data?.map(
        (element) {
          var result = element.id == newContact.id;

          if (result) {
            print('old data : $element');
            element = newContact;
            notifyListeners();
            print('new data : $element');

            return element;
          } else {
            return element;
          }
        },
      ).toList();

      _dataListContact = ListContact(data: list);
      notifyListeners();

      print('new list : $_dataListContact}');

      await saveListContact();
    } else {
      _dataListContact?.data?.add(newContact);
      notifyListeners();

      await saveListContact();

      print('add new contact : ${_dataListContact?.data}');
    }
  }

  // ----------- SAVE TO LOCAL -----------------

  saveListContact() async {
    if (_dataListContact != null) {
      var json = _dataListContact?.toJson();

      var result = await SharedPrefHelper.writeDataString(
        keyName: keyListContact,
        dataName: '$json',
      );

      print('save to local : $result');
    }
  }
}
