
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class CartScreenNotifier extends ChangeNotifier{

  final _cartBox = Hive.box("cart");

  int _quantity = 0;
  List<dynamic> _cart = [];

  int get quantity => _quantity;
  List<dynamic> get cart => _cart;

  set quantity(int quantity){
    _quantity = quantity;
    notifyListeners();
  }

  set cart(List<dynamic> newCart){
    _cart = newCart;
    notifyListeners();
  }

  void addQuantity(){
    _quantity += 1;
    notifyListeners();
  }
  void subQuantity(){
    _quantity -= 1;
    notifyListeners();
  }

  getCart(){
    final cartData = _cartBox.keys.map((key) {
      final shoe = _cartBox.get(key);
      return {
        "key": key,
        "id": shoe['id'],
        "category": shoe['category'],
        "name": shoe['name'],
        "imageUrl": shoe['imageUrl'],
        "price": shoe['price'],
        "sizes": shoe['sizes'],
        "qty": shoe['qty'],
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }

  Future<void> deleteCart(int key) async{
    await _cartBox.delete(key);
  }

  Future<void> clearCart() async{
    await _cartBox.clear();
  }

}