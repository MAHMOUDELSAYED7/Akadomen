import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service/audio_service.dart';
import '../../presentation/controllers/logout/logout_cubit.dart';
import '../utils/constants/audios.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/routes.dart';
import '../utils/helpers/my_snackbar.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: const EdgeInsets.only(top: 5),
      height: 34,
      message: 'Logout',
      decoration: BoxDecoration(
          color: ColorManager.error, borderRadius: BorderRadius.circular(4)),
      child: BlocListener<AuthStatus, AuthStatusState>(
        listener: (context, state) {
          if (state is Logout) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteManager.login, (route) => false);
            customSnackBar(context, 'Logout Successfully!');
          }

          if (state is LogoutFailure) {
            customSnackBar(context, 'There was an error!');
          }
        },
        child: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            AudioService.playLogoutSound();
            context.read<AuthStatus>().logout();
          },
        ),
      ),
    );
  }
}
