import 'package:flutter/material.dart';

const String baseUrl = r'https://fakestoreapi.com/products';


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarError(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(message, style: TextStyle(color: Colors.white)),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarSuccess(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message, style: TextStyle(color: Colors.white)),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarAlert(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.yellow,
      content: Text(message, style: TextStyle(color: Colors.black)),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
