import 'package:amit_project/Screens/custom_widget.dart';
import 'package:amit_project/cubit/cubit.dart';
import 'package:amit_project/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class BottomNavigtionScreen extends StatefulWidget {
  const BottomNavigtionScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigtionScreenState createState() => _BottomNavigtionScreenState();
}

class _BottomNavigtionScreenState extends State<BottomNavigtionScreen> {
  List screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
  ];

  List<dynamic> appBarName = [
    "Home",
    "Categories",
    "Cart",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => CubitClass(),
      child: BlocConsumer<CubitClass, States>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.grey,
            elevation: 1.0,
            title: Text(
              "\t\t\t\t${appBarName[CubitClass.get(context).CurrentIndex]}",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: size.width * .06,
              ),
            ),
            actions: [
              Container(
                width: size.width * .2,
                child: MaterialButton(
                  onPressed: () {
                    alertLogOutFunc(context: context, size: size);
                  },
                  padding: EdgeInsets.only(right: size.width * .0045),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.logout,
                          size: size.height * .04,
                          color: Colors.grey[600],
                        ),
                        Text(
                          "SignOut",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: CubitClass.get(context).CurrentIndex,
            onTap: (value) {
              CubitClass.get(context).index(value);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: size.height * .04,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category_outlined,
                    size: size.height * .04,
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: size.height * .04,
                  ),
                  label: 'Cart'),
            ],
          ),
          body: screens[CubitClass.get(context).CurrentIndex],
        ),
      ),
    );
  }
}
