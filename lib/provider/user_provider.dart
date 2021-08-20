import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/user.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final userProvider = StreamProvider.autoDispose ((ref) {
  final user = ref.watch(userRepositoryProvider);
  return user.getCurrentUser();
});