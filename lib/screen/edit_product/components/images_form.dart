import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product.dart';
import 'package:lojavirtual/screen/edit_product/components/image_source_sheet.dart';

// tela de edição do produto

class ImagesForm extends StatelessWidget {

  const  ImagesForm(this.product);

 final  Product product;

  @override
  Widget build(BuildContext context) {



    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (images){
        if (images.isEmpty)
          return 'insira pelomenos um imagem!';
        return null;


      },

      onSaved: (images) => product.newImages = images,
      builder: (State){

        void onImageSelected (File file){
          State.value.add(file);
          State.didChange(State.value);
          Navigator.of(context).pop();


        }

        return Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                autoplay: false,
                images: State.value.map<Widget>((image){
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if(image is String)
                        Image.network(image , fit: BoxFit.cover,)
                      else
                        Image.file(image as File, fit: BoxFit.cover,),


                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: Colors.redAccent,
                          onPressed: (){//remover image
                                State.value.remove(image);
                                State.didChange(State.value);
                          },

                        ),
                      )

                    ],

                  );

                }).toList()..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Theme.of(context).primaryColor,
                      iconSize: 60,
                      onPressed: (){
                        if (Platform.isAndroid)

                        showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected ,

                            )
                        );
                        else
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                onImageSelected: onImageSelected ,
                              )
                          );

                      },

                    ),
                  )
                ),
                dotSpacing: 15,
                showIndicator: true,
                dotSize: 7,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.black.withOpacity(0.5),
                dotColor: Theme.of(context).primaryColor,

              ),
            ),

            if(State.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16,left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  State.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,

                  ),
                ),
              )
          ],
        );


      },


    );

  }
}
