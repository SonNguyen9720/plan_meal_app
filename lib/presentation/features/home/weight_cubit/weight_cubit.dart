import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/weight.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/weight_entity.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  final UserRepository userRepository;

  WeightCubit({required this.userRepository}) : super(const WeightInitial());

  Future<void> loadWeight(DateTime startDate, DateTime endDate) async {
    String formattedStartDate = DateTimeUtils.parseDateTime(startDate);
    String formattedEndDate = DateTimeUtils.parseDateTime(endDate);
    List<Weight> weightList = await userRepository.getListWeight(
        formattedStartDate, formattedEndDate);
    List<WeightEntity> weightEntityList = [];
    DateTime weekendDay4 = DateTimeUtils.getWeekendDate(endDate);
    DateTime weekendDay3 = weekendDay4.subtract(const Duration(days: 7));
    DateTime weekendDay2 = weekendDay3.subtract(const Duration(days: 7));
    DateTime weekendDay1 = weekendDay2.subtract(const Duration(days: 7));
    if (weightList.isNotEmpty) {
      for (var weight in weightList) {
        DateTime dateTime = DateTime.parse(weight.createdAt!);
        WeightEntity weightEntity =
            WeightEntity(date: dateTime, weight: weight.value!);
        weightEntityList.add(weightEntity);
      }
      WeightEntity? weightEntity1;
      WeightEntity? weightEntity2;
      WeightEntity? weightEntity3;
      WeightEntity? weightEntity4;
      for (var weightEntity in weightEntityList) {
        if (weightEntity.date.isBefore(weekendDay1)) {
          weightEntity1 = weightEntity;
        } else if (weightEntity.date.isAfter(weekendDay1) && weightEntity.date.isBefore(weekendDay2)) {
          weightEntity2 = weightEntity;
        } else if (weightEntity.date.isAfter(weekendDay2) && weightEntity.date.isBefore(weekendDay3)) {
          weightEntity3 = weightEntity;
        }  else if (weightEntity.date.isAfter(weekendDay3) && weightEntity.date.isBefore(weekendDay4)) {
          weightEntity4 = weightEntity;
        }
      }
      List<WeightEntity> newWeightEntityList = [];
      if (weightEntity1 != null) {
        newWeightEntityList.add(weightEntity1);
      }
      if (weightEntity2 != null) {
        newWeightEntityList.add(weightEntity2);
      }
      if (weightEntity3 != null) {
        newWeightEntityList.add(weightEntity3);
      }
      if (weightEntity4 != null) {
        newWeightEntityList.add(weightEntity4);
      }
      emit(WeightInitial(weightList: newWeightEntityList));
    }
  }
}
