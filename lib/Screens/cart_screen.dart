import 'package:amit_project/cubit/cubit.dart';
import 'package:amit_project/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => CubitClass(),
      child: BlocConsumer<CubitClass, States>(
        listener: (context, state) {},
        builder: (context, state) => Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: CubitClass.cartList.length,
                  itemBuilder: (context, index) => Container(
                    height: size.height * .2,
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(
                                  "${CubitClass.cartList[index].avatar}",
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Card(
                                elevation: 0.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "${CubitClass.cartList[index].title}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${CubitClass.cartList[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${CubitClass.cartList[index].priceFinalText}",
                                          style: TextStyle(
                                            color: Colors.red[600],
                                          ),
                                        ),
                                        Container(
                                          width: size.width * .1,
                                          height: size.height * .05,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                size.width * .01),
                                            color: Colors.red[600],
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  if (CubitClass.cartList[index]
                                                          .count! >
                                                      1) {
                                                    CubitClass.cartList[index]
                                                        .count = CubitClass
                                                            .cartList[index]
                                                            .count! -
                                                        1;
                                                    CubitClass.get(context)
                                                        .minusProductCount();
                                                    print(CubitClass
                                                        .cartList[index].count);
                                                  } else if (CubitClass
                                                          .cartList[index]
                                                          .count! ==
                                                      1) {
                                                    CubitClass.get(context)
                                                        .deleteProductFromCart(
                                                            CubitClass.cartList[
                                                                index]);
                                                  }
                                                },
                                                child: const Text(
                                                  "_",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      height: -.0),
                                                )),
                                          ),
                                        ),
                                        Container(
                                          width: size.width * .1,
                                          height: size.height * .05,
                                          color: Colors.grey[100],
                                          child: Center(
                                              child: Text(
                                            "${CubitClass.cartList[index].count}",
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                        Container(
                                          width: size.width * .1,
                                          height: size.height * .05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.red[600],
                                          ),
                                          child: Center(
                                            child: TextButton(
                                                onPressed: () {
                                                  CubitClass.cartList[index]
                                                      .count = CubitClass
                                                          .cartList[index]
                                                          .count! +
                                                      1;
                                                  CubitClass.get(context)
                                                      .plusProductCount();
                                                  print(CubitClass
                                                      .cartList[index].count);
                                                },
                                                child: const Text(
                                                  "+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      height: 1),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        )),
                        Container(
                          height: size.height * .004,
                          width: size.width,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      CubitClass.get(context).clearCart();
                    },
                    elevation: 20.0,
                    color: Colors.white,
                    textColor: Colors.black,
                    child: const Text("Clear Cart"),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.red[600],
                    textColor: Colors.white,
                    child: const Text("Go to Checkout"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
