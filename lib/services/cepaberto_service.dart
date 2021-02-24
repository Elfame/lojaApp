import 'package:dio/dio.dart';
import 'dart:io';

import 'package:lojavirtual/models/cepaberto_address.dart';

const token = '699d46f36c2d737b416f68be1d9c3056';
class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async{
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try{
      final response = await dio.get<Map<String,dynamic>>(endpoint);

      if(response.data.isEmpty){
        return Future.error('Cep Invalido!');
      }

      final CepAbertoAddress address = CepAbertoAddress.FromMap(response.data);
      return address;
    }on DioError catch(e){
      return Future.error('Erro ao buscar o cep');

    }


  }



}
