import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      child: SimpleDialog(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 30,
              ),
              Text(
                R.strings.wait,
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ));
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
