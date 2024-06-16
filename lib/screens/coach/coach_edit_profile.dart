import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import 'package:sport_app_lct/widgets/custom_input_extendable.dart';
import 'package:sport_app_lct/widgets/header.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_event.dart';
import '../../blocs/user_bloc/user_state.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/custom_input_age.dart';

class CoachEditProfile extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _achivementsController = TextEditingController();
  final TextEditingController _aboutYourselfController = TextEditingController();

  CoachEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepository: UserRepository())..add(LoadUserEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 24),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserLoadedState) {
                _nameController.text = state.user.name ?? '';
                _ageController.text = state.user.age?.toString() ?? '';
                _achivementsController.text = state.user.achivements ?? '';
                _aboutYourselfController.text = state.user.about ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(text: "Редактировать профиль", textAlign: TextAlign.left,),

                    const SizedBox(height: 12,),

                    CustomInput(
                      controller: _nameController,
                      isDescription: true,
                      description: "Имя",
                    ),

                    const SizedBox(height: 12,),

                    CustomInputAge(
                      controller: _ageController,
                      isDescription: true,
                      description: "Возраст",
                    ),

                    const SizedBox(height: 12,),

                    CustomInputExtendable(
                      controller: _achivementsController,
                      isDescription: true,
                      description: "О себе",
                    ),

                    const SizedBox(height: 12,),

                    CustomInputExtendable(
                      controller: _aboutYourselfController,
                      isDescription: true,
                      description: "Достижения",
                    ),

                    const Spacer(),

                    ButtonPrimary(
                      text: "Сохранить",
                      isFullWidth: true,
                      onPress: () {
                        final user = state.user.copyWith(
                          name: _nameController.text,
                          age: int.tryParse(_ageController.text),
                          achivements: _achivementsController.text,
                          about: _aboutYourselfController.text,
                        );
                        context.read<UserBloc>().add(UpdateUserEvent(user: user));
                        Navigator.pop(context);
                      }
                    )
                  ],
                );
              } else if (state is UserErrorState) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Не удалось загрузить данные пользователя"));
              }
            },
          ),
        )
      ),
    );
  }
}
