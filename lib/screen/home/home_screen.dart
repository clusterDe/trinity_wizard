import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/constant.dart';
import 'package:trinity_wizard/provider/home/home_provider.dart';

import 'components/home_body.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProv, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                homeProv.changeValSearch();
              },
              icon: Icon(
                Icons.search,
                color: orangeColor,
              ),
            ),
            centerTitle: true,
            title: const Text('Contact'),
            actions: [
              IconButton(
                onPressed: () {
                  homeProv.goToDetailContact(context);
                },
                icon: Icon(
                  Icons.add,
                  color: orangeColor,
                ),
              ),
            ],
            bottom: homeProv.isSearch
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: defPadding),
                      child: TextFormField(
                        controller: homeProv.searchCtrl,
                        decoration: InputDecoration(
                          suffixIcon: homeProv.searchCtrl?.text != ''
                              ? IconButton(
                                  onPressed: () {
                                    homeProv.clearSearch();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: orangeColor,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          homeProv.searchByName();
                        },
                      ),
                    ),
                  )
                : null,
          ),
          body: const HomeBody(),
        );
      },
    );
  }
}
