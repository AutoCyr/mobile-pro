import 'package:autocyr_pro/data/datasources/auths/auth_datasource_impl.dart';
import 'package:autocyr_pro/data/datasources/commons/common_datasource_impl.dart';
import 'package:autocyr_pro/data/datasources/partners/partner_datasource_impl.dart';
import 'package:autocyr_pro/data/helpers/notifications.dart';
import 'package:autocyr_pro/data/network/api_client.dart';
import 'package:autocyr_pro/data/repositories/auth_repository_impl.dart';
import 'package:autocyr_pro/data/repositories/common_repository_impl.dart';
import 'package:autocyr_pro/data/repositories/partner_repository_impl.dart';
import 'package:autocyr_pro/domain/usecases/auth_usecase.dart';
import 'package:autocyr_pro/domain/usecases/common_usecase.dart';
import 'package:autocyr_pro/domain/usecases/partner_usecase.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/map_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/screens/starters/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDii5OlQI6N_8qksKSR0aDiDLIXu7qdY6o",
        appId: "1:882164644819:android:23a7d44d63e59250784d26",
        messagingSenderId: "882164644819",
        projectId: "autocyr-partner"
    ),
  );
  await Notifications().initNotifications();

  ApiClient apiClient = ApiClient();

  AuthDataSourceImpl authDataSourceImpl = AuthDataSourceImpl(apiClient);
  CommonDataSourceImpl commonDataSourceImpl = CommonDataSourceImpl(apiClient);
  PartnerDataSourceImpl partnerDataSourceImpl = PartnerDataSourceImpl(apiClient);

  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl(authDataSourceImpl);
  CommonRepositoryImpl commonRepositoryImpl = CommonRepositoryImpl(commonDataSourceImpl);
  PartnerRepositoryImpl partnerRepositoryImpl = PartnerRepositoryImpl(partnerDataSourceImpl);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return AuthNotifier(
            authUseCase: AuthUseCase(authRepositoryImpl)
          );
        }),
        ChangeNotifierProvider(create: (_) {
          return CommonNotifier(
            commonUseCase: CommonUseCase(commonRepositoryImpl)
          );
        }),
        ChangeNotifierProvider(create: (_) {
          return PartnerNotifier(
            partnerUseCase: PartnerUseCase(partnerRepositoryImpl)
          );
        }),
        ChangeNotifierProvider(create: (_) => MapNotifier()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      debugShowCheckedModeBanner: false,
      theme: GlobalThemeData.lightThemeData,
      home: const SplashScreen(),
    );
  }
}
