

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lojavirtual/models/correios.dart';
import 'package:lojavirtual/models/item_size.dart';
import 'package:uuid/uuid.dart';

//relacionados aos produtos os atributos recebidos

class Product extends ChangeNotifier {

  Product({this.id,this.name,this.description,this.images,this.sizes}){
    images = images ?? [];
    sizes = sizes ?? [];

  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data ['images'] as List<dynamic>);// convertendo lista de String pare dynamic
    sizes = (document.data ['sizes'] as List<dynamic> ?? []).map(
            (s) => ItemSize.fromMap(s as Map <String, dynamic>)).toList();

    correios = (document.data ['correios'] as List<dynamic> ?? []).map((c) => CorreiosSize.fromMap(c as Map <String , dynamic>)).toList();



  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  List<String>images;
  List<ItemSize> sizes;
  List<CorreiosSize> correios;



  List<dynamic> newImages;

 // variavel usada para testar loading
  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value){
    _loading =value;
    notifyListeners();
  }

  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value){
    _selectedSize = value;
    notifyListeners();

  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes){
    stock += size.stock;

    }
    return stock;

  }

  bool get hasStock{
    return totalStock >  0;
  }

  num get basePrice{
    // pegar o menor preço do produto

    num lowest = double.infinity;
    for(final size in sizes){
      if(size.price < lowest && size.hassStock)
        lowest = size.price;

    }
    return lowest;
  }

  ItemSize findSize(String name){
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch(e){

      return null;
    }


  }
  List<Map<String,dynamic>> exportSizeList(){
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList()

    };

    if(id == null){

      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;

    }else{

       await firestoreRef.updateData(data);




    }

    // image[ url1, url2, url3]
    // newImage [url2, file1]
    //update [url2, file1]
    // excluir [url1,url3]
    // mandar para o storoge urlfile1

    final List<String> updateImages = [];

    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);


      }else {
        final StorageUploadTask task =  storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);

      }

    }

    for(final image in images){
      if(!newImages.contains(image)){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        }catch(e){

          debugPrint('Falha ao deletar! $image');
        }



      }
    }

    await  firestoreRef.updateData({'images':updateImages});

    images = updateImages;

    loading = false;

  }

  Product clone(){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),


    );

  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}