import 'package:hiring_task/view/direction_mark_screen.dart';
import 'package:hiring_task/view/screens/custom_and_border_check_screen.dart';
import 'package:hiring_task/view/screens/grids/custom_&_border_grid.dart';
import 'package:hiring_task/view/screens/grids/logistic_info_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/package_composition_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/product_contents_grid_screen.dart';
import 'package:hiring_task/view/screens/grids/product_safety_grid.dart';
import 'package:hiring_task/view/screens/grids/recipe_grid_screen.dart';
import 'package:hiring_task/view/screens/home/home_screen.dart';
import 'package:hiring_task/view/screens/ingredients_and_allergens_scree.dart';
import 'package:hiring_task/view/screens/log-in/after-login/create_ticket_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/dashboard/dashboard.dart';
import 'package:hiring_task/view/screens/log-in/after-login/help_desk_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/member_gln_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/member_profile_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/products.dart';
import 'package:hiring_task/view/screens/log-in/after-login/sscc_screen.dart';
import 'package:hiring_task/view/screens/log-in/after-login/subscribe_products_screen.dart';
import 'package:hiring_task/view/screens/log-in/gs1_member_login_screen.dart';
import 'package:hiring_task/view/screens/log-in/otp_screen.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_one.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_three.dart';
import 'package:hiring_task/view/screens/log-in/reset-password/reset_screen_two.dart';
import 'package:hiring_task/view/screens/log-in/select_activity_and_password_screen.dart';
import 'package:hiring_task/view/screens/logistic_information_screen.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/view/screens/member-screens/memeber_registration_screen.dart';
import 'package:hiring_task/view/screens/offers_nearMe_screen.dart';
import 'package:hiring_task/view/screens/packaging_composition_screen.dart';
import 'package:hiring_task/view/screens/product-tracking/gtin_reporter_screen.dart';
import 'package:hiring_task/view/screens/promotional_offers_screen.dart';
import 'package:hiring_task/view/screens/qr_code_scanning_screen.dart';
import 'package:hiring_task/view/screens/recipe_screen.dart';
import 'package:hiring_task/view/screens/regulatory_affairs_screen.dart';
import 'package:hiring_task/view/screens/retail_information_screen.dart';
import 'package:hiring_task/view/screens/retailor_shopper_screen.dart';
import 'package:hiring_task/view/screens/safety_information_screen.dart';
import 'package:hiring_task/view/screens/single_event_screen.dart';
import 'package:hiring_task/view/screens/verified-by-gs1/verify_by_gs1_screen.dart';

class RoutesManagement {
  static getRoutes() {
    return {
      "/": (context) => const HomeScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      Gs1MemberLoginScreen.routeName: (context) => const Gs1MemberLoginScreen(),
      QRCodeScanningScreen.routeName: (context) => const QRCodeScanningScreen(),
      RetailorShopperScreen.routeName: (context) => RetailorShopperScreen(),
      ProductContentsGridScreen.routeName: (context) =>
          const ProductContentsGridScreen(),
      IngredientsAndAllergensScreen.routeName: (context) =>
          const IngredientsAndAllergensScreen(),
      RecipeGridScreen.routeName: (context) => const RecipeGridScreen(),
      RecipeScreen.routeName: (context) => const RecipeScreen(),
      LogisticInfoGridScreen.routeName: (context) =>
          const LogisticInfoGridScreen(),
      LogisticInformationScreen.routeName: (context) =>
          const LogisticInformationScreen(),
      RetailInformationScreen.routeName: (context) =>
          const RetailInformationScreen(),
      VerifyByGS1Screen.routeName: (context) => const VerifyByGS1Screen(),
      RegulatoryAffairsScreen.routeName: (context) =>
          const RegulatoryAffairsScreen(),
      ProductSafetyGrid.routeName: (context) => const ProductSafetyGrid(),
      SafetyInformationScreen.routeName: (context) =>
          const SafetyInformationScreen(),
      PromotionalOffersScreen.routeName: (context) => PromotionalOffersScreen(),
      PackagingCompositionScreen.routeName: (context) =>
          const PackagingCompositionScreen(),
      PackageCompositionGridScreen.routeName: (context) =>
          const PackageCompositionGridScreen(),
      CustomAndBorderGridScreen.routeName: (context) =>
          const CustomAndBorderGridScreen(),
      CustomAndBorderCheckScreen.routeName: (context) =>
          const CustomAndBorderCheckScreen(),
      GetBarcodeScreen.routeName: (context) => const GetBarcodeScreen(),
      GtinReporterScreen.routeName: (context) => GtinReporterScreen(),
      OffersNearMeScreen.routeName: (context) => const OffersNearMeScreen(),
      SingleEventScreen.routeName: (context) => const SingleEventScreen(),
      DirectionMarkScreen.routeName: (context) => const DirectionMarkScreen(),
      MemberRegistrationScreen.routeName: (context) =>
          const MemberRegistrationScreen(),
      SelectActivityAndPasswordScreen.routeName: (context) =>
          const SelectActivityAndPasswordScreen(),
      // after login screens
      Dashboard.routeName: (context) => const Dashboard(),
      OTPScreen.routeName: (context) => const OTPScreen(),
      Products.routeName: (context) => const Products(),
      MemberGLNScreen.routeName: (context) => const MemberGLNScreen(),
      SSCCScreen.routeName: (context) => const SSCCScreen(),
      HelpDeskScreen.routeName: (context) => const HelpDeskScreen(),
      CreateTicketScreen.routeName: (context) => const CreateTicketScreen(),
      MemberProfileScreen.routeName: (context) => const MemberProfileScreen(),
      SubscribeProductsScreen.routeName: (context) =>
          const SubscribeProductsScreen(),
      // RenewMembershipScreen.routeName: (context) =>
      //     const RenewMembershipScreen(),
      ResetScreenOne.routeName: (context) => const ResetScreenOne(),
      ResetScreenTwo.routeName: (context) => const ResetScreenTwo(),
      ResetScreenThree.routeName: (context) => const ResetScreenThree(),
    };
  }
}
