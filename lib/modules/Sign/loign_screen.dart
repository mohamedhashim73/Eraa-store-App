import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/main.dart';
import 'package:untitled/shared/local/cacheHelper.dart';
import '../../models/loginModel.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/defaultButtons.dart';
import '../../shared/components/defaultPackages.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignCubit, SignStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SignCubit.get(context);
        return Scaffold(
            body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome To Eraa Store",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                          color: blackColor.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DefaultTextFormField(
                      label: const Text("Email"),
                      controller: emailController,
                      validator: (val)
                      {
                        return emailController.text.isEmpty ? "Email must not be empty" : null;
                      },
                      type: TextInputType.text,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      label: const Text("Password"),
                      controller: passwordController,
                      secureText: cubit.passwordShown ? false : true,
                      suffixTap: () {
                        cubit.ChangePasswordVisiblity();
                      },
                      validator: (val) {
                        return passwordController.text.isEmpty
                            ? "Password must not be empty"
                            : null;
                      },
                      type: TextInputType.visiblePassword,
                      prefixIcon: Icons.password,
                      suffixIcon: cubit.passwordShown
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is LoginLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(color: mainColor))
                        : DefaultButton(
                            title: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: whiteColor),
                            ),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.UserLogin(email: emailController.text,password: passwordController.text).then((value) async {
                                  if (cubit.loginModel!.status == true) // i changed ! to ?
                                  {
                                    showSnackBar(message: "${cubit.loginModel!.message}",context: context,color: Colors.green);
                                    Navigator.pushReplacementNamed(context, 'homeScreen');
                                  }
                                  else
                                  {
                                    showSnackBar(message: "${cubit.loginModel!.message}", context: context, color: Colors.red);
                                  }
                                });
                              }
                            },
                            width: double.infinity,
                            height: 50,
                            splashColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                    ),
                    const SizedBox(height: 15,),
                    DefaultButton(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                                maxRadius: 15,
                                backgroundImage:
                                    ExactAssetImage('images/google.png')),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: whiteColor),
                            ),
                          ],
                        ),
                        onTap: () {},
                        width: double.infinity,
                        height: 50,
                        splashColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 14, color: blackColor.withOpacity(0.5)),
                        ),
                        DefaultTextButton(
                          text: const Text(
                            "..Create one",
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, 'registerScreen');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
