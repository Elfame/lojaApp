import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/models/user.dart';


import 'order.dart';

class OrdersManager extends ChangeNotifier {

  User user;

  // lista dos usuarios

  List<Order> orders =[];
  // acessando firebase
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUser(User user){

    this.user = user;

    orders.clear();
    _subscription?.cancel();
    if(user != null){
      _listenToOrders();

    }
  }

  void _listenToOrders(){
    // buscando a coleção orders no firebase e comparado
    // com user do FB com o logado
    
    _subscription = firestore.collection('orders')
        .where('user',isEqualTo: user.id).snapshots().listen((event) {

          orders.clear();
          for(final doc in event.documents){
            orders.add(Order.fromDocument(doc));
          }
          notifyListeners();

    });


  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }




}