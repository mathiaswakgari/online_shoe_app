import 'dart:convert';

List<Shoe> shoesFromJson(String str) => List<Shoe>.from(json.decode(str).map((x) => Shoe.fromJson(x)));

class Shoe{

  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;

  Shoe({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
});

 factory Shoe.fromJson(Map<String, dynamic> json) {
   return Shoe(
     id: json["id"],
     name: json["name"],
     category: json["category"],
     imageUrl: List<String>.from(json["imageUrl"].map((x)=> x)),
     oldPrice: json["oldPrice"],
     sizes: List<dynamic>.from(json["sizes"].map((x)=>x)),
     price: json["price"],
     description: json["description"],
     title: json["title"]);
 }

}