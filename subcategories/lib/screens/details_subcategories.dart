import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subcategories/models/listcategories.dart';

class SubCategoriesDetailScreen extends StatefulWidget {
  const SubCategoriesDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/subcategory-detail';

  @override
  State<SubCategoriesDetailScreen> createState() =>
      _SubCategoriesDetailScreenState();
}

class _SubCategoriesDetailScreenState extends State<SubCategoriesDetailScreen> {
  @override
  void initState() {
    super.initState();
    final data = Provider.of<AllCategories>(context, listen: false);
    data.loadCategories(context);
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AllCategories>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subcategories"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (data.details.isNotEmpty)
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
                                  data.details
                                    .elementAt(index)
                                    .name
                                    .toString(),
                                  style: const TextStyle(fontSize:10,
                                  fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      itemCount: data.details.length,
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
