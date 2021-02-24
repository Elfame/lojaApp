import 'package:flutter/material.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:provider/provider.dart';

/*
esse documento esta relacionado ao Drawe, aqui configuramos o tamanho do icone,
estilo de texto e etc.
escolhemos tambem a cor do icone e texto quando eles estão selecionados .
 */

class DrawerTile extends StatelessWidget {


  const DrawerTile({this.iconData,this.title,this.page}); // parametro usado no construtor

  final IconData iconData;

  final String title;
  final int page;


  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManager>().page;

    final Color primaryColor = Theme.of(context).primaryColor; // buscando a cor primaria do tema definido no main.dart


    return InkWell( // responsavel por fazer o efeito de seleção do  drawer
      onTap: (){//

        context.read<PageManager>().setPage(page);


      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32), // define os espaçamento de direita e esquerda do icone e do text
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor: Colors.grey[700], // toda essa parte referese a configuração do IconData. tamanho, cor e icone.

              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor: Colors.grey[700], // toda essa parte referese a configuração do title. tamanho, cor .

              ),



            )

          ],



        ),
      ),
    );

  }
}
