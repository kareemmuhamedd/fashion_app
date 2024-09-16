import 'package:fashion_app/common/utils/app_routes.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/src/auth/controllers/auth_notifier.dart';
import 'package:fashion_app/src/auth/controllers/password_notifier.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/categories/controllers/category_notifier.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_app/src/home/controllers/home_tab_notifier.dart';
import 'package:fashion_app/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:fashion_app/src/products/controllers/color_sizes_notifier.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:fashion_app/src/search/controllers/search_notifier.dart';
import 'package:fashion_app/src/splash_screen/views/splash_screen.dart';
import 'package:fashion_app/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'common/utils/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load the correct environment
  await dotenv.load(fileName: Environment.fileName);

  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
        ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
        ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ChangeNotifierProvider(create: (_) => ColorSizesNotifier()),
        ChangeNotifierProvider(create: (_) => PasswordNotifier()),
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => SearchNotifier()),
        ChangeNotifierProvider(create: (_) => WishlistNotifier()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}
