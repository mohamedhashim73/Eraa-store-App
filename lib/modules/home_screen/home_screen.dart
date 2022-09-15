import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/detailsScreen/details_screen.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/models/categoriesModel.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/defaultButtons.dart';
import '../../models/homeModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return cubit.homeModel == null || cubit.categoriesModel == null ?
              const Center(child: CircularProgressIndicator(color: mainColor,),) :
          Scaffold(
              appBar: AppBar(title: const Text("Eraa Store",style: TextStyle(fontWeight: FontWeight.bold),),leading: const Text(""),leadingWidth: 0,toolbarHeight: 60,),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    BuildBannnerItem(cubit.homeModel!),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                          const SizedBox(height: 10,),
                          Container(
                            height: 200,
                            child: GridView.count(
                                crossAxisCount: 1,
                                scrollDirection: Axis.horizontal,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1 / 0.9,
                                children: List.generate(cubit.categoriesModel!.data!.data!.length,(i){
                                  return BuildCategoriesItem(cubit.categoriesModel!.data!.data![i]);
                                })
                            ),
                          ),
                          const SizedBox(height: 15,),
                          const Text("Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                          const SizedBox(height: 10,),
                          Container(
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),color: Colors.grey[300]
                              ),
                              child: GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 15,
                                  shrinkWrap: true,
                                  childAspectRatio: 1 / 1.7,
                                  children: List.generate(cubit.homeModel!.data!.products.length, (index){
                                    return BuildProductItem(cubit.homeModel!.data!.products[index],context);
                                  })
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
          ;
        },
    );
  }

  Widget BuildBannnerItem(HomeModel model){
    return CarouselSlider(
        items: model.data!.banners.map((e){
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
            child: Image.network(e.image,width: double.infinity,fit: BoxFit.fill),
          );
        }).toList(),
        options: CarouselOptions(
          height: 180,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        )
    );
  }

  Widget BuildCategoriesItem(CategoriesInfo model){
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.network(model.image.toString(),height: 130,fit: BoxFit.fill,width: double.infinity,)
              ),
              Spacer(),
              Expanded(child: Text(model.name.toString().toUpperCase(),maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5,color: Colors.black),))
            ],
          ),
        ),
      ],
    );
  }

  Widget BuildProductItem(ProductModel model,BuildContext context){
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 25),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 18,),
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.topStart,
                children: [
                  GestureDetector(
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration:BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        child: Image.network(model.image,height: 130,fit: BoxFit.fill,width: double.infinity,)
                    ),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return DetailsScreen(model);}));
                    },
                  ),
                  model.discount != 0 ?
                  Positioned(
                    bottom: 133,
                      right: 85,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: Colors.red),
                        child: const Text("Discount",style: TextStyle(color: whiteColor),),
                  )
                  ) : const SizedBox(width: 0),
                ],
              ),
              const SizedBox(height: 12,),
              Expanded(child: Text(model.name.toString(),maxLines: 2,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${model.price.toString()}\$",maxLines: 1,overflow:TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13.5),),
                  const SizedBox(width: 5,),
                  model.price != model.oldPrice?
                  Text("${model.oldPrice.toString()}\$",style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 11.5)) :
                  Text(""),
                  model.price != model.oldPrice? Spacer(): Spacer(),
                  GestureDetector(
                    child: CircleAvatar(
                      maxRadius: 13,
                      backgroundColor: Colors.grey.withOpacity(0.7),
                      child: Icon(Icons.favorite,size: 19,color : HomeLayoutCubit.get(context).inFavorites[model.id!] == true ? Colors.red : whiteColor,),),
                    onTap: ()
                    {
                      HomeLayoutCubit.get(context).changeFavoriteStatus(productId: model.id!);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 260,
            child: GestureDetector(
              onTap: ()
              {
                HomeLayoutCubit.get(context).changeCartStatus(productId: model.id!);
              },
              child: CircleAvatar(
                backgroundColor: HomeLayoutCubit.get(context).inCart[model.id!] == true ? Colors.red : Colors.green,
                child: const Icon(Icons.shopping_cart,color: Colors.white,),
              ),
            ),
        ),
      ],
    );
  }
}
