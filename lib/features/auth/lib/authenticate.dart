import 'package:groom/shared/config/di_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _supabase = getIt<SupabaseClient>();

Future<Session> sendOtp(String phoneNumber) async {
  await _supabase.auth.signInWithOtp(phone: phoneNumber);
}

Future<bool> verifyOtp(String phoneNumber, String otp) async {
  final res = await _supabase.auth.verifyOTP(
    phone: phoneNumber,
    token: otp,
    type: OtpType.sms,
  );
}
