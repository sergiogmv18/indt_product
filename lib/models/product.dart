import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:indt_products/models/Model_base.dart';

@Entity(tableName: 'Product')
class Product extends ModelBase {
  String? title;
  String? description;
  String? images;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  /// Constructor
  Product({int? id, int? serverId, this.title, this.description, this.images, this.price, this.discountPercentage, this.rating, this.stock, this.brand, this.category, this.thumbnail}) : super( id: id, serverId: serverId);

  /// GETs
  List? getImages(){
    List response = images != null ? json.decode(images!) : [];
    return response; 
  }

  String? getTitle(){
    return title;
  }

  String? getDescription(){
    return title;
  }

  double? getPrice(){
    return price;
  }

  double? getDiscountPercentage(){
    return discountPercentage;
  }

  double? getRating(){
    return rating;
  }

  int? getStock(){
    return stock;
  }

  String? getBrand(){
    return brand;
  }

  String? getCategory(){
    return category;
  }

  String? getThumbnail(){
    return thumbnail;
  }

  /// SETs
  void setImages(List? images){
    this.images = json.encode(images);
  }

  void setTitle(String? title){
    this.title = title;
  }

  void setDescription(String? description){
    this.description = description;
  }

  void setPrice(double? price){ 
    this.price = price;
  }
  void setRating(double? rating){ 
    this.rating = rating;
  }

  void setDiscountPercentage(double? discountPercentage){
    this.discountPercentage = discountPercentage;
  }

  void setStock(int? stock){ 
    this.stock = stock;
  }

  void setBrand(String? brand){ 
    this.brand = brand;
  }

  void setCategory(String? category){ 
    this.category =  category;
  }

  void setThumbnail(String? thumbnail){
    this.thumbnail = thumbnail;
  }

  ///OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serverId': serverId,
      'title':title,
      'description': description,
      'price':price,
      'discountPercentage':discountPercentage,
      'rating':rating,
      'stock': stock,
      'brand':brand,
      'category': category,
      'thumbnail':thumbnail,
      'images': images
    };
  }
}