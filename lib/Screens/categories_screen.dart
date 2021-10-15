import 'package:amit_project/Screens/categories_products.dart';
import 'package:amit_project/logic/api.dart';
import 'package:amit_project/model/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: FutureBuilder<CategoriesVm>(
          future: API.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: EdgeInsets.only(top: size.height * .015),
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: size.width * .03,
                    crossAxisSpacing: size.width * .03,
                    children: List.generate(
                      snapshot.data!.categories!.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesProducts(
                                      categoryId:
                                          snapshot.data!.categories![index].id,
                                      categoryName: snapshot
                                          .data!.categories![index].name)));
                        },
                        child: Stack(
                          children: [
                            Image(
                              image: NetworkImage(
                                  '${snapshot.data!.categories![index].avatar}'),
                              fit: BoxFit.fill,
                              width: size.width * .5,
                              height: size.height * .5,
                            ),
                            Center(
                              child: Container(
                                  color: Colors.black.withOpacity(.5),
                                  child: Text(
                                    '${snapshot.data!.categories![index].name}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * .05),
                                  )),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
