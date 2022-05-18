import 'package:flutter/material.dart';
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
  var subcatName = "";
  SubCategories? subcategories;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var subcategoryString = ModalRoute.of(context)?.settings.arguments as String;
    debugPrint('page 2');
    debugPrint(subcategoryString);

    var subcategoryJson = jsonDecode(subcategoryString);
    debugPrint(subcategoryJson);

    setState(() {
      subcategories = SubCategories.fromJson(subcategoryJson);
      subcatName = subcategories!.name;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subcatName),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: Text("id: " + (subcategories!.id),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
                margin: const EdgeInsets.all(5.0),
                child: Text("Name : " + (subcategories!.name.toString()),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0))),
            const SizedBox(
              height: 25,
            ),
            Container(
                margin: const EdgeInsets.all(5.0),
                child: Text(
                    "ParentId : " +
                        (subcategories!.parentCategoryId.toString()),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0))),
          ],
        ),
      ),
    );
  }
}
