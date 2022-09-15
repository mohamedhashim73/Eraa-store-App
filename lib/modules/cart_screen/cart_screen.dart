import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/models/categoriesModel.dart';
import 'package:untitled/models/getCartModel.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/defaultButtons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){
          /*
          if(state is CartLoadingState)
            {
              const Center(child: CircularProgressIndicator(color: mainColor,));
            }
           */
        },
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
                appBar: AppBar(title: const Text("Cart",style: TextStyle(fontWeight: FontWeight.bold),),leading: const Text(""),leadingWidth: 0,toolbarHeight: 60,),
                body: cubit.cartModel?.data == null ?
                    const Text("") :
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            children: [
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context,i){
                                  return Container(
                                    // padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      width: double.infinity,
                                      child: BuildCartItem(model: cubit.cartModel!.data!.cartItems![i].product!,context: context)
                                  );},
                                separatorBuilder: (context,i){
                                  return Divider(color: Colors.black.withOpacity(0.1),thickness: 2);
                                },
                                itemCount: cubit.cartModel!.data != null ? cubit.cartModel!.data!.cartItems!.length : 0,
                              ),
                            ]
                        ),
                      ),
                    ),
              );
        }
    );
  }

  Widget BuildCartItem({required CartProduct model,required BuildContext context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Image.network(model.image.toString().toString(),height: 130,width: 110,fit: BoxFit.fill,),
            const SizedBox(width: 25,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("${model.price.toString()}\$",style: TextStyle(fontWeight: FontWeight.w500,color: blackColor.withOpacity(0.5),fontSize: 15),),
                      const SizedBox(width: 5,),
                      model.price != model.oldPrice || model.oldPrice != 0?
                          Text("${model.oldPrice.toString()}\$",style: TextStyle(fontWeight: FontWeight.w500,color: blackColor.withOpacity(0.5),fontSize: 15),) :
                          const SizedBox(width: 0,),
                      Spacer(),
                      model.discount != 0 ?
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.red),
                            child: const Text("Discount",style: TextStyle(color: whiteColor),),
                          ) : const SizedBox(width: 0),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  // this is not enabled => needed to add logic for it
                  Row(
                    children: [
                      buildChooseProduct(title: "Qty : 1",onTap: (){}),
                      const SizedBox(width: 10,),
                      buildChooseProduct(title: "Size : 1",onTap: (){}),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        // const SizedBox(height: 10,),
        buildProductActions(model: model,context: context)
      ],
    );
  }

  Widget buildChooseProduct({required String title,required dynamic onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: mainColor,
        ),
        child: Row(
          children: [
            Text(title,style: const TextStyle(color: whiteColor),),
            const Icon(Icons.keyboard_arrow_down,color: whiteColor,),
          ],
        ),
      ),
      );
  }

  Widget buildProductActions({required CartProduct model,required BuildContext context}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        DefaultButton(
          color: Colors.transparent,
            title: Row(
              children:
              const [
                Icon(Icons.favorite_border,size: 20,),
                SizedBox(width: 10,),
                Text("Add to Favorite",style: TextStyle(fontSize: 13),),
              ],
            ),
            onTap: ()
            {
              HomeLayoutCubit.get(context).changeFavoriteStatus(productId: model.id!);
            }
        ),
        DefaultButton(
          color: Colors.transparent,
            title: Row(
              children:
              const [
                Icon(Icons.delete,size: 20,),
                SizedBox(width: 10,),
                Text("Remove from Cart",style: TextStyle(fontSize: 13),),
              ],
            ),
            onTap: ()
            {
              HomeLayoutCubit.get(context).changeCartStatus(productId: model.id!);
            }
        ),
      ],
    );
  }
}
