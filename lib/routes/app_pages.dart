import 'package:cv_dragon/app/modeules/Home/binding/home_binding.dart';
import 'package:cv_dragon/app/modeules/Home/views/home_screen.dart';
import 'package:cv_dragon/routes/routes.dart';
import 'package:get/get.dart';
import '../app/modeules/Splash/binding/splash_binding.dart';
import '../app/modeules/Splash/views/splash_screen.dart';


class Theme1AppPages {
  static const INITIAL = Routes.ROOT;
  static const INITIAL_FOR_HOME_ = Routes.HOME;
  static final routes = [
    GetPage(
        name: Routes.ROOT,
        page: () => const SplashScreen(),
      binding: SplashBinding(),
       ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}