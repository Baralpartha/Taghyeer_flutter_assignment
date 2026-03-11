import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(text: 'emilys');
  final passwordController = TextEditingController(text: 'emilyspass');
  final formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final loading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const FlutterLogo(size: 72),
                      const SizedBox(height: 20),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Enter username' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => obscure = !obscure),
                            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                          ),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Enter password' : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: loading
                              ? null
                              : () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          child: loading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : const Text('Login'),
                        ),
                      ),
                    ],
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