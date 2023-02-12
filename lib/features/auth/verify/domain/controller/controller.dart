import '../repo/repo.dart';

abstract class IAddToFirestore {
  Future<bool> addPhoneNumber(final String phoneNumber);
}

class AddToFirestoreController implements IAddToFirestore {
  final Repository repository;

  AddToFirestoreController(this.repository);
  @override
  Future<bool> addPhoneNumber(String phoneNumber) async {
    var response = repository.addPhoneNumber(phoneNumber);

    return response;
  }
}
