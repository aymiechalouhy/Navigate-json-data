import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subcategories/models/subcategories.dart';

class AllCategories with ChangeNotifier {
  late Iterable<SubCategories> mainCategories = const Iterable.empty();
  late Iterable<SubCategories> subcategories = const Iterable.empty();
  late Iterable<SubCategories> details = const Iterable.empty();

  Future loadCategories(context) async {
    debugPrint("Loading Categories !--------------!");
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    var list = subCat["items"] as List<dynamic>;
    subcategories = list.map((e) => SubCategories.fromJson(e));
    mainCategories =
        subcategories.where((e) => e.parentCategoryId?.isEmpty ?? true);
         String parentCategoryId =
        ModalRoute.of(context)!.settings.arguments as String;
    details= subcategories.where((e) => e.parentCategoryId == parentCategoryId)
          .toList();
    notifyListeners();
  }
}
