import 'package:amit_project/cubit/cubit.dart';
import 'package:amit_project/cubit/states.dart';
import 'package:amit_project/model/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetails extends StatelessWidget {
  Product selectedItem;
  ItemDetails({Key? key, required this.selectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    selectedItem.count = 1;

    return BlocProvider(
      create: (context) => CubitClass(),
      child: BlocConsumer<CubitClass, States>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.red[400],
            shadowColor: Colors.grey,
            elevation: 1.0,
            title: Text(
              "Details",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: size.width * .06,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * .35,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('${selectedItem.avatar}'),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.all(size.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${selectedItem.title}',
                      style: TextStyle(
                          fontSize: size.height * .04,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text(
                      '${selectedItem.name}',
                      style: TextStyle(
                        fontSize: size.height * .025,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      height: size.width * .0045,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        Text(
                          '${selectedItem.price} EGP',
                          style: TextStyle(
                              fontSize: size.height * .023, color: Colors.red),
                        ),
                        SizedBox(
                          width: size.width * .29,
                        ),
                        Container(
                          width: size.width * .1,
                          height: size.height * .05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red[600],
                          ),
                          child: Center(
                            child: TextButton(
                                onPressed: () {
                                  if (selectedItem.count! > 1) {
                                    selectedItem.count =
                                        selectedItem.count! - 1;

                                    CubitClass.get(context).minusProductCount();
                                  }
                                },
                                child: const Text(
                                  "_",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    height: -.0,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Text(
                            '${selectedItem.count} ',
                            style: TextStyle(fontSize: size.height * .025),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Container(
                          width: size.width * .1,
                          height: size.height * .05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red[600],
                          ),
                          child: Center(
                            child: TextButton(
                                onPressed: () {
                                  selectedItem.count =
                                      (selectedItem.count! + 1);
                                  CubitClass.get(context).plusProductCount();
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
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Container(
                      height: size.width * .006,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      '${selectedItem.description}',
                      style: TextStyle(
                        fontSize: size.height * .025,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: MaterialButton(
                    onPressed: () {
                      selectedItem.count = 1;
                      bool repetition = false;

                      for (int i = 0; i < CubitClass.cartList.length; i++) {
                        if (selectedItem.id == CubitClass.cartList[i].id) {
                          repetition = true;
                          CubitClass.cartList[i].count =
                              CubitClass.cartList[i].count! + 1;
                          break;
                        }
                      }
                      if (repetition == false) {
                        CubitClass.cartList.add(selectedItem);
                      }
                    },
                    color: Colors.red[700],
                    height: size.height * .06,
                    minWidth: size.width * .85,
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                          color: Colors.white, fontSize: size.width * .05),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }
}
