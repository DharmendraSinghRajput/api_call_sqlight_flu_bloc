import 'package:api_call_sqlight_flu_bloc/view/register_screen.dart';
import 'package:api_call_sqlight_flu_bloc/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sql_bloc/profile_sqlight_bloc.dart';
import '../debug/bloc_observer.dart';
import '../go_router_navigation/app_routs_config.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}
//final _appRouter = AppRouter();


class MyApp extends StatelessWidget {
   MyApp({super.key});
   final MyAppNavigation _appNavigation = MyAppNavigation();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileSqlightBloc(),
        ),
        // Add other BlocProviders here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
