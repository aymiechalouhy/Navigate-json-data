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
  List<SubCategories> subcategories = [];

  void navigate() {
    readJsonFile();
  }

  Future<void> readJsonFile() async {
    final String response =
    await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    debugPrint(subCat.toString());
    var list = subCat["items"] as List<dynamic>;

    setState(() {
      subcategories = list.map((e) => SubCategories.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("load json file"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                onPressed: navigate, child: const Text("Load SubCategories")),
          ), //  if (subcategories.isNotEmpty)
          if (subcategories.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: subcategories.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      margin: const EdgeInsets.all(15.0),
                      color: Colors.greenAccent,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(subcategories[index].name),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            subcategories[index].id.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          // print(jsonEncode(products[index]));
                          Navigator.of(context).pushNamed(
                              SubCategoriesDetailScreen.routeName,
                              arguments: jsonEncode(subcategories[index]));
                        },
                      ));
                },
              ),
            )
          else
            const Text("No Subcategoriess"),
        ],
      ),
    );
  }
}

/*
items
isEmpty
*/
