import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subcategories/models/listcategories.dart';
import 'package:subcategories/screens/details_subcategories.dart';

class JsonSubCategories extends StatefulWidget {
  const JsonSubCategories({Key? key}) : super(key: key);

  static const String routeName = '/subcategory-list';

  @override
  _JsonSubCategoriesState createState() => _JsonSubCategoriesState();
}

class _JsonSubCategoriesState extends State<JsonSubCategories> {
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
        title: const Text("load json file"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (data.mainCategories.isNotEmpty)
              FutureBuilder(
                builder: (context, snapshot) {
                  return GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 0),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: SingleChildScrollView(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SubCategoriesDetailScreen.routeName,
                                arguments:
                                    data.mainCategories.elementAt(index).id);
                          },
                          child: (Column(
                            children: [
                              Image.network(
                                data.mainCategories
                                    .elementAt(index)
                                    .logo
                                    .toString(),
                                errorBuilder: (ctx, o, n) {
                                  return Image.asset(
                                    "assets/images/load.png",
                                    height: 40,
                                    width: 40,
                                    errorBuilder: (ctx, o, n) {
                                      return Image.asset("assets/load.png");
                                    },
                                  );
                                },
                                height: 100,
                                width: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  data.mainCategories.elementAt(index).name,
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    itemCount: data.mainCategories.length,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
