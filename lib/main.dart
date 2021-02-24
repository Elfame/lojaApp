
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/admin_orders_manager.dart';
import 'package:lojavirtual/models/admin_users_manager.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:lojavirtual/models/home_manager.dart';
import 'package:lojavirtual/models/order.dart';
import 'package:lojavirtual/models/orders_manager.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/product_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screen/address/address_screen.dart';
import 'package:lojavirtual/screen/cart/cart_screen.dart';
import 'package:lojavirtual/screen/checkout/checkout_screen.dart';
import 'package:lojavirtual/screen/confirmation/confirmation_screen.dart';
import 'package:lojavirtual/screen/edit_product/edit_product_screen.dart';
import 'package:lojavirtual/screen/login/login_screen.dart';
import 'package:lojavirtual/screen/product/product_screen.dart';
import 'package:lojavirtual/screen/select_product/select_product_screen.dart';
import 'package:lojavirtual/screen/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'screen/base/base_screen.dart';

void main() {
  runApp(MyApp());


 //Firestore.instance.collection('teste').add({'teste': ''});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),

        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,

        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager,OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_,userManager, ordersManager)  =>
              ordersManager..updateUser(userManager.user),
        ),

        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_,userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),


        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_,userManager, adminOrdersManager) =>
          adminOrdersManager..updateAdmin(
              adminEnabled: userManager.adminEnable

              ),
        ),







      ],
      child: MaterialApp(
        title: 'Loja Virtual',

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 255, 0, 0),// cor primaria do app
          scaffoldBackgroundColor: const Color.fromARGB(255, 248, 181, 168),// cor de fundo do app
          appBarTheme: const AppBarTheme(
            elevation: 0// retira a elevação que vem por padrão nas appbar.

          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
                //_____________ir para a tela de login_____________
              );


            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
                //_____________Retornar tela de cadastro______________
              );


            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
                //_____________tela de produto______________
              );

            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                //_____________Carrinho de Compras______________
                settings:  settings
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AddressScreen()
                //_____________ddress______________
              );

            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
                //_____________ddress______________
              );

            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(settings.arguments as Product)
                //_____________Tela de edição do produto_____________
              );

            case '/select_product':
            return MaterialPageRoute(
                builder: (_) => SelectProductScreen()
              //_____________abrir pagina para vincular ptoduto______________
            );

            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                    settings.arguments as Order
                  )
                //_____________confoirmação de pedido______________
              );


            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
                settings: settings



              );


          }


        },

      ),
    );
  }
}

