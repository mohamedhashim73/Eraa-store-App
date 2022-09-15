import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/models/categoriesModel.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text("Category",style: TextStyle(fontWeight: FontWeight.bold),),leading: const Text(""),leadingWidth: 0,toolbarHeight: 60,),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    children: [
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,i){
                            return Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: i.isEven? Colors.green.withOpacity(0.5) : Colors.grey.withOpacity(0.2),
                                ),
                                width: double.infinity,
                                child: BuildCategoryItem(model: cubit.categoriesModel!.data!.data![i])
                            );},
                          separatorBuilder: (context,i){return const SizedBox(height: 10);},
                          itemCount: 5
                      ),
                    ]
                ),
              ),
            ),
          );
    }
    );
  }

  Widget BuildCategoryItem({required CategoriesInfo model}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Image.network(model.image.toString(),height: 120,width: 110,fit: BoxFit.fill,),
        ),
        const SizedBox(width: 30,),
        Text(model.name.toString().toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        const Spacer(),
        GestureDetector(
          onTap: (){
            // type your method here
          },
          child: const Icon(Icons.arrow_forward_ios,size: 18,),
        ),
      ],
    );
  }
}
