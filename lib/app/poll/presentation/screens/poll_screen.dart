import 'package:alex_quizz/app/home/presentation/screens/widgets/home_app_bar.dart';
import 'package:alex_quizz/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../bloc/poll_bloc.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for(var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controllers.clear();
    return Scaffold(
      appBar: HomeAppBar(context: context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          _send();
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: AppGradients.primary
        ),
        child: SafeArea(
          child: BlocBuilder<PollBloc, PollState>(
            builder: (context, pollState) {
              if(pollState is PollStateSuccessful) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView.builder(
                    itemCount: pollState.questions.length,
                    itemBuilder: (context, index) {
                      TextEditingController controller = TextEditingController();
                      controllers.add(controller);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTex(context, pollState.questions[index].split(r"$")),
                            const SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: TextFormField(
                                controller: controllers[index],
                                decoration: const InputDecoration(
                                  border: InputBorder.none
                                ),
                                maxLines: 5,
                                minLines: 1,
                                validator: (value) {
                                  if(value == null || value.isEmpty) {
                                    return "Please fill this field";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTex(BuildContext context, List<String> tex) {
    var listTex = <Widget>[];
    int sizeOfListTex = tex.length;
    for(int i = 0; i < sizeOfListTex; i++) {
      if(i % 2 == 0) {
        listTex.add(Text(tex[i], style: Theme.of(context).textTheme.subtitle1));
      } else {
        listTex.add(Math.tex(tex[i], textStyle: Theme.of(context).textTheme.subtitle1));
      }
    }
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: listTex
    );
  }

  void _send() {
    if(_formKey.currentState!.validate()) {
      var answers = <String>[];
      for(var controller in controllers) {
        answers.add(controller.value.text);
      }
      BlocProvider.of<PollBloc>(context).add(PollEventSubmit(answers: answers));
    }
  }
}
