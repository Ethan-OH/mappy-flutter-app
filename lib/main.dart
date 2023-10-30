import 'package:final_main_project/view/firstpage.dart';
import 'package:final_main_project/view/tabbar_screen.dart';
import 'package:final_main_project/viewmodel/card_vm.dart';
import 'package:final_main_project/viewmodel/theme_obs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load();
  KakaoSdk.init(nativeAppKey: 'faa13ab1a0485a4e5528d40c061caaef');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

const seedColor = Color(0xff309cff);

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final userid = Get.put(CardVm());

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() => GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.red,
                  brightness: themeController.isDarkMode.value
                      ? Brightness.dark
                      : Brightness.light,
                ),
                textTheme: GoogleFonts.notoSansNKoTextTheme(
                  Theme.of(context).textTheme,
                ),
                useMaterial3: true,
              ),
              home: userid.uId.value.isNotEmpty
                  ? const TabBarScreen()
                  : const First(),
            ));
      },
    );
  }
}
