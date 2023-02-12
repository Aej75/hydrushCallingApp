import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/auth/signup/presentation/bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final db = FirebaseFirestore.instance;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _prefix = "+977";

  SignUpBloc signUpBloc = SignUpBloc();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => signUpBloc,
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              EasyLoading.show();
            } else if (state is SignUpFailState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            } else if (state is SignUpSuccessState) {
              EasyLoading.dismiss();
              context.router
                  .push(VerifyPageRoute(verificationId: state.verificationId));
            }
          },
          child: SafeArea(
              child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        prefixText: _prefix,
                        label: const Text('Enter your mobile number'),
                        labelStyle: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      signUpBloc.add(SignUpButtonTapEvent(
                          _prefix + _phoneController.text));
                      // if (_formKey.currentState!.validate()) {
                      //   try {
                      //     var signUp = await auth.createUserWithEmailAndPassword(
                      //         email: _emailController.text,
                      //         password: _passwordController.text);

                      // await db
                      //     .collection('Users')
                      //     .doc(auth.currentUser!.uid)
                      //     .set({
                      //   "email": _emailController.text,
                      //   "password": _passwordController.text,
                      //   "uID": auth.currentUser!.uid,
                      // });

                      //     await context.router.pushAndPopUntil(
                      //         const LoginPageRoute(),
                      //         predicate: ((route) => false));
                      //     print('User registerd ${signUp.user!.uid}');
                      //   } on FirebaseAuthException catch (e) {
                      //     log(e.toString());
                      //   }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Sign Up'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
