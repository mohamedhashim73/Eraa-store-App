import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/defaultButtons.dart';
import 'package:untitled/shared/local/cacheHelper.dart';

class ProfileScreen extends StatelessWidget {
  bool isDark = false;
  bool isPlayInBackground = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
              appBar: AppBar(title: const Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),leading: const Text(""),leadingWidth: 0,toolbarHeight: 60,),
            body: cubit.UserData!.data == null || userImage == null ? const Center(child: CircularProgressIndicator(color: mainColor,)) :
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    width: double.infinity,
                    // color: Colors.blueGrey,
                    height: 225,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(maxRadius: 40,backgroundImage: NetworkImage(userImage.toString()),foregroundColor: Colors.grey,),
                        const SizedBox(height: 15,),
                        Text("${cubit.UserData!.data!.name}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const SizedBox(height: 7,),
                        Text(cubit.UserData!.data!.email.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),),
                        const SizedBox(height: 10,),
                        DefaultButton(
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Edit Profile"),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward_ios,size: 18)
                              ],
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, 'updateProfileScreen');
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                        ),
                      ],
                    ),
                  ),
                  SeperatedItem(title: "Content"),
                  ItemComponent(
                      title: "Favorite",prefixIcon: Icons.favorite_border,
                      onTap: (){
                        Navigator.pushNamed(context, 'favoriteScreen');
                      },
                      suffixIcon: Icon(Icons.arrow_forward_ios,size: 19,color: blackColor.withOpacity(0.5),)),
                  const SizedBox(height: 15),
                  ItemComponent(title: "Cart",prefixIcon: Icons.shopping_cart,
                    onTap: (){
                      Navigator.pushNamed(context, 'cartScreen');
                    },
                    suffixIcon: Icon(Icons.arrow_forward_ios,size: 19,color: blackColor.withOpacity(0.5),),
                  ),
                  const SizedBox(height: 15),
                  ItemComponent(
                    title: "Settings",prefixIcon: Icons.settings,
                    onTap: (){},
                    suffixIcon: Icon(Icons.arrow_forward_ios,size: 19,color: blackColor.withOpacity(0.5),),
                  ),
                  SeperatedItem(title: "Preferences"),
                  ItemComponent(
                      title: "Language",prefixIcon: Icons.language,
                      onTap: (){},
                      suffixIcon: Row(
                        children: [
                          Text("English",style: TextStyle(color: blackColor.withOpacity(0.5)),),
                          const SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios,size: 19,color: blackColor.withOpacity(0.5),),
                        ],
                      )
                  ),
                  const SizedBox(height: 10),
                  ItemComponent(
                    title: "Dark Mode",prefixIcon: Icons.mode_night_outlined,
                    onTap: (){},
                    suffixIcon: Switch(value: isDark, onChanged: (val){}),
                  ),
                  const SizedBox(height: 10),
                  ItemComponent(
                    title: "Play in Background",prefixIcon: Icons.playlist_play_rounded,
                    onTap: (){},
                    suffixIcon: Switch(value: isPlayInBackground, onChanged: (val){},activeColor: mainColor),
                  ),
                  const SizedBox(height: 10),
                  ItemComponent(
                      title: "Sign out",prefixIcon: Icons.logout_outlined,
                      onTap: (){
                        CacheHelper.DeleteItem(key: 'token')?.then((value){
                          if(value == true)
                          {
                            Navigator.pushReplacementNamed(context, 'loginScreen');
                          }
                        });
                      },
                      suffixIcon: Icon(Icons.arrow_forward_ios,size: 19,color: blackColor.withOpacity(0.5),)),
                ],
              ),
            )
          );
        }
    );
  }

  // Widget that separated between elements
  Widget SeperatedItem({required String title}){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      color: Colors.grey.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
      child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black.withOpacity(0.4)),),
    );
  }

  Widget ItemComponent({required String title,required IconData prefixIcon,required dynamic onTap,required dynamic suffixIcon}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children:
          [
            Icon(prefixIcon,color: Colors.grey,),
            const SizedBox(width: 20,),
            Text(title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: blackColor.withOpacity(0.5)),),
            const Spacer(),
            suffixIcon,
          ],
        ),
      )
    );
  }
}
