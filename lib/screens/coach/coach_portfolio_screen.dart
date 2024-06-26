import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sport_app_lct/screens/coach/coach_edit_profile.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_event.dart';
import '../../blocs/user_bloc/user_state.dart';
import '../../repositories/user_repository.dart';

class CoachPortfolioScreen extends StatelessWidget {
  const CoachPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => UserBloc(userRepository: UserRepository())..add(LoadUserEvent()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Header(text: "Профиль"),
                      const Spacer(),
                      GestureDetector(
                        child: Image.asset("assets/edit_orange.png", height: 32),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CoachEditProfile()),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoadedState) {
                        final user = state.user;
                        final userName = user.name?.isNotEmpty == true ? user.name : "Без Имени";
                        final userAge = user.age != null ? user.age.toString() : '';
                        final userDisplay = userAge.isNotEmpty ? "$userName, $userAge" : userName;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  BlocProvider.of<UserBloc>(context).add(UploadUserIconEvent(image: File(pickedFile.path)));
                                }
                              },
                              child: Stack(
                                children: [
                                  if (user.icon != null && user.icon!.isNotEmpty)
                                    Image.network(
                                      height: 400,
                                      width: MediaQuery.of(context).size.width - 40,
                                      fit: BoxFit.contain,
                                      '${user.icon}'
                                    ),
                                  if (user.icon == null || user.icon!.isEmpty)
                                    Image.asset(
                                      "assets/coach_no_photo.png",
                                      width: MediaQuery.of(context).size.width - 40,
                                    ),

                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      userDisplay!,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'GilroyMedium',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24,),

                            SmallText(text: 'О себе', textColor: Color(0xFFED6929),),
                            SmallText(text: state.user.about ?? 'Информация отсутствует', textAlign: TextAlign.left,),

                            const SizedBox(height: 12,),

                            SmallText(text: 'Достижения', textColor: Color(0xFFED6929)),
                            SmallText(text: state.user.achivements ?? 'Информация отсутствует', textAlign: TextAlign.left,),

                            const SizedBox(height: 80,),
                          ],
                        );
                      } else if (state is UserErrorState) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(child: Text("Не удалось загрузить данные пользователя"));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
