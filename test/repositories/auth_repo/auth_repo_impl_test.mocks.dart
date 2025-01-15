// Mocks generated by Mockito 5.4.4 from annotations
// in task_manager_app/test/repositories/auth_repo/auth_repo_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_manager_app/core/networks/remote/dio_helper.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DioHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioHelper extends _i1.Mock implements _i2.DioHelper {
  MockDioHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  dynamic getData({
    required String? url,
    String? lang,
    dynamic query,
    bool? sendToken = false,
    dynamic data,
  }) =>
      super.noSuchMethod(Invocation.method(
        #getData,
        [],
        {
          #url: url,
          #lang: lang,
          #query: query,
          #sendToken: sendToken,
          #data: data,
        },
      ));

  @override
  dynamic postData({
    required String? url,
    String? lang,
    dynamic query,
    dynamic data,
    bool? sendToken = false,
    dynamic cancelToken,
  }) =>
      super.noSuchMethod(Invocation.method(
        #postData,
        [],
        {
          #url: url,
          #lang: lang,
          #query: query,
          #data: data,
          #sendToken: sendToken,
          #cancelToken: cancelToken,
        },
      ));

  @override
  dynamic patchData({
    required String? url,
    dynamic query,
    dynamic data,
    bool? sendToken = false,
  }) =>
      super.noSuchMethod(Invocation.method(
        #patchData,
        [],
        {
          #url: url,
          #query: query,
          #data: data,
          #sendToken: sendToken,
        },
      ));

  @override
  dynamic deleteData({
    required String? url,
    String? lang,
    dynamic query,
    dynamic data,
    bool? sendToken = false,
  }) =>
      super.noSuchMethod(Invocation.method(
        #deleteData,
        [],
        {
          #url: url,
          #lang: lang,
          #query: query,
          #data: data,
          #sendToken: sendToken,
        },
      ));

  @override
  dynamic putData({
    required String? url,
    String? lang,
    dynamic query,
    required dynamic data,
    bool? sendToken = false,
  }) =>
      super.noSuchMethod(Invocation.method(
        #putData,
        [],
        {
          #url: url,
          #lang: lang,
          #query: query,
          #data: data,
          #sendToken: sendToken,
        },
      ));
}
