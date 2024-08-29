import 'package:flutter/foundation.dart';

@immutable
abstract class LoginEvent {}

class UpdateLoadingState extends LoginEvent {
  final bool isLoading;

  UpdateLoadingState({required this.isLoading});
}