import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screen/admin_orders/admin_orders_screen.dart';
import 'package:lojavirtual/screen/admin_users/admin_users_screen.dart';
import 'package:lojavirtual/screen/home/home_screen.dart';
import 'package:lojavirtual/screen/orders/orders_screen.dart';
import 'package:lojavirtual/screen/products/products_screen.dart';
import 'package:provider/provider.dart';

/*
  nesse parte é onde ficarar as telas do app

*/
class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),

      child: Consumer<UserManager>(

        builder: (_,userManager,__){
          return PageView(
            physics: const NeverScrollableScrollPhysics(), // impede que se movimente a pageView atraveis de gestos.
            controller: pageController,// estou especificando que quem controla a PageView é o pageController criado no 1
            children: <Widget>[

              HomeScreen(),

              ProductScreen(),


              OrdersScreen(),

              Scaffold(
                drawer: CustomDrawer(),

                appBar: AppBar(
                  title: const Text('Home4'),

                ),
              ),

              if(userManager.adminEnable)// abas so aparece quem estiver logado for adm
                ...[
                  AdminUsersScreen(),
                  AdminOrdersScreen(),
                ]

            ],



          );

        },
      ),
    );
  }
}
