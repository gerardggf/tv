import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/translations.g.dart';
import '../../../../inject_repositories.dart';
import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(
        SignInState(),
        sessionController: context.read(),
        favoritesController: context.read(),
        authenticationRepository: Repositories.authentication,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(builder: (context) {
                final controller = Provider.of<SignInController>(context);
                return AbsorbPointer(
                  absorbing: controller.state.fetching,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          controller.onUsernameChanged(text);
                        },
                        validator: (text) {
                          text = text?.trim().toLowerCase() ?? '';

                          if (text.isEmpty) {
                            return texts.signIn.errors.username;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: texts.signIn.username,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          controller.onPasswordChanged(text);
                        },
                        validator: (text) {
                          text = text?.replaceAll(' ', '') ?? '';

                          if (text.length < 4) {
                            return texts.signIn.errors.password;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: texts.signIn.password,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SubmitButton(),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
