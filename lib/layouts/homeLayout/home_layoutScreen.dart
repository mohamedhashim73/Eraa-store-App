import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/homeModel.dart';
import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: BottomNavigationBar(
              currentIndex: cubit.initialIndex,
              onTap: (index)
              {
                cubit.ChangeBottomNavIndex(index);
              },
              items: const
              [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "WhiteList"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
              ],
            ),
          ),
          body: cubit.homeModel?.status != true ?
           const Center(child: CircularProgressIndicator(color: mainColor,)) :
           cubit.BottomNavScreens[cubit.initialIndex],
        );
      },
    );
  }
}
