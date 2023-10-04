import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/models/product.dart';
import 'package:indt_products/style.dart';

class SpecificProductScreen extends StatefulWidget {
  final Product productWk;
 const  SpecificProductScreen({super.key, required this.productWk});
  @override
  State<SpecificProductScreen> createState() => _SpecificProductScreenState();
}
class _SpecificProductScreenState extends State<SpecificProductScreen> {
  late Product productWk;
  @override
  void initState() {  
    productWk = widget.productWk;
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:CustomColors.frontColor,
        appBar:appBarCustom(context, ),
        body:Container(
          child: Column(
            children: [
              Text(
                  productWk.getTitle()!,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child:  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:translate('cheer'),
                       //  style: themeFlamenco(textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 50, color: CustomColors().backgroundColorDark))
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text:translate('for your'),
                        //  style: themeFlamenco(textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 40, color: CustomColors().frontColor))
                        ),
                       
                        const TextSpan(text: '\n\n'),
                        TextSpan(
                          text:translate('cashback'),
                         // style: themeFlamenco(textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 50, color: CustomColors().backgroundColorDark))
                        ),
                      ]
                    )
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }


  /*
  * show widget case product list is empty 
  * @author SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
  showMessageUser(){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            translate('product list is empty, please update'),
            style:Theme.of(context).textTheme.titleLarge!
          ),
           IconButton(
            onPressed:()async{
              showCircularLoadingDialog(context);
              await ProductController().getProductsOfServer();
              Navigator.of(context).pop();
            }, 
            icon:const Icon(Icons.replay_outlined) 
          )
        ],
      )
    );
  }
}