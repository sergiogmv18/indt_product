import 'package:flutter/material.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/services/request.dart';
import 'package:indt_products/style.dart';

class AlertDialogCustom extends StatelessWidget {
 final List<Widget>? actions;
  final String? title;
  final Widget? content;
  const AlertDialogCustom({super.key, this.actions, this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.frontColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Radio del borde del Card
      ),
      title: Text(
        title!,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: content, 
      actions:actions
    );
  }
}

/*
 * Show message Error to user
 * @author  SGV   - 20230510
 * @version 1.0   - 20230510 - initial release
 * @param   <int> - errorServer    - mumber of specific of error 
 * @return <component> widget BottomNavigationBar
 */
showMessageErrorServer(BuildContext context,{required int errorServer,  required void Function() onPressed})async{
  String title = Request.errorServer(errorServer);
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialogCustom(
        title: translate('attention'),
        content:Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed:onPressed, 
            child:Text(
              'ok',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }
  );
}