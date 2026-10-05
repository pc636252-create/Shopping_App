import 'package:danger_now/features/auth/controllers/forgot_controller.dart';
import 'package:danger_now/features/auth/controllers/loginController.dart';
import 'package:danger_now/features/auth/controllers/signup_controller.dart';
import 'package:danger_now/features/auth/controllers/splash_controller.dart';
import 'package:danger_now/features/auth/views/forgot_page.dart';
import 'package:danger_now/features/auth/views/login.dart';
import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:danger_now/features/auth/views/signup_page.dart';
import 'package:danger_now/features/auth/views/splash_page.dart';
import 'package:danger_now/features/bottom_nav/views/NaviSCreen.dart';
import 'package:danger_now/features/home/controllers/HomeController.dart';
import 'package:danger_now/features/home/views/HomePage.dart';
import 'package:danger_now/features/location/views/LiveLocation.dart';
import 'package:danger_now/features/location/controllers/locationController.dart';
import 'package:danger_now/features/profile/controllers/Controller.dart';
import 'package:danger_now/features/profile/views/profilePage.dart';
import 'package:danger_now/features/users/controllers/usersController.dart';
import 'package:danger_now/features/userdetail/views/UserdetailScreen.dart';
import 'package:danger_now/features/wines/controllers/WineController.dart';
import 'package:danger_now/features/wines/views/WineScreen.dart';
import 'package:get/get.dart';
import '../../features/bottom_nav/controllers/NaviController.dart';
import '../../features/cart/controllers/cartController.dart';
import '../../features/cart/views/cartPage.dart';
import '../../features/users/views/Users.dart';
import '../../features/products/views/products.dart';

class AppPages {
  static final screens = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        Get.put<SplashController>(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.put<LoginController>(LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignupPage(),
      binding: BindingsBuilder(() {
        Get.put<SignupController>(SignupController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => ForgotPasswordPage(),
      binding: BindingsBuilder(() {
        Get.put<ForgotPasswordController>(ForgotPasswordController());
      }),
    ),
    GetPage(
      name: AppRoutes.navigation,
      page: () =>  NavigationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NavController>(() => NavController());
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<UsersController>(() => UsersController());
        Get.lazyPut<CartController>(() => CartController(), fenix: true);
        Get.lazyPut<WineController>(() => WineController());
        Get.lazyPut<ProfilePageController>(() => ProfilePageController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.put<HomeController>(HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.location,
      page: () => LocationScreen(),
      binding: BindingsBuilder(() {
        Get.put<LocationController>(LocationController());
      }),
    ),
    GetPage(
      name: AppRoutes.product,
      page: () {
        final productDetail = Get.arguments as Map;
        return ProductPage(
          productDetail: productDetail,
        );
      },
      binding: BindingsBuilder(() {Get.put<CartController>(CartController());
      }),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: ()=>CartScreen(),
      binding: BindingsBuilder(() {Get.put<CartController>(CartController());
      }),
    ),
    GetPage(
      name: AppRoutes.wine,
      page: () => WineScreen(),
      binding: BindingsBuilder(() {
        Get.put<WineController>(WineController());
      }),
    ),
    GetPage(
      name: AppRoutes.user,
      page: () => Users(),
      binding: BindingsBuilder(() {
        Get.put<UsersController>(UsersController());
      }),
    ),
    GetPage(
      name: AppRoutes.userDetail,
      page: () {
        final user = Get.arguments as Map<String, dynamic>;
        return UserDetailsPage(
          userInfo: user,
        );
      },
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfilePageController>(() => ProfilePageController());
      }),
    ),
  ];
}