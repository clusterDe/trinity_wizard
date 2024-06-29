// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constant.dart';

class CardContact extends StatelessWidget {
  const CardContact({
    super.key,
    this.press,
    this.name,
  });

  final VoidCallback? press;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(defBorderRadius),
      child: Container(
        padding: EdgeInsets.all(defPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defBorderRadius),
          border: Border.all(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: defPadding * 3,
              width: defPadding * 3,
              decoration: BoxDecoration(
                color: orangeColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: defPadding),
            Text(name ?? '-'),
          ],
        ),
      ),
    );
  }
}
