import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.autologin();

    if (userProvider.currentuser != null) {
      Navigator.pushReplacementNamed(context, 'mainscreen');
    } else {
      Navigator.pushReplacementNamed(context, 'Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
