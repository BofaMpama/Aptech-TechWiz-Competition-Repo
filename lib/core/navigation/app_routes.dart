import 'package:flutter/cupertino.dart';
import '../../modules/auth/pet_owner_profile/pet_owner_view.dart';
import '../../modules/auth/signup/view/signin_screen.dart';
import '../../modules/auth/veterinarian/veterinarian_view.dart';
import '../../modules/shelter_admin/shelter_admin_view.dart';
import '../../modules/splashscreen/view/splashscreen.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.route:
      return CupertinoPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );

    case SignupScreen.route:
      return CupertinoPageRoute(
        builder: (_) => const SignupScreen(),
        settings: settings,
      );

    case PetOwnerProfileScreen.route:
      return CupertinoPageRoute(
        builder: (_) => const PetOwnerProfileScreen(),
        settings: settings,
      );

    case VeterinarianProfileScreen.route:
      return CupertinoPageRoute(
        builder: (_) => const VeterinarianProfileScreen(),
        settings: settings,
      );

    case ShelterAdminProfileScreen.route:
      return CupertinoPageRoute(
        builder: (_) => const ShelterAdminProfileScreen(),
        settings: settings,
      );

    // case HomeScreen.route:
    //   return CupertinoPageRoute(
    //     builder: (_) => const HomeScreen(),
    //     settings: settings,
    //   );

  // Add Pet Sitter Profile when you create it
  // case PetSitterProfileScreen.route:
  //   return CupertinoPageRoute(
  //     builder: (_) => const PetSitterProfileScreen(),
  //     settings: settings,
  //   );

    default:
      return null;
  }
}