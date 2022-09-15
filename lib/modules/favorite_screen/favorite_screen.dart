import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/models/categoriesModel.dart';
import 'package:untitled/models/getCartModel.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/defaultButtons.dart';

import '../../models/getFavoriteModel.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text("Favorite",style: TextStyle(fontWeight: FontWeight.bold),),leading: const Text(""),leadingWidth: 0,toolbarHeight: 60,),
            body: cubit.favoriteModel?.data == null ?
                const Center(child: Text(""),) :
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                        children: [
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,i){
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  width: double.infinity,
                                  child: BuildFavoriteItem(model: cubit.favoriteModel!.data!.data![i].product!,context: context)
                              );},
                            separatorBuilder: (context,i){
                              return Divider(color: Colors.black.withOpacity(0.1),thickness: 2);
                            },
                            itemCount: cubit.favoriteModel?.data?.total ?? 0
                          ),
                        ]
                    ),
                  ),
                ),
          );
        }
    );
  }

  Widget BuildFavoriteItem({required FavoriteProduct model,required BuildContext context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Image.network(model.image.toString().toString(),height: 120,width: 110,fit: BoxFit.fill,),
            const SizedBox(width: 25,),
            Expanded(
              child: Container(
                height: 110,
                // padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text("${model.price.toString()}\$",style: TextStyle(fontWeight: FontWeight.w500,color: blackColor.withOpacity(0.5),fontSize: 15),),
                        const SizedBox(width: 10,),
                        model.price != model.oldPrice || model.oldPrice != 0?
                            Text("${model.oldPrice.toString()}\$",style: TextStyle(fontWeight: FontWeight.w500,color: blackColor.withOpacity(0.5),fontSize: 15),) :
                            const SizedBox(width: 0,),
                        const Spacer(),
                        model.discount != 0 ?
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.red),
                          child: const Text("Discount",style: TextStyle(color: whiteColor),),
                        ) : const SizedBox(width: 0),
                        const SizedBox(width: 5,),
                      ],
                    ),
                    Spacer(),
                    // this is not enabled => needed to add logic for it
                    buildProductActions(model: model,context: context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductActions({required FavoriteProduct model,required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
        [
          GestureDetector(
              child: Row(
                children:
                [
                  Icon(Icons.shopping_cart,size: 19,color: blackColor.withOpacity(0.6),),
                  const SizedBox(width: 10,),
                  const Text("Add to Cart",style: TextStyle(fontSize: 12),),
                ],
              ),
              onTap: ()
              {
                HomeLayoutCubit.get(context).changeCartStatus(productId: model.id!);
              }
          ),
          Spacer(),
          GestureDetector(
              child: Row(
                children:
                [
                  Icon(Icons.delete,size: 19,color: blackColor.withOpacity(0.6),),
                  const SizedBox(width: 10,),
                  const Text("Remove",style: TextStyle(fontSize: 12),),
                ],
              ),
              onTap: ()
              {
                HomeLayoutCubit.get(context).changeFavoriteStatus(productId: model.id!);
              }
          ),
        ],
      ),
    );
  }
}
