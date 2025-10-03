import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryPageIndex extends StateNotifier<int> {
  PrimaryPageIndex() : super(1);

  setIndex(int index) {
    state = index;
  }
}

final primaryPageIndexProvider =
    StateNotifierProvider.autoDispose<PrimaryPageIndex, int>((ref) {
  return PrimaryPageIndex();
});
