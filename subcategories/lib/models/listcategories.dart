import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subcategories/models/subcategories.dart';

class AllCategories with ChangeNotifier {
  Iterable<SubCategories> subcategories;

    Iterable<SubCategories> get sub => subcategories;

  AllCategories({
    required this.subcategories,
  });

  Future loadCategories() async {
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    var list = subCat["items"] as List<dynamic>;
    subcategories = list.map((e) => SubCategories.fromJson(e));
    notifyListeners();
  }


}
