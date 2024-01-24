import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/user_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/user_page/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSegement extends StatefulWidget {
  const ProfileSegement({super.key});

  @override
  State<ProfileSegement> createState() => _ProfileSegementState();
}

class _ProfileSegementState extends State<ProfileSegement> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLodingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }
        if (state is UserLoggedOutState) {
          return const Center(
            // add UI when user is logged out
            child: Text("User is logged out"),
          );
        }
        return const Center(
          child: Text("An error occured"),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.fullName, style: TextStyles.heading4),
            Text(userModel.email, style: TextStyles.body1),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProfilePage.routeName);
              },
              child: const Text("Edit profile"),
            ),
          ],
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {},
          leading: const Icon(
            Icons.add_box,
            color: Colors.red,
          ),
          title: Text("My orders", style: TextStyles.body1),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            "Sign Out",
            style: TextStyles.body1.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
