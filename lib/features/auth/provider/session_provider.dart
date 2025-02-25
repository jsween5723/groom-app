import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'session_provider.g.dart';

@riverpod
class Session extends _$Session {
  String accessToken;
  String refreshToken;
  late String uid;
  late String role;

  @override
  build() {
    return;
  }
}
