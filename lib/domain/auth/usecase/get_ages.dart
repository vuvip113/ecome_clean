import 'package:ecome_clean/core/usecase/usecase.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';

class GetAges implements UsecaseWithoutParams<List<String>> {
  const GetAges(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<List<String>> call() async {
    return await _repo.getAges();
  }
}
