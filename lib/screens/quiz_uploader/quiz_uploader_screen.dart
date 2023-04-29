import 'package:firebase_app/screens/quiz_uploader/logic/cubit.dart';
import 'package:firebase_app/screens/quiz_uploader/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizUploaderScreen extends StatelessWidget {
  const QuizUploaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizUploaderCubit>(
      create: (context) => QuizUploaderCubit()..uploadData(context),
      child: BlocConsumer<QuizUploaderCubit, QuizUploaderState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: state is QuizUploaderLoadingState?
            const Center(child: CircularProgressIndicator(),):
            const Center(child: Text('Uploading'),),
          ),
        ),
      );
  }
}
