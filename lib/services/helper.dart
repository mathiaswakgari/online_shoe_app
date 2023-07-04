import 'package:flutter/services.dart' as bundle;
import 'package:online_shoe_app/models/shoeModel.dart';

class Helper{
  Future<List<Shoe>> getMens()async{
    final response = await bundle.rootBundle.loadString("json/men_shoes.json");
    final mensShoes = shoesFromJson(response);

    return mensShoes;
  }

  Future<List<Shoe>> getWomens()async{
    final response = await bundle.rootBundle.loadString("json/women_shoes.json");
    final womensShoes = shoesFromJson(response);

    return womensShoes;
  }

  Future<Shoe> getMensById(int id)async{
    final response = await bundle.rootBundle.loadString("json/men_shoes.json");
    final mensShoes = shoesFromJson(response);

    final shoe = mensShoes.firstWhere((element) => element.id == id);

    return shoe;
  }

  Future<Shoe> getWomensById(int id)async{
    final response = await bundle.rootBundle.loadString("json/men_shoes.json");
    final womensShoes = shoesFromJson(response);

    final shoe = womensShoes.firstWhere((element) => element.id == id);

    return shoe;
  }
}