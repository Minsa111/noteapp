import 'package:get/get.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:noteapp/controller/appwritecontroller.dart'; // Replace with the actual import path
import 'package:appwrite/appwrite.dart'


@GenerateMocks([Account])
void main() {
  /// Setup dependencies for the repo
  late MockAccount _mockAccount;
  late AuthRepositoryImpl _repository;
  
  setUp((){
    _mockAccount = MockAccount();
    _repository = AuthRepositoryImpl(_mockAccount);
  });
  
  /// Login
  test('should return session object when login successful', () async {
    /// ARRANGE
    when(_mockAccount.createSession(
      email: 'aditya@mail.com',
      password: '_testAccount1',
    )).thenAnswer((_) async => testSessionObj);
    
    /// ACT
    final _result = await _repository.login(
      email: 'aditya@mail.com', password: '_testAccount1');

    /// ASSERT
    verify(_mockAccount.createSession(
      email: 'aditya@mail.com', password: '_testAccount1'));
    expect(_result, equals(Right(testSessionObj)));
  });
}