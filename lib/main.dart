import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:whatsapp/core/route/auth_guard.dart';
import 'package:whatsapp/core/route/routes.gr.dart';

import 'features/dashboard/presentation/pages/bloc/listen_bloc/listen_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EasyLoading.instance.backgroundColor = Colors.orangeAccent;
  EasyLoading.instance.userInteractions = false;
  EasyLoading.instance.dismissOnTap = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final router = AppRouter(authGuard: AuthGuard());

  bool call = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// var listener = FirebaseFirestore.instance
//         .collection('Users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .snapshots().listen((event) {
//           for(var change in event.)
//          });
  }

  ListenBloc listenBloc = ListenBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return FlutterEasyLoading(
          child: MaterialApp.router(
            builder: (_, child) => _Unfocus(child: child!),
            theme: ThemeData.dark(),
            routerDelegate: AutoRouterDelegate(router),
            routeInformationParser: router.defaultRouteParser(),
          ),
        );
      },
    );
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
