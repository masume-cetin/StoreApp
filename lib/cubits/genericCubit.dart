import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/states/genericStates.dart';

class ApiCubit<T> extends Cubit<ApiState<T>> {
  ApiCubit() : super(ApiInitial());

  Future<void> request(Future<T> Function() apiCall) async {
    emit(ApiLoading());
    try {
      final response = await apiCall();
      emit(ApiSuccess(response));
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}

