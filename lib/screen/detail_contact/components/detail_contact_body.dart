import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/constant.dart';
import 'package:trinity_wizard/provider/detail_contact/detail_contact_provider.dart';

class DetailContactBody extends StatelessWidget {
  const DetailContactBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.watch<DetailContactProvider>().formKey,
      child: Consumer<DetailContactProvider>(
        builder: (context, detContactProv, _) {
          return ListView(
            padding: EdgeInsets.all(defPadding),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: orangeColor,
                ),
              ),
              SizedBox(height: defPadding * 2),
              const Text(
                'Main Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: defPadding),
              Row(
                children: [
                  const Text('First Name'),
                  SizedBox(width: defPadding),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: detContactProv.firstNameCtrl,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Input your first name',
                            labelText: 'First name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kInvalidFirstNameError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: defPadding),
              Row(
                children: [
                  const Text('Last Name'),
                  SizedBox(width: defPadding),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: detContactProv.lastNameCtrl,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Input your last name',
                            labelText: 'Last name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kInvalidLastNameError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: defPadding * 3),
              const Text(
                'Sub Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: defPadding),
              Row(
                children: [
                  const Text('Email'),
                  SizedBox(width: defPadding),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: detContactProv.emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Input your email',
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kInvalidEmailError;
                            } else if (!emailValidatorRegExp.hasMatch(value)) {
                              return kInvalidEmailError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: defPadding),
              Row(
                children: [
                  const Text('Phone'),
                  SizedBox(width: defPadding),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: detContactProv.phoneCtrl,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Input your phone',
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: defPadding),
              Row(
                children: [
                  const Text('DOB'),
                  SizedBox(width: defPadding),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          readOnly: true,
                          onTap: () async {
                            await detContactProv.selectDob(context);
                          },
                          controller: detContactProv.dobCtrl,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            hintText: 'Input your DOB',
                            labelText: 'DOB',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kInvalidFirstNameError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: defPadding * 3),
            ],
          );
        },
      ),
    );
  }
}
