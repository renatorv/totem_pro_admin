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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.redirectTo});

  final String? redirectTo;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
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
                      'Vamos criar sua conta!',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      title: 'Nome',
                      hint: 'Digite seu nome completo',
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Nome obrigatório';
                        } else if (s.trim().split(' ').length < 2) {
                          return 'Digite seu nome completo';
                        }
                        return null;
                      },
                      onChanged: (s) => name = s ?? '',
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      title: 'E-mail',
                      hint: 'Digite seu e-mail',
                      validator: (s) {
                        if (s == null || !EmailValidator.validate(s)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onChanged: (s) => email = s ?? '',
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      title: 'Senha',
                      hint: 'Digite sua senha',
                      isHidden: true,
                      validator: (s) {
                        if (s == null || s.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (s.length < 8) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onChanged: (s) => password = s ?? '',
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Cadastrar',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final AuthRepository authRepository = getIt();

                          final l = showLoading();

                          final result = await authRepository.signUp(
                            name: name,
                            email: email,
                            password: password,
                          );

                          l();

                          if (result.isLeft) {
                            switch(result.left) {
                              case SignUpError.userAlreadyExists:
                                showError(
                                  'Usuário já existe. Por favor, faça login.',
                                );
                              case SignUpError.unknown:
                                showError(
                                  'Falha ao criar conta! Por favor, tente novamente.',
                                );
                            }
                            return;
                          }

                          final loginResult = await authRepository.signIn(
                            email: email,
                            password: password,
                          );

                          if(!context.mounted) return;

                          if(loginResult.isLeft) {
                            showSuccess('Conta criada com sucesso! Faça seu login para continuar.');
                            context.go('/sign-in');
                          } else {
                            showSuccess('Bem-vindo(a) de volta!');
                            context.go(widget.redirectTo ?? '/home');
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: AppTextButton(
                        label: 'Eu já tenho conta',
                        onPressed: () {
                          context.go(
                            '/sign-in${widget.redirectTo != null ? '?redirectTo=${widget.redirectTo!}' : ''}',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!context.isSmallScreen)
            Expanded(flex: 3, child: Container(color: Colors.blue)),
        ],
      ),
    );
  }
}
