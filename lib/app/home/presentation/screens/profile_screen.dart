import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_info/user_info_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return Scaffold(
          body: state is UserInfoStateSuccessful ? Center(
            child: Text(
              state.userInfo.displayName
            ),
          ) : const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
