import 'package:bloc/bloc.dart';

class CheckBoxCubit extends Cubit<Map<String, bool>> {
  CheckBoxCubit(Map<String, bool> initialValues) : super(Map<String, bool>.from(initialValues));

  void toggle(String key) {
    final current = state[key] ?? false;
    emit({...state, key: !current});
  }
  void reset(String key) {
    state[key] = false;
    emit(Map<String, bool>.from(state));
  }
  void resetAll() {
    state.keys.forEach((key) {
      state[key] = false;
    });
    emit(Map<String, bool>.from(state));
  }
  void setValue(String key, bool value) {
    emit({...state, key: value});
  }
  bool getValue(String key) {
    return state[key] ?? false; // Returns false if the key does not exist
  }
}
