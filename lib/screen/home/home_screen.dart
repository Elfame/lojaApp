import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/home_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screen/home/components/add_section_widget.dart';
import 'package:lojavirtual/screen/home/components/section_list.dart';
import 'package:lojavirtual/screen/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: const  [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168)

              ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter

              )

            ),

          ),

          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,

                flexibleSpace:  const FlexibleSpaceBar(
                  title: Text(' La casa de papel'),
                  centerTitle: true,

                ),
                actions: <Widget>[
                  IconButton(
                    icon:  Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_,userManager, homeManager,__){
                      if(userManager.adminEnable && !homeManager.loading) {


                        if(homeManager.editing){

                          return PopupMenuButton(
                            onSelected: (e){
                              if(e == 'Salvar'){

                                homeManager.saveEditing();


                              }else {
                                homeManager.discardEditing();

                              }

                            },
                              itemBuilder: (_){
                                 return ['Salvar', 'Descartar'].map((e){
                                   return PopupMenuItem(

                                     value: e,
                                     child: Text(e),

                                   );

                                 }).toList();

                              },
                          );

                        } else{
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: homeManager.enterEditing,

                          );
                        }

                      } else return Container();

                    },

                  ),
                ],

              ),

              Consumer <HomeManager> (// seções da home
                builder: (_,homeManager,__){

                  if(homeManager.loading){
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
                  final List<Widget> children = homeManager.sections
                      .map<Widget>((section) {
                        switch(section.type){
                          case 'List':
                            return SectionList(section);
                          case 'Staggered':
                            return SectionStaggered(section);
                          default:
                            return Container();



                        }


                  }).toList();
                  if(homeManager.editing)
                    children.add(AddSectionWidget(homeManager));




                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )

            ],
          ),
        ],
      ),


    );
  }
}
