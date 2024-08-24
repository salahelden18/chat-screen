import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';
import 'package:yuppo_chat_app/cubit/message_cubit.dart';
import 'package:yuppo_chat_app/custom_bloc_observer.dart';
import 'package:yuppo_chat_app/home_screen.dart';

void main() {
  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => MessageCubit()..init(),
      child: MaterialApp(
        title: 'Yuppo Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
