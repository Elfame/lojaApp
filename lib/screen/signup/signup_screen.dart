import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validator.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';



class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_,userManage,__){
                return ListView(
                  padding:  const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration (hintText:'Nome completo'),
                      enabled: !userManage.loading,
                      validator: (name){
                        if(name.isEmpty)
                          return 'Campo Obrigatorio';
                        else if(name.trim().split(' ').length <=1)
                          return 'Preemcha seu nome completo!';
                        return null;

                      },

                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration (hintText:'E-mail'),
                      keyboardType: TextInputType.emailAddress,// quando abrir o teclado ja habilitar a opção do @
                      enabled: !userManage.loading,
                      validator: (email){// validação do email
                        if(email.isEmpty)
                          return 'Campo obrigatorio';
                        else if (!emailValid(email))
                          return 'E-mail invalido!';
                        return null;

                      },

                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration (hintText:'Senha'),
                      autocorrect: false, // desabilita a correção de ortográfia nesse campo
                      obscureText: true,// deixa o campo obscuro
                      enabled: !userManage.loading,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatorio';
                        else if(pass.length <6)
                          return 'Senha muito curta ';
                        return null;
                      },

                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration (hintText:'Repita a senha'),
                      autocorrect: false, // desabilita a correção de ortográfia nesse campo
                      obscureText: true,// deixa o campo obscuro
                      enabled: !userManage.loading,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatorio';
                        else if(pass.length <6)
                          return 'Senha muito curta ';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassworld = pass,


                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,

                        onPressed: userManage.loading ? null: () {
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();
                            if (user.password != user.confirmPassworld){

                              scaffoldKey.currentState.showSnackBar(

                                  SnackBar(
                                    content: const Text('Senhas não coincidem!',),
                                    backgroundColor: Colors.red,
                                  )
                              );
                              return;
                            }

                            userManage.sigUp(
                                user: user,
                                onSuccess: (){
                                  Navigator.of(context).pop();


                                },
                                onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(

                                        content:  Text('Falha ao cadastrar: $e',),
                                        backgroundColor: Colors.red,
                                      )
                                  );


                                }

                            );
                          }

                        },
                        child: userManage.loading ?
                        CircularProgressIndicator(
                          valueColor:  AlwaysStoppedAnimation(Colors.white),
                        )
                        : const Text(

                          'Criar conta', style: TextStyle(
                            fontSize: 18
                        ),


                        ),



                      ),


                    ),


                  ],


                )  ;

              },
            ),
          ),

        ),

      ),



// TODO: ADICIONAR O CAMPO DE TELEFONE

    );
  }
}
