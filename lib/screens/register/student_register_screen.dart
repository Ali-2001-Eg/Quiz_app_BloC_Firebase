import 'package:firebase_app/common/widgets/toast_widget.dart';
import 'package:firebase_app/screens/login/student_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/helpers/cache_helper.dart';
import 'logic/cubit.dart';
import 'logic/states.dart';

class StudentRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentQuizRegisterCubit>(
      create: (context) => StudentQuizRegisterCubit(),
      child: BlocConsumer<StudentQuizRegisterCubit, StudentQuizRegisterState>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is StudentQuizRegisterErrorState) {
            showToast(message: state.error, state: ToastState.ERROR);
          }
          if (state is StudentQuizCreateUserSuccessState) {

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentLoginScreen(),
                ));
            showToast(
                message: 'created account Successfully',
                state: ToastState.SUCCESS);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<StudentQuizRegisterCubit>(context);
          // print(state);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Register now to solve your academic exams',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'user name is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'user name',
                            hintText: 'user name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'email is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'email address',
                            hintText: 'email address',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          onFieldSubmitted: (value) {},
                          obscureText: StudentQuizRegisterCubit.get(context)
                              .isPasswordShown,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'password',
                            hintText: 'password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                StudentQuizRegisterCubit.get(context)
                                    .changeSuffixAndObscureText();
                              },
                              icon: Icon(
                                StudentQuizRegisterCubit.get(context).suffix,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'phone is too short';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'phone',
                            hintText: 'phone',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is StudentQuizRegisterLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.studentRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          context: context,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'register'.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
