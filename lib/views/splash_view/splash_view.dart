import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:minitodo/task_cubit/task_cubit.dart';
import 'package:minitodo/views/home_view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void delay() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => TaskCubit()..getTasks(),
              child: const HomeView(),
            );
          },
        ),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    delay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset('assets/images/splash.png'),
            ),
            Text(
              "Task Manager",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Text(
              "Organize Your Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            Text(
              "get more done.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(150),
            CircularProgressIndicator(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
