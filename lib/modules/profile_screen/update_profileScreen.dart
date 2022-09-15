import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/homeLayout/cubit/cubit.dart';
import 'package:untitled/layouts/homeLayout/cubit/states.dart';
import 'package:untitled/modules/Sign/cubit/cubit.dart';
import 'package:untitled/modules/Sign/cubit/states.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/components/defaultButtons.dart';

import '../../shared/components/defaultPackages.dart';
import '../../shared/local/cacheHelper.dart';

class UpdateProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UpdateProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
        listener: (context,state){},
        builder: (context,state){
          final cubit = HomeLayoutCubit.get(context);
          return cubit.UserData!.data == null ?
              const Center(child: CircularProgressIndicator(color: mainColor,),) :
              Form(
                key: formKey,
                child: Scaffold(
                  appBar: AppBar(title: const Text("Update Profile",style: TextStyle(fontWeight: FontWeight.bold),),toolbarHeight: 60,),
                  body: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children:
                        [
                          DefaultTextFormField(
                            prefixIcon: Icons.person,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            validator: (val){
                              return val.isEmpty ? 'Name must not be empty' : null;
                            },
                            type: TextInputType.text,
                            label: const Text("Name"),
                          ),
                          const SizedBox(height: 15,),
                          DefaultTextFormField(
                            // initialValue: cubit.UserData!.data!.phone,
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            validator: (val){
                              return val.isEmpty ? 'Phone must not be empty' : null;
                            },
                            type: TextInputType.phone,
                            label: const Text("Phone"),
                          ),
                          const SizedBox(height: 15,),
                          DefaultTextFormField(
                            // initialValue: cubit.UserData!.data!.email,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (val){
                              return val.isEmpty ? 'Email must not be empty' : null;
                            },
                            type: TextInputType.emailAddress,
                            label: const Text("Email"),
                          ),
                          const SizedBox(height: 15,),
                          DefaultTextFormField(
                            // initialValue: userPassword,
                            secureText: true,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icons.visibility_off,
                            prefixIcon: Icons.password,
                            controller: passwordController,
                            label: const Text("Password"),
                            validator: (val){
                              return val.isEmpty ? 'Password must not be empty' : null;
                            },
                            type: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 30,),
                          state is LoadingUpdateProfileState ?
                            const CircularProgressIndicator(color: mainColor,) :
                            DefaultButton(
                                title: const Text("Update Data",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: whiteColor),),
                                onTap: ()
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    print("Email controller is ${emailController.text}");
                                    cubit.updateProfile(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                    ).then((value) {
                                      if(cubit.UserData!.status == true){
                                        showSnackBar(message: "Updated Successfully",context: context, color: Colors.green);
                                        CacheHelper.SaveData(key: 'token', value: cubit.UserData!.data!.token.toString());
                                        CacheHelper.SaveData(key: 'userPassword', value: passwordController.text);
                                        CacheHelper.SaveData(key: 'tokenStatus', value: true);
                                        Navigator.pushReplacementNamed(context, 'profileScreen');
                                      }
                                    });
                                  }
                                },
                                width: double.infinity,
                                height: 50,
                                splashColor: Colors.lightGreen,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ;
        },
    );
  }
}
