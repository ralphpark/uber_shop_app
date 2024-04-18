
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSizeProvider = StateNotifierProvider<SelectedSizeNotifier, String>((ref) => SelectedSizeNotifier(''));

class SelectedSizeNotifier extends StateNotifier<String> {
  SelectedSizeNotifier(String state) : super(state);

  void setSelectedSize(String size) {
    state = size;
  }
}