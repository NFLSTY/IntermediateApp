import 'package:go_router/go_router.dart';
import 'package:intermediate_mobile_amcc24/pages/home_page.dart';
import 'package:intermediate_mobile_amcc24/pages/login_page.dart';
import 'package:intermediate_mobile_amcc24/pages/register_page.dart';
import 'package:intermediate_mobile_amcc24/pages/splash_page.dart';

part 'route_names.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: Routenames.splash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
      path: '/Login',
      name: Routenames.login,
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: 'signup',
          name: Routenames.signup,
          builder: (context, state) => const RegisterPage(),
        ),
      ]),
  GoRoute(
    path: '/home',
    name: Routenames.home,
    builder: (context, state) => const HomePage(),
  )
]);
