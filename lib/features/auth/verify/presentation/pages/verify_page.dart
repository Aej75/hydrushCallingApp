import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/auth/verify/presentation/bloc/verify_bloc.dart';

class VerifyPage extends StatefulWidget {
  final String verificationId;
  const VerifyPage({super.key, required this.verificationId});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  VerifyBloc verifyBloc = VerifyBloc();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Optionally you can use form to validate the Pinput
    return Scaffold(
      body: BlocProvider(
        create: (context) => verifyBloc,
        child: BlocListener<VerifyBloc, VerifyState>(
          listener: (context, state) {
            if (state is VerifyLoadingState) {
              EasyLoading.show();
            } else if (state is VerifyFailState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            } else if (state is VerifySuccessState) {
              EasyLoading.show();
              EasyLoading.showSuccess(state.message);
              context.router.pushAndPopUntil(
                const HomePageRoute(),
                predicate: (route) => false,
              );
            }
          },
          child: Form(
            key: formKey,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    controller: pinController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "It cannot be empty";
                      } else if (pinController.text.length != 6) {
                        return "please enter the valid OTP";
                      }
                      return null;
                    },
                    focusedPinTheme: defaultPinTheme,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        verifyBloc.add(VerifyTapEvent(
                            verificationId: widget.verificationId,
                            otp: pinController.text));
                      }
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
