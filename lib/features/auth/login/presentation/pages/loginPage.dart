import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/route/routes.gr.dart';

class LoginPage extends StatefulWidget {
  final String verificationID;
  const LoginPage({super.key, required this.verificationID});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // if (auth.currentUser != null) {
    //   context.router.push(
    //     const HomePageRoute(),
    //   );
    // }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email address',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   try {
                    //     var signUp = await auth.signInWithEmailAndPassword(
                    //         email: _emailController.text,
                    //         password: _passwordController.text);

                    //     context.router.pushAndPopUntil(const HomePageRoute(),
                    //         predicate: ((route) => false));

                    //     print('User registerd ${signUp.user!.uid}');
                    //   } on FirebaseException catch (e) {
                    //     log(e.toString());
                    //   }
                    // }
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  onPressed: () async {
                    context.router.push(SignUpPageRoute());
                  },
                  child: const Text('Sign Up'))
            ],
          ),
        ),
      )),
    );
  }
}
