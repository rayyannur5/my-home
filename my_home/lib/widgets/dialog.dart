import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/styles.dart';

class Dialogg {
  static call(BuildContext context, {required Widget child}) {
    print('manggil dialog');
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColor.bg(),
        elevation: 25,
        insetAnimationCurve: Curves.decelerate,
        insetAnimationDuration: Duration(milliseconds: 300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
