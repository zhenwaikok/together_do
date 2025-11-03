import 'package:mpma_assignment/constant/images.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/repository/firebase_repository.dart';
import 'package:mpma_assignment/repository/home_tips_repository.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/services/chore_services.dart';
import 'package:mpma_assignment/services/firebase_services.dart';
import 'package:mpma_assignment/services/home_tips_services.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/view/onboarding_screen.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/firebase_view_model.dart';
import 'package:mpma_assignment/viewmodel/home_screen_view_model.dart';
import 'package:mpma_assignment/viewmodel/home_tips_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_member_details_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

enum HttpMethod { get, post, put, delete }

class EnvValues {
  EnvValues._();

  static const youtubeApiKey = String.fromEnvironment('youtube_api_key');
  static const youtubeHostUrl = String.fromEnvironment('youtube_host_url');
}

List<SingleChildWidget> providerAssets() => [
  ChangeNotifierProvider.value(
    value: UserViewModel(
      userRepository: UserRepository(
        sharedPreferenceHandler: SharedPreferenceHandler(),
        userServices: UserServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: HomeTipsViewModel(
      homeTipsRepository: HomeTipsRepository(
        homeTipsServices: HomeTipsServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: SpaceViewModel(
      spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
    ),
  ),
  ChangeNotifierProvider.value(
    value: FirebaseViewModel(
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: ChoreViewModel(
      choreRepository: ChoreRepository(choreServices: ChoreServices()),
    ),
  ),
  ChangeNotifierProvider.value(
    value: SpaceMemberDetailsViewModel(
      userRepository: UserRepository(
        sharedPreferenceHandler: SharedPreferenceHandler(),
        userServices: UserServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: HomeScreenViewModel(
      choreRepository: ChoreRepository(choreServices: ChoreServices()),
      spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
    ),
  ),
];

class OnboardData {
  OnboardData._();

  static final List<OnBoard> onboardData = [
    OnBoard(
      image: Images.onboard1,
      title: 'Stay Organized Together',
      description:
          'Keep track of all household chores in one place. Everyone knows what to do and when to do it.',
    ),
    OnBoard(
      image: Images.onboard2,
      title: 'Assign & Share Tasks',
      description:
          'Easily assign chores to family members so responsibilities are clear and fair.',
    ),
    OnBoard(
      image: Images.onboard3,
      title: 'Celebrate Progress',
      description:
          'Mark chores as done, track progress, and celebrate your family’s teamwork.',
    ),
  ];
}

class DropDownItems {
  DropDownItems._();

  static const List<String> genders = ['Male', 'Female'];
}

class DBCollectionName {
  DBCollectionName._();

  static const user = 'user';
  static const space = 'space';
  static const chore = 'chore';
}

class StorageRefName {
  StorageRefName._();

  static const userPhoto = 'UserPhoto';
  static const spacePhoto = 'SpacePhoto';
  static const chorePhoto = 'ChorePhoto';
}

class Chars {
  Chars._();

  static const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
}

class FilterItems {
  FilterItems._();

  static const List<String> taskFilterItems = [
    'All Tasks',
    'Pending',
    'In Progress',
    'Completed',
  ];
}

class Constant {
  Constant._();

  static const int maxMediaSelectionLimit = 5;
}
