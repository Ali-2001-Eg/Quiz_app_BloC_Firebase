import 'package:firebase_app/common/widgets/toast_widget.dart';
import 'package:firebase_app/screens/register/student_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/helpers/cache_helper.dart';
import '../home/home_screen.dart';
import 'logic/cubit.dart';
import 'logic/states.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider<StudentQuizLoginCubit>(
      create: (context) => StudentQuizLoginCubit(),
      child: BlocConsumer<StudentQuizLoginCubit, StudentQuizLoginState>(
        // buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is StudentQuizLoginErrorState) {
            showToast(message: state.error, state: ToastState.ERROR);
          }
          if (state is StudentQuizLoginSuccessState) {
            showToast(message: 'SUCCESS LOGIN', state: ToastState.SUCCESS);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<StudentQuizLoginCubit>(context);
          // print(state);
          return Scaffold(
            // appBar: AppBar(),
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Login now to solve your academic exams',
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
                          obscureText: cubit.isPasswordShown,
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
                                cubit.changeSuffixAndObscureText();
                              },
                              icon: Icon(cubit.suffix),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        state is StudentQuizLoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.studentLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context
                                            );
                                      }
                                    },
                                    child: Text(
                                      'login'.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentRegisterScreen(),
                                      ));
                                },
                                child: Text('Register Now'.toUpperCase()))
                          ],
                        )
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
