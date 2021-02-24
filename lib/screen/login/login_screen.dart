

import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validator.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');

            },
            textColor: Colors.white,
            child: const Text(

                'Criar conta',
              style: TextStyle(fontSize: 16),

            ),

      )
        ],
      ),
//__________________________________________________________________________________________________________________________________
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,

            child: Consumer<UserManager>(
              builder: (_,userManager,child) {
                return ListView(
                  shrinkWrap: true,// ocupar a menor area da tela
                  padding: const EdgeInsets.all(16),
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,// quando abrir o teclado ja habilitar a opção do @
                      autocorrect: false, // desabilita a correção de ortográfia nesse campo
                      validator: (email){
                        if(!emailValid(email))
                          return 'E-mail invalido!';
                        return null;


                      },

                    ),
                    //____________________________________________________
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false, // desabilita a correção de ortográfia nesse campo
                      obscureText: true,// deixa o campo obscuro
                      validator: (pass){
                        if(pass.isEmpty || pass.length < 6)
                          return 'Senha invalida';
                        return null;
                      },
                    ),
                    //____________________________________________________________
                    child,
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading ? null : (){
                          if(formKey.currentState.validate()){
                            userManager.signIn(
                                user: User(
                                    email: emailController.text,
                                    password: passController.text

                                ),
                                onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(

                                        content:  Text('Falha ao entrar:$e',),
                                        backgroundColor: Colors.red,
                                      )
                                  );

                                },
                                onSuccess: (){
                                  Navigator.of(context).pop();

                                }

                            );

                          }

                        },
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading ?
                        CircularProgressIndicator( valueColor: AlwaysStoppedAnimation(Colors.white),):
                        const Text(

                          'Entar',
                          style: TextStyle(
                            fontSize: 18,
                          ),

                        ),

                      ),
                    )


                  ],


                ) ;

              },
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){

                  },
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Esqueci minha senha',
                  ),
                ),

              ),
              //_____________________________________________________________,

            ),
          ),


        ),

      ),






    );
  }
}
