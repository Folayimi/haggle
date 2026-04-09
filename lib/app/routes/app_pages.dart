import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/forgot_password_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/signup_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/negotiation_room/bindings/negotiation_room_binding.dart';
import '../modules/negotiation_room/views/negotiation_room_view.dart';
import '../modules/messages/views/conversation_view.dart';
import '../modules/reminders/views/reminders_view.dart';
import '../modules/seller_profile/views/seller_profile_view.dart';
import '../modules/create/views/add_service_view.dart';
import '../modules/create/views/post_product_view.dart';
import '../modules/create/views/room_styling_view.dart';
import '../modules/create/views/schedule_live_view.dart';
import '../modules/market/views/product_detail_view.dart';
import '../modules/market/views/market_search_view.dart';
import '../modules/market/views/service_detail_view.dart';
import '../modules/profile/views/edit_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: _Paths.NEGOTIATION_ROOM,
      page: () => NegotiationRoomView(),
      binding: NegotiationRoomBinding(),
    ),
    GetPage(
      name: _Paths.SELLER_PROFILE,
      page: () => const SellerProfileView(),
    ),
    GetPage(
      name: _Paths.REMINDERS,
      page: () => const RemindersView(),
    ),
    GetPage(
      name: _Paths.CONVERSATION,
      page: () => const ConversationView(),
    ),
    GetPage(
      name: _Paths.POST_PRODUCT,
      page: () => const PostProductView(),
    ),
    GetPage(
      name: _Paths.ADD_SERVICE,
      page: () => const AddServiceView(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_LIVE,
      page: () => const ScheduleLiveView(),
    ),
    GetPage(
      name: _Paths.ROOM_STYLING,
      page: () => const RoomStylingView(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
    ),
    GetPage(
      name: _Paths.SERVICE_DETAIL,
      page: () => const ServiceDetailView(),
    ),
    GetPage(
      name: _Paths.MARKET_SEARCH,
      page: () => const MarketSearchView(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
    ),
  ];
}
