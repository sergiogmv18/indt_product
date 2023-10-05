import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/controllers/navigator_controller.dart';
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
     onWillPop: () => NavigatorContoller().onWillPop(context,backToScreen: true, routeName: '/'),
      child: Scaffold(
        backgroundColor:CustomColors.frontColor,
        appBar:appBarCustom(
          context,
          showButtonReturn: true,
          showactions: false,
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);                            
          }
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                ),
                items: productWk.getImages()! .map((item) => Container(
                  alignment: Alignment.center,
                  child:ProductController.getImgProduct(context, url: item, width:  MediaQuery.of(context).size.width * 0.8),
                )).toList(),
              ),
              const SizedBox(height: 20), 
              Card(
                elevation: 4,
                child:Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Text(
                        productWk.getTitle()!,
                        style:Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20), 
                      Text(
                        productWk.getDescription()!,
                        style:Theme.of(context).textTheme.titleMedium,
                      ),
                       const SizedBox(height: 10),  
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child:Text.rich(
                          TextSpan(
                            children: [
    // PRICE
                              TextSpan(
                                text:'${translate('price')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getPrice()!.toStringAsFixed(0),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
    // DISCOUNT PERCENTAGE
                              TextSpan(
                                text:'${translate('discount percentage')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getDiscountPercentage().toString(),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
    // RATING
                              TextSpan(
                                text:'${translate('rating')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getRating().toString(),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
    //STOCK
                              TextSpan(
                                text:'${translate('stock')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getStock().toString(),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
    // BRAND
                            TextSpan(
                                text:'${translate('brand')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getBrand().toString(),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
    // CATEGORY
                              TextSpan(
                                text:'${translate('category')}: ',
                                style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: productWk.getCategory().toString(),
                                style:Theme.of(context).textTheme.titleMedium!
                              ),
                              const TextSpan(
                                text: '\n'
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left
                        ),
                      )
                    ],
                  ),
                )
              )
            ]
          )
        ),
      ),   
    );
  }
}
