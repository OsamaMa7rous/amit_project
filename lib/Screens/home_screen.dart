import 'package:amit_project/cubit/cubit.dart';
import 'package:amit_project/logic/api.dart';
import 'package:amit_project/model/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: FutureBuilder<ProductsVm>(
          future: API.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: size.width * .01,
                    crossAxisSpacing: size.width * .01,
                    padding: EdgeInsets.only(top: size.height * .01),
                    children: List.generate(
                      snapshot.data!.products!.length,
                      (index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.width * .02),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ItemDetails(
                                                  selectedItem: snapshot
                                                      .data!.products![index],
                                                )));
                                  },
                                  child: Image(
                                    image: NetworkImage(
                                        '${snapshot.data!.products![index].avatar}'),
                                    fit: BoxFit.fill,
                                    width: size.width * .5,
                                    height: size.height * .5,
                                  )),
                              flex: 4,
                            ),
                            Expanded(
                              child: Text(
                                '\t\t\t\t\t${snapshot.data!.products![index].title}',
                                style: TextStyle(
                                    fontSize: size.height * .02,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\t\t${snapshot.data!.products![index].name}',
                                style: TextStyle(
                                  fontSize: size.height * .02,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                      onPressed: () {
                                        snapshot.data!.products![index].count =
                                            1;

                                        CubitClass.get(context)
                                            .addProductToCart(snapshot
                                                .data!.products![index]);
                                      },
                                      color: Colors.red[700],
                                      height: size.height * .03,
                                      minWidth: size.width * .09,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height * .025),
                                      )),
                                  Text(
                                    '${snapshot.data!.products![index].price} EGP',
                                    style: TextStyle(
                                        fontSize: size.height * .023,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
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
        ),
      ),
    );
  }
}
