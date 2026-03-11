// auth_remote_data_source.dart
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final DioClient client;
  AuthRemoteDataSource(this.client);

  Future<UserModel> login(String username, String password) async {
    final response = await client.post(
      ApiConstants.login,
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 30,
      },
    );

    return UserModel.fromJson(response.data);
  }
}