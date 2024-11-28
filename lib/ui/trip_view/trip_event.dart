import 'package:flutter/foundation.dart';

@immutable
abstract class TripEvent {}

class UpdateLoadingState extends TripEvent {
  final bool isLoading;

  UpdateLoadingState({required this.isLoading});
}