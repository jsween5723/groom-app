import 'package:freezed_annotation/freezed_annotation.dart';

part 'groom_session.freezed.dart';

@freezed
class GroomSession with _$GroomSession {
  const GroomSession._();
  const factory GroomSession({
    required String accessToken,
    required String id,
    required String username,
    required Set<String> roles,
    required Set<String> authorities,
  }) = _GroomSession;
}
