import 'dart:async';

import 'package:mobile_intranet/components/model/login.dart';
import 'package:mobile_intranet/components/model/otp.dart';
import 'package:mobile_intranet/components/services/network_service_response.dart';

abstract class IOTPService {
  Future<NetworkServiceResponse<CreateOTPResponse>> createOTP(
      String phoneNumber);
  Future<NetworkServiceResponse<OTPResponse>> fetchOTPLoginResponse(
      Login userLogin);
}
