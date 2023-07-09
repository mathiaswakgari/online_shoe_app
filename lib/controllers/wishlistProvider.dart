import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WishlistNotifier extends ChangeNotifier{

  final _cartBox = Hive.box('cart');

  final _wishlistBox = Hive.box("wishlist");

  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];

  List<dynamic> get ids => _ids;

  set ids(List<dynamic> ids){
    _ids = ids;
    notifyListeners();
  }

  set favorites(List<dynamic> favorites){
    _favorites = favorites;
    notifyListeners();
  }

  getWishlists(){
    final wishlistData = _wishlistBox.keys.map((key){
      final shoe = _wishlistBox.get(key);

      return {
        "key": key,
        "id":shoe["id"]
      };
    }).toList();

    _favorites = wishlistData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
  }

  Future<void> createWishlist(Map<String, dynamic> wishlist)async{
    await _wishlistBox.add(wishlist);
  }
}