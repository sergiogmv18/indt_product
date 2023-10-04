import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/style.dart';

class HomeScreen extends StatefulWidget {
 const  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() { 
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:CustomColors.frontColor,
        appBar:appBarCustom(context),
        body:FutureBuilder(
          future: ProductController().getProductsOfServer(),
          builder: (context, app){
            if(app.connectionState == ConnectionState.done){
              if(app.data!['success']){
                List  allProducts = app.data!['payload'];
                return 
                ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child:Card(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProductController.getImgProduct(context, url: allProducts[index].getThumbnail()!, width: 50, height: 50),
                              GestureDetector(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        allProducts[index].getTitle()!,
                                        style:Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        translate('see details'),
                                        style:Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.activeButtonColor),
                                      ),
                                    ]
                                  )
                                ),
                                onTap: (){
                                  Navigator.of(context).pushNamedAndRemoveUntil('/product', (route) => false, arguments: allProducts[index]);
                                },
                              ),
                              ProductController.productIsSaved(allProducts[index].getServerId()) ? const Icon(Icons.check) : 
                              IconButton(
                                onPressed:()async{
                                  showCircularLoadingDialog(context);
                                  await ProductController().save(productWk:allProducts[index]);
                                  Navigator.of(context).pushNamedAndRemoveUntil('/downloaded/products', (route) => false, arguments: allProducts[index]);
                                }, 
                                icon: const Icon(Icons.download)
                              )
                            ],
                          ),
                        )
                    );
                  }
                );
              }
            }
            if(app.hasError){
             return showMessageUser();
            }
            return circularProgressIndicator(context);
          }
        )
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