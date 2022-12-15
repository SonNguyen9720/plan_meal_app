import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final FirebaseFireStoreRepository firebaseFireStoreRepository;
  final UserRepository userRepository;

  AvatarBloc(
      {required this.firebaseFireStoreRepository, required this.userRepository})
      : super(AvatarInitial()) {
    on<AvatarPickFromCameraEvent>(onAvatarPickFromCameraEvent);
  }

  void onAvatarPickFromCameraEvent(
      AvatarPickFromCameraEvent event, Emitter<AvatarState> emit) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    String result = '';
    if (pickedFile != null) {
      emit(AvatarWaiting());
      result = await firebaseFireStoreRepository.uploadAvatar(pickedFile);
    }
  }
}
