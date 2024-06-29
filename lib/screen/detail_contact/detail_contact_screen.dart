import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/constant.dart';
import 'package:trinity_wizard/provider/detail_contact/detail_contact_provider.dart';

import 'components/detail_contact_body.dart';

class DetailContactScreen extends StatelessWidget {
  static const String routeName = 'detail_contact';
  const DetailContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: defPadding * 5,
        leading: SizedBox(
          height: defPadding,
          child: TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel'),
          ),
        ),
        actions: [
          Consumer<DetailContactProvider>(
            builder: (context, detContactProv, _) {
              return TextButton(
                onPressed: () {
                  detContactProv.saveContact(context);
                },
                child: const Text('Save'),
              );
            },
          ),
        ],
      ),
      body: const DetailContactBody(),
    );
  }
}
