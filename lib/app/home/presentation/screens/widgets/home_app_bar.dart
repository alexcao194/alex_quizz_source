import 'package:alex_quizz/app/home/presentation/screens/profile_screen.dart';
import 'package:alex_quizz/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_paths.dart';
import '../../../../../core/services/app_router/app_router.dart';
import '../../bloc/user_info/user_info_bloc.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({super.key, required this.context}) : super(
    actions: [
      GestureDetector(
          onTap: () {
            BlocProvider.of<UserInfoBloc>(context).add(UserInfoEventGet());
            AppRouter.push(const ProfileScreen());
          },
          child: Image.asset(AppPath.userDefaultFill)
      )
    ],
    title: Text(
      'Alex Quiz',
      style: Theme.of(context).textTheme.headline4!.copyWith(
        color: Colors.blue,
        fontWeight: FontWeight.bold
      ),
    ),
  );
  final BuildContext context;
}
