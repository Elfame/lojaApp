import 'package:flutter/material.dart';
import 'package:lojavirtual/common/price_card.dart';
import 'package:lojavirtual/models/cart_manager.dart';
import 'package:lojavirtual/models/checkout_manager.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldkey
 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_,cartManager, checkoutManager) =>
      checkoutManager..updateCart(cartManager),
      lazy: false ,

      child: Scaffold(
        key: scaffoldkey,

        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,

        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager,__){
            //barra de carregamento
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),

                    ),
                    const SizedBox(height: 16,),
                    Text(
                      'Processando seu pagamento......',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,

                      ),

                    )



                  ],


                ),
              );


            }
            return ListView(
              children: [

                PriceCard(
                  buttonText: 'Finalizar pedido',
                  onPressed: (){
                    checkoutManager.checkout(
                      onStockFail: (e){
                        // voltar para carrinho
                        Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/cart');

                      },
                      onSuccess: (order){
                        Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/');
                        Navigator.of(context).pushNamed('/confirmation',arguments: order );


                      }
                    );

                  },
                )
              ],
            );



          },



        )


      ),
    );
  }
}
