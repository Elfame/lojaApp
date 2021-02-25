import 'package:flutter/material.dart';
import 'package:lojavirtual/models/order.dart';

class CancelOrderDialog extends StatelessWidget {

  const CancelOrderDialog(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar o pedido: ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser defeita!',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w800
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            order.cancel();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Cancelar Pedido'),
        ),
      ],
    );
  }
}
