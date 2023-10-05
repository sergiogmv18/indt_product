import 'package:flutter/material.dart';
import 'package:indt_products/style.dart';

Widget circularProgressIndicator(BuildContext context, {Color? color}) {
  return Center(
    child: CircularProgressIndicator(color:color ?? CustomColors.activeButtonColor),
  );
}

/*
 * Show icon circular for expect loading next step 
 * @author  SGV - 20230510
 * @version 1.0 - 20230510 - initial release
 * @param<color> - color   - color of circular progress
 * @return  <component> showDialog and redirect to previous page
 */
Future<void> showCircularLoadingDialog(BuildContext context ,{Color? color}) async {  
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: circularProgressIndicator(context, color:color)
      );
    }
  );
}