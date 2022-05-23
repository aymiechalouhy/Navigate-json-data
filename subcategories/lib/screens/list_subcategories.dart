import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subcategories/models/subcategories.dart';
import 'package:subcategories/screens/details_subcategories.dart';

class JsonSubCategories extends StatefulWidget {
  const JsonSubCategories({Key? key}) : super(key: key);

  static const String routeName = '/subcategory-list';

  @override
  _JsonSubCategoriesState createState() => _JsonSubCategoriesState();
}

class _JsonSubCategoriesState extends State<JsonSubCategories> {
 
  List<SubCategories> _mainCategories = [];
  Future<void> readJsonFile() async {
    debugPrint("!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!Reading json file");
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    debugPrint(subCat.toString());
    var list = subCat["items"] as List<dynamic>;

    setState(() {
      _mainCategories = list
          .map((e) => SubCategories.fromJson(e))
          .where((e) => e.parentCategoryId?.isEmpty ?? true)
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_mainCategories.isEmpty) {
      readJsonFile();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("load json file"),
      ),
      body: Column(
        children: [    
          if (_mainCategories.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _mainCategories.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      margin: const EdgeInsets.all(15.0),
                      color: const Color.fromARGB(255, 138, 192, 218),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_mainCategories[index].name), 
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            _mainCategories[index].logo.toString(),
                            height: 100,
                            width: 100,
                               errorBuilder: (ctx, o, n) {
                                  return
                                  const Icon(Icons.error);
                                },
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              SubCategoriesDetailScreen.routeName,
                              arguments: _mainCategories[index].id);
                        },
                      ));
                },
              ),
            )
          // else
          //   const Text("No Subcategoriess"),
        ],
      ),
    );
  }
}
