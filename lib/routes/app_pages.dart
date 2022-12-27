import 'package:get/get.dart';

import '../app/views/screens/home_screen.dart';
import '../logic/bindings/HomeBinding.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}