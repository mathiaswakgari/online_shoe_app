import 'package:flutter/material.dart';

class ProductScreenNotifier extends ChangeNotifier{

  int _activePage = 0;
  double _rating = 0;

  int get activePage => _activePage;
  double get rating => _rating;

  set activePage(int newIndex){
    _activePage = newIndex;
    notifyListeners();
  }

  set rating(double newRating){
    _rating = newRating;
    notifyListeners();
  }

}