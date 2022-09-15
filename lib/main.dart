import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layouts/detailsScreen/details_screen.dart';
import 'package:untitled/models/loginModel.dart';
import 'package:untitled/modules/cart_screen/cart_screen.dart';
import 'package:untitled/modules/favorite_screen/favorite_screen.dart';
import 'package:untitled/modules/profile_screen/profile_screen.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/local/cacheHelper.dart';
import 'package:untitled/shared/network/dioHelper.dart';
import 'package:untitled/shared/theme.dart';
import 'layouts/homeLayout/cubit/cubit.dart';
import 'layouts/homeLayout/home_layoutScreen.dart';
import 'modules/Sign/cubit/cubit.dart';
import 'modules/Sign/loign_screen.dart';
import 'modules/Sign/register_screen.dart';
import 'modules/boarding_screen/boarding_screen.dart';
import 'modules/profile_screen/update_profileScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.CacheInit();
  await DioHelper.InitDio();
  boardingShown = CacheHelper.GetData(key: 'boardingShown') ?? false;
  tokenStatus = CacheHelper.GetData(key: 'tokenStatus') ?? false;
  token = CacheHelper.GetData(key: 'token');
  userImage = CacheHelper.GetData(key: 'userImage') ?? 'https://student.valuxapps.com/storage/assets/defaults/user.jpg';
  userPassword = CacheHelper.GetData(key: 'userPassword');
  print("token status is $tokenStatus boardingShown is $boardingShown token is $token");
  print("Password is $userPassword");
  runApp(MyApp(boardingShown, tokenStatus!));
}

class MyApp extends StatelessWidget {
  final bool _boardingShown;
  final bool _tokenStatus;
  MyApp(this._boardingShown, this._tokenStatus);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignCubit()),
          BlocProvider(
              create: (context) => HomeLayoutCubit()..getHomeData()..getCategories()..getCart()..getProfileData()..getFavorites()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "loginScreen": (context) => LoginScreen(),
            "registerScreen": (context) => RegisterScreen(),
            "homeScreen": (context) => HomeLayoutScreen(),
            "favoriteScreen": (context) => FavoriteScreen(),
            "cartScreen": (context) => CartScreen(),
            "updateProfileScreen": (context) => UpdateProfileScreen(),
            "profileScreen": (context) => ProfileScreen(),
          },
          home: _tokenStatus ? HomeLayoutScreen() : _boardingShown == false ? BoardingScreen() : LoginScreen(),
          theme: ThemeData(
              primarySwatch: mainColor,
              appBarTheme: appBarTheme,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: mainColor,
                unselectedItemColor: blackColor,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
              )),
        ));
  }
}
