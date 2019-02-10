import 'package:mobile_intranet/components/services/restclient.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
