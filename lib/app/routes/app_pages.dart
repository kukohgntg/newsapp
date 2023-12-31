import 'package:get/get.dart';

import '../modules/appwrite_login/bindings/appwrite_login_binding.dart';
import '../modules/appwrite_login/views/appwrite_login_view.dart';
import '../modules/appwrite_register/bindings/appwrite_register_binding.dart';
import '../modules/appwrite_register/views/appwrite_register_view.dart';
import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/create_empoyee/bindings/create_empoyee_binding.dart';
import '../modules/create_empoyee/views/create_empoyee_view.dart';
import '../modules/discover/bindings/discover_binding.dart';
import '../modules/discover/views/discover_view.dart';
import '../modules/firebase_login/bindings/firebase_login_binding.dart';
import '../modules/firebase_login/views/firebase_login_view.dart';
import '../modules/firebase_register/bindings/firebase_register_binding.dart';
import '../modules/firebase_register/views/firebase_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => ArticleView(
        title: '',
        description: '',
        publishedAt: '',
        author: '',
        imageUrl: '',
        content: '',
      ),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.DISCOVER,
      page: () => const DiscoverView(),
      binding: DiscoverBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FIREBASE_LOGIN,
      page: () => FirebaseLoginView(),
      binding: FirebaseLoginBinding(),
    ),
    GetPage(
      name: _Paths.FIREBASE_REGISTER,
      page: () => FirebaseRegisterView(),
      binding: FirebaseRegisterBinding(),
    ),
    GetPage(
      name: _Paths.APPWRITE_LOGIN,
      page: () => const AppwriteLoginView(),
      binding: AppwriteLoginBinding(),
    ),
    GetPage(
      name: _Paths.APPWRITE_REGISTER,
      page: () => const AppwriteRegisterView(),
      binding: AppwriteRegisterBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EMPOYEE,
      page: () => const CreateEmpoyeeView(),
      binding: CreateEmpoyeeBinding(),
    ),
  ];
}
