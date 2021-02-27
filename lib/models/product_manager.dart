import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/product.dart';

class ProductManager  extends ChangeNotifier{

  ProductManager(){

    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  String _search = '';// botão de pesquisa
  String get search => _search;

  set search (String value){

    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts{
  final List<Product> filteredproducts = [];
  if (search.isEmpty){
    filteredproducts.addAll(allProducts);
  } else {
    filteredproducts.addAll(
        allProducts.where(
                (p) => p.name.toLowerCase().contains(search.toLowerCase())));

  }

  return filteredproducts;

  }


  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapshotProducts =
    await firestore.collection('products')
        .where('deleted', isEqualTo: false).getDocuments();

    allProducts = snapshotProducts.documents.map(
            (d) => Product.fromDocument(d)).toList();

    notifyListeners();



    }

    Product findProductById(String id){
    try {
  return   allProducts.firstWhere((p) => p.id == id) ;
    
    } catch (e){
        return null;
    }
    }

    void update(Product product){
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
    }

  void delete(Product product){
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  }
