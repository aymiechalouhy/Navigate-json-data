import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subcategories/models/subcategories.dart';
import 'package:provider/provider.dart';

class AllCategories with ChangeNotifier {
  late Iterable<SubCategories> mainCategories = Iterable.empty();
  late Iterable<SubCategories> subcategories = Iterable.empty();

  // Iterable<SubCategories> get sub => subcategories;

  Future loadCategories(context) async {
    debugPrint("Loading Categories !--------------!");
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    var list = subCat["items"] as List<dynamic>;
    subcategories = list.map((e) => SubCategories.fromJson(e));
    mainCategories =
        subcategories.where((e) => e.parentCategoryId?.isEmpty ?? true);
    notifyListeners();
  }
}
