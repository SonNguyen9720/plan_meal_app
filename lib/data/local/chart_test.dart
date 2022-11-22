import 'dart:math';
import 'package:collection/collection.dart';

class WeightPoint {
  final double x;
  final double y;

  WeightPoint({required this.x, required this.y});
}

List<WeightPoint> get weightPoint {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 1; i <= 4; i++) {
    randomNumbers.add(random.nextDouble());
  }

  return randomNumbers.mapIndexed(
      (index, element) => WeightPoint(x: index.toDouble(), y: element)
  ).toList();
}