import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/user_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:ecommerce_mobile_app/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  static const routeName = "edit-profile-page";
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
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
              return editProfile(state.userModel);
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
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Personal Details",
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(size: -10),
        PrimaryTextField(
          initialValue: userModel.fullName,
          // validator: (v) {
          //   if (v == null || v.isEmpty) {
          //     return "Email can't be empty";
          //   } else if (!(RegExp(
          //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          //       .hasMatch(v))) {
          //     return "Invalid email";
          //   }
          //   return null;
          // },
          //  controller: emailController,
          labelText: "Full Name",
          onChanged: (value) {
            userModel.fullName = value;
          },
        ),
        const Gap(),
        PrimaryTextField(
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          // controller: emailController,
          labelText: "Phone Number",
        ),
        const Gap(size: 20),
        Text(
          "Address",
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(size: -10),
        PrimaryTextField(
          initialValue: userModel.address,
          // controller: emailController,
          labelText: "Address",
          onChanged: (value) {
            userModel.address = value;
          },
        ),
        const Gap(),
        PrimaryTextField(
          initialValue: userModel.city,
          // controller: emailController,
          labelText: "City",
          onChanged: (value) {
            userModel.city = value;
          },
        ),
        const Gap(),
        PrimaryTextField(
          initialValue: userModel.state,
          // controller: emailController,
          labelText: "State",
          onChanged: (value) {
            userModel.state = value;
          },
        ),
        const Gap(
          size: 15,
        ),
        FilledButton(
          onPressed: () async {
            bool success =
                await BlocProvider.of<UserCubit>(context).updateUser(userModel);
            if (success) {
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
