import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service/audio_service.dart';
import '../../core/utils/constants/audios.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/constants/routes.dart';
import '../../core/utils/extension/extension.dart';
import '../../presentation/controllers/logout/logout_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndPlayAudio();
    _goToNextScreen();
  }

  Future<void> _initializeAndPlayAudio() async {
    await AudioService.initialize();
    await AudioService.playSplashSound();
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.read<AuthStatus>().checkLoginStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatus, AuthStatusState>(
      listener: (context, state) {
        if (state is Login) {
          Navigator.pushReplacementNamed(context, RouteManager.home);
        }
        if (state is Logout) {
          Navigator.pushReplacementNamed(context, RouteManager.login);
        }
      },
      child: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImageManager.authBackground),
            ),
          ),
          child: Image.asset(
            ImageManager.akadomenLogo,
            width: context.width / 3,
            height: context.width / 3,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
