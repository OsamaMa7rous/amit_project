import 'package:amit_project/cubit/cubit.dart';
import 'package:amit_project/logic/api.dart';
import 'package:amit_project/model/products_model.dart';
import 'package:flutter/material.dart';

import 'item_details_screen.dart';

class CategoriesProducts extends StatelessWidget {
  String? categoryName;
  int? categoryId;
  CategoriesProducts({Key? key, this.categoryId, this.categoryName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        shadowColor: Colors.grey,
        elevation: 1.0,
        title: Text(
          "\t\t\t\t Products",
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: size.width * .06,
          ),
        ),
      ),
      backgroundColor: Colors.grey[400],
      body: FutureBuilder<ProductsVm>(
        future: API.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Product> productsList = snapshot.data!.products!
                .where((element) => categoryId == element.categoryId)
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: size.width * .01,
                  crossAxisSpacing: size.width * .01,
                  padding: EdgeInsets.only(top: size.height * .01),
                  children: List.generate(
                    productsList.length,
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
                                                selectedItem:
                                                    productsList[index],
                                              )));
                                },
                                child: Image(
                                  image: NetworkImage(
                                      '${productsList[index].avatar}'),
                                  fit: BoxFit.fill,
                                  width: size.width * .5,
                                  height: size.height * .5,
                                )),
                            flex: 4,
                          ),
                          Expanded(
                            child: Text(
                              '\t\t\t\t\t${productsList[index].title}',
                              style: TextStyle(
                                  fontSize: size.height * .02,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\t\t${productsList[index].name}',
                              style: TextStyle(
                                fontSize: size.height * .02,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                    onPressed: () {
                                      productsList[index].count = 1;
                                      bool repetition = false;

                                      for (int i = 0;
                                          i < CubitClass.cartList.length;
                                          i++) {
                                        if (productsList[index].id ==
                                            CubitClass.cartList[i].id) {
                                          repetition = true;
                                          CubitClass.cartList[i].count =
                                              CubitClass.cartList[i].count! + 1;
                                          break;
                                        }
                                      }
                                      if (repetition == false) {
                                        CubitClass.cartList
                                            .add(productsList[index]);
                                      }
                                      //   CubitClass.cartList.add(productsList[index]);
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
                                  '${productsList[index].price} EGP',
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
    );
  }
}
