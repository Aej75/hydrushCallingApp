import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final auth = FirebaseAuth.instance;

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonTapEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await auth.verifyPhoneNumber(
            phoneNumber: event.number,
            timeout: const Duration(minutes: 1),
            verificationCompleted: (phoneAuthCredential) {},
            verificationFailed: ((error) => add(
                  SignUpErrorEvent(error.toString()),
                )),
            codeSent: ((verificationId, forceResendingToken) =>
                add(CodeSentEvent(verificationId))),
            codeAutoRetrievalTimeout: ((verificationId) => {}));
      } catch (e) {
        emit(SignUpFailState(e.toString()));
      }
    });

    on<CodeSentEvent>((event, emit) async {
      emit(SignUpSuccessState(event.verificationId));
    });
    on<SignUpErrorEvent>((event, emit) async {
      emit(SignUpFailState(event.error));
    });
  }
}
