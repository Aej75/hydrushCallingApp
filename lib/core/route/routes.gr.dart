// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:agora_rtc_engine/rtc_engine.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../features/auth/login/presentation/pages/loginPage.dart' as _i3;
import '../../features/auth/signup/presentation/pages/signup_page.dart' as _i2;
import '../../features/auth/verify/presentation/pages/verify_page.dart' as _i7;
import '../../features/dashboard/presentation/pages/chat_screen.dart' as _i4;
import '../../features/dashboard/presentation/pages/contact_page.dart' as _i6;
import '../../features/dashboard/presentation/pages/homepage.dart' as _i1;
import '../../features/videoCall/presentation/pages/callPage.dart' as _i5;
import 'auth_guard.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter({
    _i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
        opaque: true,
      );
    },
    SignUpPageRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpPageRouteArgs>(
          orElse: () => const SignUpPageRouteArgs());
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.SignUpPage(key: args.key),
        opaque: true,
      );
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginPage(
          key: args.key,
          verificationID: args.verificationID,
        ),
        opaque: true,
      );
    },
    ChatScreenRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChatScreen(),
        opaque: true,
      );
    },
    CallPageRoute.name: (routeData) {
      final args = routeData.argsAs<CallPageRouteArgs>(
          orElse: () => const CallPageRouteArgs());
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.CallPage(
          key: args.key,
          channelName: args.channelName,
          role: args.role,
        ),
        opaque: true,
      );
    },
    ContactPageRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.ContactPage(),
        opaque: true,
      );
    },
    VerifyPageRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyPageRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.VerifyPage(
          key: args.key,
          verificationId: args.verificationId,
        ),
        opaque: true,
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
        ),
        _i8.RouteConfig(
          SignUpPageRoute.name,
          path: '/sign-up-page',
        ),
        _i8.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i8.RouteConfig(
          ChatScreenRoute.name,
          path: '/chat-screen',
        ),
        _i8.RouteConfig(
          CallPageRoute.name,
          path: '/call-page',
        ),
        _i8.RouteConfig(
          ContactPageRoute.name,
          path: '/contact-page',
        ),
        _i8.RouteConfig(
          VerifyPageRoute.name,
          path: '/verify-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i8.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i8.PageRouteInfo<SignUpPageRouteArgs> {
  SignUpPageRoute({_i9.Key? key})
      : super(
          SignUpPageRoute.name,
          path: '/sign-up-page',
          args: SignUpPageRouteArgs(key: key),
        );

  static const String name = 'SignUpPageRoute';
}

class SignUpPageRouteArgs {
  const SignUpPageRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SignUpPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.LoginPage]
class LoginPageRoute extends _i8.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({
    _i9.Key? key,
    required String verificationID,
  }) : super(
          LoginPageRoute.name,
          path: '/login-page',
          args: LoginPageRouteArgs(
            key: key,
            verificationID: verificationID,
          ),
        );

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({
    this.key,
    required this.verificationID,
  });

  final _i9.Key? key;

  final String verificationID;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, verificationID: $verificationID}';
  }
}

/// generated route for
/// [_i4.ChatScreen]
class ChatScreenRoute extends _i8.PageRouteInfo<void> {
  const ChatScreenRoute()
      : super(
          ChatScreenRoute.name,
          path: '/chat-screen',
        );

  static const String name = 'ChatScreenRoute';
}

/// generated route for
/// [_i5.CallPage]
class CallPageRoute extends _i8.PageRouteInfo<CallPageRouteArgs> {
  CallPageRoute({
    _i9.Key? key,
    String? channelName = 'ajay',
    _i11.ClientRole? role = _i11.ClientRole.Broadcaster,
  }) : super(
          CallPageRoute.name,
          path: '/call-page',
          args: CallPageRouteArgs(
            key: key,
            channelName: channelName,
            role: role,
          ),
        );

  static const String name = 'CallPageRoute';
}

class CallPageRouteArgs {
  const CallPageRouteArgs({
    this.key,
    this.channelName = 'ajay',
    this.role = _i11.ClientRole.Broadcaster,
  });

  final _i9.Key? key;

  final String? channelName;

  final _i11.ClientRole? role;

  @override
  String toString() {
    return 'CallPageRouteArgs{key: $key, channelName: $channelName, role: $role}';
  }
}

/// generated route for
/// [_i6.ContactPage]
class ContactPageRoute extends _i8.PageRouteInfo<void> {
  const ContactPageRoute()
      : super(
          ContactPageRoute.name,
          path: '/contact-page',
        );

  static const String name = 'ContactPageRoute';
}

/// generated route for
/// [_i7.VerifyPage]
class VerifyPageRoute extends _i8.PageRouteInfo<VerifyPageRouteArgs> {
  VerifyPageRoute({
    _i9.Key? key,
    required String verificationId,
  }) : super(
          VerifyPageRoute.name,
          path: '/verify-page',
          args: VerifyPageRouteArgs(
            key: key,
            verificationId: verificationId,
          ),
        );

  static const String name = 'VerifyPageRoute';
}

class VerifyPageRouteArgs {
  const VerifyPageRouteArgs({
    this.key,
    required this.verificationId,
  });

  final _i9.Key? key;

  final String verificationId;

  @override
  String toString() {
    return 'VerifyPageRouteArgs{key: $key, verificationId: $verificationId}';
  }
}
