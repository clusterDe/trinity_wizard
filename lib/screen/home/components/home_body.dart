import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/constant.dart';
import 'package:trinity_wizard/provider/home/home_provider.dart';
import 'package:trinity_wizard/widget/consumer_state_date/consumer_state_date.dart';

import 'card_contact.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await context.read<HomeProvider>().refresh();
        return;
      },
      child: ConsumerStateData<HomeProvider>(
        state: context.watch<HomeProvider>().stateContact!,
        message: context.watch<HomeProvider>().msgContact,
        enumValue: ResultGetContactState.values,
        builder: (context, homeProv, _) {
          var data = homeProv.listContact;

          if (data != null) {
            return GridView.builder(
              padding: EdgeInsets.all(defPadding),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: defPadding,
                crossAxisSpacing: defPadding,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CardContact(
                  press: () {
                    homeProv.goToDetailContact(
                      context,
                      index: index,
                    );
                  },
                  name: '${data[index].firstName} ${data[index].lastName}',
                );
              },
            );
          } else {
            return ListView(
              padding: EdgeInsets.all(defPadding),
              children: const [
                Center(
                  child: Text('Empty data'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
