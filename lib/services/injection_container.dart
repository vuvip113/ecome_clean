import 'package:ecome_clean/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:ecome_clean/data/auth/source/auth_data_source.dart';
import 'package:ecome_clean/data/category/repo_impl/category_repo_impl.dart';
import 'package:ecome_clean/data/category/source/category_data_source.dart';
import 'package:ecome_clean/domain/auth/repo/auth_repo.dart';
import 'package:ecome_clean/domain/auth/usecase/get_ages.dart';
import 'package:ecome_clean/domain/auth/usecase/get_user_usecase.dart';
import 'package:ecome_clean/domain/auth/usecase/is_logged_in.dart';
import 'package:ecome_clean/domain/auth/usecase/reset_pass_usecase.dart';
import 'package:ecome_clean/domain/auth/usecase/sign_in_usecase.dart';
import 'package:ecome_clean/domain/auth/usecase/sign_up_usecase.dart';
import 'package:ecome_clean/domain/category/repo/category_repo.dart';
import 'package:ecome_clean/domain/category/usecase/get_category_usecase.dart';
import 'package:get_it/get_it.dart';

part 'injection_container.main.dart';
