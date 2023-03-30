import 'dart:io';
import 'package:alex_quizz/app/checkin/presentation/bloc/checkin/check_in_cubit.dart';
import 'package:alex_quizz/app/home/presentation/bloc/user_info/user_info_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:alex_core/alex_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alex_quizz/core/extension/time_extension.dart';

import '../../../../config/app_paths.dart';
import '../../../../core/services/app_router/app_router.dart';
import '../../../../core/services/image_picker/image_picker.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  XFile? img;
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, userState) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    const Text('Check in', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: img == null ? Image.asset(AppPath.userDefaultFill) : Image.file(File(img!.path)),
                          )),
                    ),
                    InkWellButton(
                      height: 70,
                      width: 70,
                      borderWidth: 2.0,
                      onTap: () async {
                        ImgPicker.onPick(ImageSource.camera).then((value) {
                          setState(() {
                            img = value;
                          });
                        });
                      },
                      primaryColor: Colors.red,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWellButton(
                          height: 50,
                          width: 120,
                          radius: 10.0,
                          onTap: () {
                            AppRouter.pop();
                          },
                          primaryColor: Colors.red,
                          child: const Text('Cancel'),
                        ),
                        SizedBox(width: size.width * 0.1),
                        InkWellButton(
                          height: 50,
                          width: 120,
                          radius: 10.0,
                          onTap: img != null
                              ? () async {
                            setState(() {
                              isLoad = true;
                            });
                            context.read<CheckInCubit>().onCheck(
                                DateTime.now().toLocalTimeString(),
                                File(img!.path),
                                (userState is UserInfoStateSuccessful ? userState.userInfo.id : 'unknown'))
                            ;
                          }
                              : null,
                          primaryColor: img == null ? Colors.grey : Colors.red,
                          child: const Text('Check in'),
                        )
                      ],
                    ),
                    const SizedBox(height: 50.0)
                  ],
                ),
                if (isLoad)
                  Container(
                    color: Colors.white12,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
