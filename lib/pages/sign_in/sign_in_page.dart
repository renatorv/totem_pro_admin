import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:totem_pro_admin/core/extensions.dart';
import 'package:totem_pro_admin/widgets/app_logo.dart';
import 'package:totem_pro_admin/widgets/app_primary_button.dart';
import 'package:totem_pro_admin/widgets/app_text_button.dart';
import 'package:totem_pro_admin/widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(size: 50),
                    const SizedBox(height: 32),
                    const Text(
                      'Bem vindo(a) de volta!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      title: 'E-mail',
                      hint: 'Digite o seu e-mail',
                      onChanged: (s) => email = s ?? '',
                      validator: (s) {
                        if (s == null || !EmailValidator.validate(s)) {
                          return 'E-mail Inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      title: 'Senha',
                      hint: 'Digite o seu senha',
                      obscure: true,
                      onChanged: (s) => password = s ?? '',
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Campo obrigatório!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Entrar',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: AppTextButton(
                        label: 'Ainda não tenho conta',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!context.isSmalScreen)
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}
