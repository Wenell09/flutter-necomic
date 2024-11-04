import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/auth/auth_bloc.dart';
import 'package:flutter_komik/bloc/favorites/favorites_bloc.dart';
import 'package:flutter_komik/bloc/save_userId/save_user_id_bloc.dart';
import 'package:flutter_komik/bloc/theme/theme_bloc.dart';
import 'package:flutter_komik/bloc/user/user_bloc.dart';
import 'package:flutter_komik/firebase_options.dart';
import 'package:flutter_komik/pages/splash_page.dart';
import 'package:flutter_komik/repository/auth_repo.dart';
import 'package:flutter_komik/repository/favorites_repo.dart';
import 'package:flutter_komik/repository/user_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadTheme()),
        ),
        BlocProvider(
          create: (context) => SaveUserIdBloc()..add(LoadUserId()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserRepo()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(FavoritesRepo()),
        ),
      ],
      child: BlocListener<SaveUserIdBloc, SaveUserIdState>(
        listener: (context, state) {
          if (state is SaveUserLoaded) {
            context.read<UserBloc>().add(GetUser(uid: state.userId));
            context
                .read<FavoritesBloc>()
                .add(GetFavorites(userId: state.userId));
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: "Necomic",
              debugShowCheckedModeBanner: false,
              theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
