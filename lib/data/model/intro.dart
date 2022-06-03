import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Intro extends Equatable {
  final NetworkImage image;
  final String introTitle;
  final String desc;

  const Intro(this.introTitle, this.desc, this.image);

  @override
  List<Object?> get props => [image, introTitle, desc];
}
