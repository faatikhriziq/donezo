import 'package:donezo/config/theme/app_color.dart';
import 'package:donezo/core/di/injection_container.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/common_text_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth_form/auth_form_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double shadowHeight = 3;
    double position = 4;
    const double buttonHeight = 54 - shadowHeight;
    final double width = MediaQuery.of(context).size.width - 24;
    final double height = MediaQuery.of(context).size.height;
    final double safeAreaPaddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(12, safeAreaPaddingTop, 12, 0),
        height: height - safeAreaPaddingTop,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 12),
                Image(
                  image: AssetImage('assets/images/logo-text.png'),
                  width: 150,
                  height: 50,
                ),
                SizedBox(height: 45),
                BlocBuilder<AuthFormBloc, AuthFormState>(
                  builder: (context, state) {
                    return CommonTextField(
                      isValid: state is AuthFormSignInInvalidValidateState && state.message['email']!.isNotEmpty ? false : true,
                      focusNode: emailFocusNode,
                      controller: emailController,
                      hintText: 'Enter your email',
                      onEditingComplete: () => passwordFocusNode.requestFocus(),
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
                const SizedBox(height: 5),
                BlocBuilder<AuthFormBloc, AuthFormState>(
                  builder: (context, state) {
                    if (state is AuthFormSignInInvalidValidateState && state.message['email']!.isNotEmpty) {
                      if (state.message.containsKey('email')) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " ${state.message['email']!.first}",
                            style: const TextStyle(
                              color: AppColor.redInvalid,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthFormBloc, AuthFormState>(
                  listener: (context, state) {
                    if (state is AuthFormSignInInvalidValidateState && state.message['email']!.isNotEmpty) {
                      emailFocusNode.requestFocus();
                    } else if (state is AuthFormSignInInvalidValidateState && state.message['password']!.isNotEmpty) {
                      passwordFocusNode.requestFocus();
                    } else if (state is AuthFormSignInValidValidateState && passwordFocusNode.hasFocus) {
                      passwordFocusNode.unfocus();
                    }
                  },
                  builder: (context, state) {
                    return CommonTextField(
                      isValid: state is AuthFormSignInInvalidValidateState && state.message['password']!.isNotEmpty ? false : true,
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      hintText: 'Enter your password',
                      obscureText: true,
                      onEditingComplete: () {
                        context.read<AuthFormBloc>().add(
                              AuthFormSignInValidateEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              ),
                            );
                      },
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
                const SizedBox(height: 5),
                BlocBuilder<AuthFormBloc, AuthFormState>(
                  builder: (context, state) {
                    if (state is AuthFormSignInInvalidValidateState && state.message['password']!.isNotEmpty) {
                      if (state.message.containsKey('password')) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " ${state.message['password']!.first}",
                            style: const TextStyle(
                              color: AppColor.redInvalid,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.push('/sign-up'),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.3,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSignInWithGoogleSuccess) {
                            context.go('/');
                          } else if (state is AuthSignInWithGoogleFailure) {
                            if (state.error == 'popup_closed') {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error!),
                                backgroundColor: AppColor.redInvalid,
                              ),
                            );
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(const AuthSignInWithGoogleEvent());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.3,
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/images/google-logo.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.3,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/facebook-logo.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Coming soon!'),
                              backgroundColor: AppColor.redInvalid,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.3,
                            ),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/apple-logo.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                MultiBlocListener(
                  listeners: [
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSignInSuccess) {
                          context.go('/');
                        } else if (state is AuthSignInFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error!),
                              backgroundColor: AppColor.redInvalid,
                            ),
                          );
                        }
                      },
                    ),
                    BlocListener<AuthFormBloc, AuthFormState>(listener: (context, state) {
                      if (state is AuthFormSignInValidValidateState && !passwordFocusNode.hasFocus) {
                        final signInParams = sl.get<SignInParams>();
                        signInParams.email = emailController.text.trim();
                        signInParams.password = passwordController.text;
                        context.read<AuthBloc>().add(AuthSignInEvent(signInParams: signInParams));
                      }
                    }),
                  ],
                  child: StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onTapUp: (_) {
                        setState(() {
                          position = 4;
                        });
                      },
                      onTapDown: (_) {
                        setState(() {
                          position = 0;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          position = 4;
                        });
                      },
                      onTap: () {
                        context.read<AuthFormBloc>().add(
                              AuthFormSignInValidateEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: SizedBox(
                        height: buttonHeight + shadowHeight,
                        width: width,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: width,
                                height: buttonHeight,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                                bottom: position,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 40),
                                child: Container(
                                  width: width,
                                  height: buttonHeight,
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.3,
                                    ),
                                  ),
                                  child: Center(
                                    child: BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        if (state is AuthLoading) {
                                          return const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                          );
                                        }
                                        return const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
