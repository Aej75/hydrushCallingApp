import 'package:auto_route/auto_route.dart';
import 'package:whatsapp/core/route/auth_guard.dart';
import 'package:whatsapp/features/auth/login/presentation/pages/loginPage.dart';
import 'package:whatsapp/features/auth/signup/presentation/pages/signup_page.dart';
import 'package:whatsapp/features/auth/verify/presentation/pages/verify_page.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/contact_page.dart';

import '../../features/dashboard/presentation/pages/chat_screen.dart';
import '../../features/dashboard/presentation/pages/homepage.dart';
import '../../features/videoCall/presentation/pages/callPage.dart';

@AdaptiveAutoRouter(
  preferRelativeImports: true,
  routes: [
    AdaptiveRoute(page: HomePage, guards: [AuthGuard], initial: true),
    AdaptiveRoute(page: SignUpPage),
    AdaptiveRoute(page: LoginPage),
    AdaptiveRoute(page: ChatScreen),
    AdaptiveRoute(page: CallPage),
    AdaptiveRoute(page: ContactPage),
    AdaptiveRoute(page: VerifyPage)
  ],
)
// extend the generated private router
class $AppRouter {}
