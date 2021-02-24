import 'package:flutter/material.dart';
import 'package:lojavirtual/models/item_size.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {


  SizeWidget({this.size});


  final ItemSize size;



  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final select = size == product.selectedSize;

    Color color;
    if(! size.hassStock)
      color = Colors.red.withAlpha(50);
    else if(select)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(size.hassStock){
          product.selectedSize = size;

        }

      },

      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:  color

          )

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Container(
                color:  color,
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white),
              ),

            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child:  Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(

                  color:  color,
                ),
              ),
            )

          ],
        ),


      ),
    );

  }
}
