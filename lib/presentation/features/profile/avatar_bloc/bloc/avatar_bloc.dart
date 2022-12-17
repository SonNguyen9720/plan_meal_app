import 'package:age_calculator/age_calculator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/config/global_variable.dart';
import 'package:plan_meal_app/config/storage.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/entities/user_information_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/user_utils.dart';

part 'avatar_event.dart';

part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final FirebaseFireStoreRepository firebaseFireStoreRepository;
  final UserRepository userRepository;

  AvatarBloc(
      {required this.firebaseFireStoreRepository, required this.userRepository})
      : super(AvatarInitial(
            imageUrl:
                PreferenceUtils.getString(GlobalVariable.imageUrl) ?? "")) {
    on<AvatarPickFromCameraEvent>(onAvatarPickFromCameraEvent);
  }

  void onAvatarPickFromCameraEvent(
      AvatarPickFromCameraEvent event, Emitter<AvatarState> emit) async {
    try {
      String result = '';
      if (event.xFile != null) {
        emit(AvatarWaiting());
        result = await firebaseFireStoreRepository.uploadAvatar(event.xFile!);
      }
      UserInformationEntity userInfo = UserUtils.getUserInformation();
      var updatedUser = userInfo.copyWith(imageUrl: result);
      var token = await Storage().secureStorage.read(key: 'access_token') ?? '';
      String statusCode = await userRepository.updateUserProfile(
          firstName: updatedUser.firstName,
          lastName: updatedUser.lastName,
          sex: updatedUser.sex,
          dob: updatedUser.dob,
          height: updatedUser.height,
          weight: updatedUser.weight,
          imageUrl: updatedUser.imageUrl,
          healthGoal: updatedUser.healthGoal,
          desiredWeight: updatedUser.desiredWeight,
          activityIntensity: updatedUser.activityIntensity,
          token: token);
      await PreferenceUtils.setString(GlobalVariable.imageUrl, result);
      emit(AvatarFinished());
      emit(AvatarInitial(imageUrl: result));
    } on Exception catch (exception) {
      emit(AvatarError(errorMessage: exception.toString()));
    }
  }
}
