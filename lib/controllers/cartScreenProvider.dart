
import 'package:flutter/material.dart';
class CartScreenNotifier extends ChangeNotifier{

  int _quantity = 0;

  int get quantity => _quantity;

  set quantity(int quantity){
    _quantity = quantity;
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



}