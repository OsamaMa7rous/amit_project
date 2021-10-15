import 'package:amit_project/model/products_model.dart';
import 'package:equatable/equatable.dart';

abstract class States {}

class CounterInitialStates extends States {}

class CounterMinusStates extends States {}

class CounterPlusStates extends States {}

class ClearCartStates extends States {}

class AddTOCartStates extends States {}

class DeleteProductStates extends States {}

class CurrentIndexStates extends States {}
