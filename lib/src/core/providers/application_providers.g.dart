// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RestClientRef = ProviderRef<RestClient>;
String _$mqttRestClientHash() => r'1dbeccb82d86800fc1fedc9943b254206f4329f1';

/// See also [mqttRestClient].
@ProviderFor(mqttRestClient)
final mqttRestClientProvider = Provider<MqttRestClient>.internal(
  mqttRestClient,
  name: r'mqttRestClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mqttRestClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MqttRestClientRef = ProviderRef<MqttRestClient>;
String _$mqttRepositoryHash() => r'e88fdc5a8e29feadbfbf1f558a5d93051f0c4085';

/// See also [mqttRepository].
@ProviderFor(mqttRepository)
final mqttRepositoryProvider = Provider<DeviceRepository>.internal(
  mqttRepository,
  name: r'mqttRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mqttRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MqttRepositoryRef = ProviderRef<DeviceRepository>;
String _$userRepositoryHash() => r'4a324f69804b6738f220b7c48b19aad627021894';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = ProviderRef<UserRepository>;
String _$customerRepositoryHash() =>
    r'e9a5c4f843f939af1f89f53a6ca3868d58a66025';

/// See also [customerRepository].
@ProviderFor(customerRepository)
final customerRepositoryProvider = Provider<CustomerRepository>.internal(
  customerRepository,
  name: r'customerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomerRepositoryRef = ProviderRef<CustomerRepository>;
String _$shipmentRepositoryHash() =>
    r'6ccd00accdc1ef5e3717bb7a01bbd2b4af8888dc';

/// See also [shipmentRepository].
@ProviderFor(shipmentRepository)
final shipmentRepositoryProvider = Provider<ShipmentRepository>.internal(
  shipmentRepository,
  name: r'shipmentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shipmentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ShipmentRepositoryRef = ProviderRef<ShipmentRepository>;
String _$itemsShipmentRepositoryHash() =>
    r'351a059f9be6d5b388b7f8e413778614616ed84b';

/// See also [itemsShipmentRepository].
@ProviderFor(itemsShipmentRepository)
final itemsShipmentRepositoryProvider =
    Provider<ItemShipmentRepository>.internal(
  itemsShipmentRepository,
  name: r'itemsShipmentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemsShipmentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ItemsShipmentRepositoryRef = ProviderRef<ItemShipmentRepository>;
String _$userLoginServiceHash() => r'62431221aac8e45888e74928ecf0b5836e72b999';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<UserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserLoginServiceRef = ProviderRef<UserLoginService>;
String _$getMeHash() => r'835de91f459d1216fe7813de1ce4ffa8c28975d4';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMeRef = FutureProviderRef<UserModel>;
String _$companyRepositoryHash() => r'1521ec1fac30cc1424ddfd8a542126c42d2f1553';

/// See also [companyRepository].
@ProviderFor(companyRepository)
final companyRepositoryProvider = Provider<CompanyRepository>.internal(
  companyRepository,
  name: r'companyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompanyRepositoryRef = ProviderRef<CompanyRepository>;
String _$getMyCompanyHash() => r'ebb8ece39740793b1cfa0b8ab3209c82fb43b452';

/// See also [getMyCompany].
@ProviderFor(getMyCompany)
final getMyCompanyProvider = FutureProvider<CompanyModel>.internal(
  getMyCompany,
  name: r'getMyCompanyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMyCompanyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyCompanyRef = FutureProviderRef<CompanyModel>;
String _$logoutHash() => r'621fd7df4ad20c4727471a25a8da820fba0a7d5a';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
