import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/service/audio_service.dart';
import '../../core/utils/constants/audios.dart';
import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/constants/routes.dart';
import '../../core/utils/extension/extension.dart';
import '../../core/utils/helpers/my_snackbar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../presentation/controllers/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  late GlobalKey<FormState> _formKey;

  String? _username;
  String? _password;

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context
          .read<LoginCubit>()
          .login(username: _username!.trim(), password: _password!.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ImageManager.authBackground),
          ),
        ),
        child: Container(
          width: context.width / 2.2,
          height: context.height / 1.3,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(26),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width / 15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Log in',
                      style: context.textTheme.bodyLarge,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          'Don’t have an ccount? ',
                          style: context.textTheme.displayMedium,
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign up',
                            style: context.textTheme.displayMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.brown),
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, RouteManager.register),
                        )
                      ],
                    ),
                    Image.asset(
                      ImageManager.akadomenLogo,
                      height: 50.sp,
                      width: 50.sp,
                    ),
                    MyTextFormField(
                      title: 'Your username',
                      hintText: 'Enter your username',
                      onSaved: (data) => _username = data,
                    ),
                    MyTextFormField(
                      title: 'Your password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      onSaved: (data) => _password = data,
                    ),
                    SizedBox(height: 40.h),
                    BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          customSnackBar(context, 'Login success!');
                          AudioService.playLogoutSound();
                          Navigator.pushReplacementNamed(
                              context, RouteManager.home);
                        }
                        if (state is LoginFailure) {
                          customSnackBar(context, 'Login failed!');
                        }
                      },
                      child: MyElevatedButton(
                        title: 'Log in',
                        onPressed: _login,
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
