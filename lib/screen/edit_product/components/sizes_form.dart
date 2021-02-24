import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_icon_button.dart';
import 'package:lojavirtual/models/item_size.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/screen/edit_product/components/edit_item_size.dart';
// tela de edição de tamanho e estoque
class SizesForm extends StatelessWidget {

   const SizesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: product.sizes,
      validator: (size){
        if(size.isEmpty)
         return 'Insira um tamanho!';
        return null;

      },

      builder: (state){
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                CustomIconButton(// botão para adicionar novo produto
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: (){
                    state.value.add(ItemSize());
                    state.didChange(state.value);

                  },
                ),
              ],
            ),
            Column(
              children: state.value.map((size){
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: (){
                    state.value.remove(size);
                    state.didChange(state.value);

                  },
                  onMoveUp: size != state.value.first ? (){
                    final index = state.value.indexOf(size);// buscar o index a lista atual
                    state.value.remove(size);
                    state.value.insert(index-1, size);
                    state.didChange(state.value);


                  }:null,
                  onMoveDown: size != state.value.last ?(){
                    final index = state.value.indexOf(size);// buscar o index a lista atual
                    state.value.remove(size);
                    state.value.insert(index+1, size);
                    state.didChange(state.value);


                  }:null,
                );
            }).toList() ,

            ),
            if(state.hasError)
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: const  TextStyle(
                    color: Colors.red,
                    fontSize: 12

                  ),

                ),

              )
          ],
        );


      },




    );

  }
}
