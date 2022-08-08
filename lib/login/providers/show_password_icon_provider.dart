import 'package:flutter_riverpod/flutter_riverpod.dart';

final showPasswordIconProvider = StateNotifierProvider<ShowPasswordIconNotifier, bool>((ref) {
  return ShowPasswordIconNotifier();
});

class ShowPasswordIconNotifier extends StateNotifier<bool> {

  ShowPasswordIconNotifier() : super(false);

  void show(bool show) {
    state = show;
  }
}