import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:subcategories/models/subcategories.dart';

class SubCategoriesDetailScreen extends StatefulWidget {
  const SubCategoriesDetailScreen({Key? key}) : super(key: key);
  
  static const String routeName = '/subcategory-detail';

  @override
  State<SubCategoriesDetailScreen> createState() =>
      _SubCategoriesDetailScreenState();
}

class _SubCategoriesDetailScreenState extends State<SubCategoriesDetailScreen> {
  List<SubCategories> _subCategories = [];
  Future<void> readJsonFile(String parentCategoryId) async {
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    debugPrint(subCat.toString());
    var list = subCat["items"] as List<dynamic>;
    setState(() {
      _subCategories = list
          .map((e) => SubCategories.fromJson(e))
          .where((e) => e.parentCategoryId == parentCategoryId)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the parent category id passed using Navigator.pushNamed
    String parentCategoryId =
        ModalRoute.of(context)!.settings.arguments as String;
    if (_subCategories.isEmpty) readJsonFile(parentCategoryId);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subcategories"),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: ElevatedButton(
            //       onPressed: () => readJsonFile(parentCategoryId),
            //       child: const Text("Load SubCategories")),
            // ), //  if (_subcategories.isNotEmpty)
            if (_subCategories.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _subCategories.length,
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                        margin: const EdgeInsets.all(15.0),
                        color: const Color.fromARGB(255, 138, 192, 218),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_subCategories[index].name),
                          ),
                        ));
                  },
                ),
              )
            else
              const Text("No Subcategoriess"),
          ],
        ));
  }
}
