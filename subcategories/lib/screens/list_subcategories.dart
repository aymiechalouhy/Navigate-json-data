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
  List<SubCategories> mainCategories = [];

  Future<void> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/subcategories.json');
    final subCat = await json.decode(response);
    debugPrint(subCat.toString());
    var list = subCat["items"] as List<dynamic>;

    setState(() {
      mainCategories = list.map((e) => SubCategories.fromJson(e)).where((e)=>  e.parentCategoryId?.isEmpty ?? true).toList();
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
                onPressed: readJsonFile,
                child: const Text("Load SubCategories")),
          ), //  if (subcategories.isNotEmpty)
          if (mainCategories.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: mainCategories.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      margin: const EdgeInsets.all(15.0),
                      color: const Color.fromARGB(255, 138, 192, 218),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mainCategories[index].name),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            mainCategories[index].logo.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          // print(jsonEncode(products[index]));
                          Navigator.of(context).pushNamed(
                              SubCategoriesDetailScreen.routeName,
                              arguments: jsonEncode(mainCategories[index]));
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
