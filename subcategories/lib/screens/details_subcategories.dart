import 'dart:math';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (_subCategories.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: FutureBuilder(builder: ((context, snapshot) {
                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2/ 2,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) => Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(                                                          
                                  _subCategories[index].name,
                                  style: const TextStyle(fontSize: 8.2,
                                  fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      itemCount: _subCategories.length,
                    );
                  })),
                )
              else
                const Text("No Subcategoriess"),
            ],
          ),
        ));
  }
}
