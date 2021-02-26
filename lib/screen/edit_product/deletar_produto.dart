import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DeletarProduto extends StatelessWidget {

  //const DeletarProduto(this.product);
  //final Product product;


  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deletar o Produto ?" ),
      content: const Text("Essa ação não poderar ser desfeita!"),
      actions: [
        FlatButton(
          child: Text('Excluir', style: TextStyle(
            color: Colors.red
          ),),

          onPressed: (){
            // corrigir
           //context.read<ProductManager>().delete(product);
            Navigator.of(context).pop();


          },
        )
      ],
    );

  }
}
