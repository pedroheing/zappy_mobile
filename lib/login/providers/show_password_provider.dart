import 'package:flutter_riverpod/flutter_riverpod.dart';

final showPasswordProvider =
    StateNotifierProvider<ShowPasswordNotifier, bool>((ref) {
  return ShowPasswordNotifier();
});

class ShowPasswordNotifier extends StateNotifier<bool> {
  ShowPasswordNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  void show(bool show) {
    state = show;
  }
}
