import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/shared/components/constants.dart';
import '../../models/homeModel.dart';
import '../homeLayout/cubit/states.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel model;
  const DetailsScreen(this.model, {super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"),),
      body: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  clipBehavior: Clip.none,
                  children:
                  [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                        color: Colors.grey[300],
                      ),
                    ),
                    Positioned(
                      top: 140,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        //  padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Image.network(model.image,height: 200,width: 200,fit: BoxFit.fill,),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 120,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20),),
                      const SizedBox(height: 10),
                      Text(model.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,height: 1.3),softWrap: true),
                      const SizedBox(height: 15),
                      const Text("Description",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20),),
                      const SizedBox(height: 15),
                      Text(model.description,style: TextStyle(color: Colors.grey),maxLines: 8,),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
