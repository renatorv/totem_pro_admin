// tested with just a hot reload.
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totem_pro_admin/core/di.dart';
import 'package:totem_pro_admin/core/extensions.dart';
import 'package:totem_pro_admin/repositories/auth_repository.dart';
import 'package:totem_pro_admin/widgets/app_logo.dart';
import 'package:totem_pro_admin/widgets/app_primary_button.dart';
import 'package:totem_pro_admin/widgets/app_text_button.dart';
import 'package:totem_pro_admin/widgets/app_text_field.dart';
import 'package:totem_pro_admin/widgets/app_toasts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.redirectTo});

  final String? redirectTo;

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
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(size: 50),
                    const SizedBox(height: 32),
                    const Text(
                      'Bem vindo(a) de volta!',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      title: 'E-mail',
                      hint: 'Digite o seu e-mail',
                      validator: (s) {
                        if (s == null || !EmailValidator.validate(s)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onChanged: (e) => email = e ?? '',
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      title: 'Senha',
                      hint: 'Digite o sua senha',
                      isHidden: true,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Campo Obrigatório';
                        }
                        return null;
                      },
                      onChanged: (p) => password = p ?? '',
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Entrar',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final authRepository = getIt<AuthRepository>();

                          final closeLoading = showLoading();
                          final result = await authRepository.signIn(email: email, password: password);
                          closeLoading();

                          if (result.isLeft) {
                            switch (result.left) {
                              case SignInError.invalidCredentials:
                                showError('Credenciais inválidas!');
                              case SignInError.unknown:
                                showError('Um erro inesperado ocorreu. Por favor tente novamente.');
                            }
                          } else {
                            showSuccess('Bem-vindo(a) de volta!');
                            if (context.mounted) context.go(widget.redirectTo ?? '/home');
                          }
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
          if (!context.isSmallScreen)
            Expanded(
              flex: 3,
              child: Container(color: Colors.blue),
            ),
        ],
      ),
    );
  }
}
