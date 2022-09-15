import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/registerModel.dart';
import 'package:untitled/modules/Sign/cubit/cubit.dart';
import 'package:untitled/modules/Sign/cubit/states.dart';
import '../../models/loginModel.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/defaultButtons.dart';
import '../../shared/components/defaultPackages.dart';
import '../../shared/local/cacheHelper.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit,SignStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SignCubit.get(context);
        return Scaffold(
            body: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Sign up",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color:blackColor.withOpacity(0.5)),),
                        const SizedBox(height: 30,),
                        DefaultTextFormField(
                          label: const Text("Name"),
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          validator: (val){
                            return nameController.text.isEmpty? "Name must not be empty" : null;
                          },
                          type: TextInputType.text,
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15,),
                        DefaultTextFormField(
                          keyboardType: TextInputType.phone,
                          label: const Text("Phone"),
                          controller: phoneController,
                          validator: (val){
                            return phoneController.text.isEmpty? "Phone must not be empty" : null;
                          },
                          type: TextInputType.number,
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 15,),
                        DefaultTextFormField(
                          label: const Text("Email"),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (val){
                            return emailController.text.isEmpty? "Email must not be empty" : null;
                          },
                          type: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 15,),
                        DefaultTextFormField(
                            label: const Text("Password"),
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            validator: (val){
                              return passwordController.text.isEmpty? "Password must not be empty" : null;
                            },
                            type: TextInputType.visiblePassword,
                            secureText: cubit.passwordShown? false : true ,
                            prefixIcon: Icons.password,
                            suffixTap: ()
                            {
                              cubit.ChangePasswordVisiblity();
                            },
                            suffixIcon: cubit.passwordShown? Icons.visibility : Icons.visibility_off,
                        ),
                        const SizedBox(height: 30,),
                        state is RegisterLoadingState ?
                        const Center(child:  CircularProgressIndicator(color: mainColor)) :
                        DefaultButton(
                            title: const Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: whiteColor),),
                            onTap: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.PostRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                ).then((value) {
                                  if(cubit.registerData!.status == true)   // changed ! to ?
                                  {
                                    showSnackBar(message: "${cubit.registerData!.message}",context: context, color: Colors.green);
                                    print("Token is ${cubit.registerData!.data!.token.toString()}");
                                    CacheHelper.SaveData(key: 'token', value: cubit.registerData!.data!.token.toString());
                                    CacheHelper.SaveData(key: 'userPassword', value: passwordController.text);
                                    CacheHelper.SaveData(key: 'tokenStatus', value: true);
                                    Navigator.pushReplacementNamed(context, 'homeScreen');
                                  }
                                  else
                                  {
                                    showSnackBar(message: "check your data, try again",context: context, color: Colors.red);
                                  }
                                });
                              }
                            },
                            width: double.infinity,
                            height: 50,
                            splashColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",style: TextStyle(fontSize: 14,color: blackColor.withOpacity(0.5)),),
                            DefaultTextButton(
                              text: const Text("..Sign in",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 18),),
                              onTap: (){
                                Navigator.pushNamed(context, 'loginScreen');
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
