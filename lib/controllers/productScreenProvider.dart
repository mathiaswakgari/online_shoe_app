import 'package:flutter/material.dart';

class ProductScreenNotifier extends ChangeNotifier{

  int _activePage = 0;
  double _rating = 0;
  List<dynamic> _selectedSizes = [];
  List<dynamic> _sizes = [];

  int get activePage => _activePage;
  double get rating => _rating;
  List<dynamic> get selectedSizes => _selectedSizes;
  List<dynamic> get sizes => _sizes;

  set activePage(int newIndex){
    _activePage = newIndex;
    notifyListeners();
  }

  set selectedSizes(List<dynamic> newList){
    _selectedSizes = newList;
    notifyListeners();
  }

  set sizes(List<dynamic> newSizes){
    _sizes = newSizes;
    notifyListeners();
  }

  set rating(double newRating){
    _rating = newRating;
    notifyListeners();
  }

  void toggleCheck(int index){
    for(int i =0 ; i < _selectedSizes.length; i++){
      if(i == index){
        _selectedSizes[i]['isSelected'] = !_selectedSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

}