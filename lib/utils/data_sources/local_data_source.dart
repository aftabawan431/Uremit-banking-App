import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDataSource {}

class LocalDataSourceImp implements LocalDataSource {
  LocalDataSourceImp({required this.flutterSecureStorage});
  final FlutterSecureStorage flutterSecureStorage;
}
