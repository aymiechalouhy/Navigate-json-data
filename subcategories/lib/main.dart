import 'package:flutter/material.dart';
import 'package:subcategories/models/listcategories.dart';
import 'package:subcategories/screens/list_subcategories.dart';
import 'package:subcategories/screens/details_subcategories.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp()
    //  ChangeNotifierProvider(
    //   create: (context) => AllCategories(subcategories: ),
    //   child:  MyApp(),
    // ),
  );
    // MyApp()
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JsonSubCategories(),
      debugShowCheckedModeBanner: false,


      routes: {
        JsonSubCategories.routeName: (context) => const JsonSubCategories(),
        SubCategoriesDetailScreen.routeName: (context) =>const SubCategoriesDetailScreen()
      },
    );
  }
}
      