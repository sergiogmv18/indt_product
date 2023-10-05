import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/routes.dart';
import 'package:indt_products/style.dart';

class IndtProducts extends StatelessWidget {
  const IndtProducts({Key? key}) : super(key: key);
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        title: 'Indt products',
        theme: IndtProductStyle().theme,
        localizationsDelegates: const [
          TranslationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: TranslateController.supportedLocales,
        debugShowCheckedModeBanner: false,
        routes: routes,
    );
  }
}

 