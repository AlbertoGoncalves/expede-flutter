// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipments_schedule_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shipmentsScheduleVmHash() =>
    r'bb32fc93786701d1325a350438bd3ebf2b9d11fd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ShipmentsScheduleVm
    extends BuildlessAutoDisposeAsyncNotifier<List<ShipmentModel>> {
  late final int? id;
  late final int companyId;
  late final DateTime date;
  late final int? userId;

  FutureOr<List<ShipmentModel>> build(
    int? id,
    int companyId,
    DateTime date,
    int? userId,
  );
}

/// See also [ShipmentsScheduleVm].
@ProviderFor(ShipmentsScheduleVm)
const shipmentsScheduleVmProvider = ShipmentsScheduleVmFamily();

/// See also [ShipmentsScheduleVm].
class ShipmentsScheduleVmFamily
    extends Family<AsyncValue<List<ShipmentModel>>> {
  /// See also [ShipmentsScheduleVm].
  const ShipmentsScheduleVmFamily();

  /// See also [ShipmentsScheduleVm].
  ShipmentsScheduleVmProvider call(
    int? id,
    int companyId,
    DateTime date,
    int? userId,
  ) {
    return ShipmentsScheduleVmProvider(
      id,
      companyId,
      date,
      userId,
    );
  }

  @override
  ShipmentsScheduleVmProvider getProviderOverride(
    covariant ShipmentsScheduleVmProvider provider,
  ) {
    return call(
      provider.id,
      provider.companyId,
      provider.date,
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'shipmentsScheduleVmProvider';
}

/// See also [ShipmentsScheduleVm].
class ShipmentsScheduleVmProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ShipmentsScheduleVm, List<ShipmentModel>> {
  /// See also [ShipmentsScheduleVm].
  ShipmentsScheduleVmProvider(
    int? id,
    int companyId,
    DateTime date,
    int? userId,
  ) : this._internal(
          () => ShipmentsScheduleVm()
            ..id = id
            ..companyId = companyId
            ..date = date
            ..userId = userId,
          from: shipmentsScheduleVmProvider,
          name: r'shipmentsScheduleVmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shipmentsScheduleVmHash,
          dependencies: ShipmentsScheduleVmFamily._dependencies,
          allTransitiveDependencies:
              ShipmentsScheduleVmFamily._allTransitiveDependencies,
          id: id,
          companyId: companyId,
          date: date,
          userId: userId,
        );

  ShipmentsScheduleVmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.companyId,
    required this.date,
    required this.userId,
  }) : super.internal();

  final int? id;
  final int companyId;
  final DateTime date;
  final int? userId;

  @override
  FutureOr<List<ShipmentModel>> runNotifierBuild(
    covariant ShipmentsScheduleVm notifier,
  ) {
    return notifier.build(
      id,
      companyId,
      date,
      userId,
    );
  }

  @override
  Override overrideWith(ShipmentsScheduleVm Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShipmentsScheduleVmProvider._internal(
        () => create()
          ..id = id
          ..companyId = companyId
          ..date = date
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        companyId: companyId,
        date: date,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ShipmentsScheduleVm,
      List<ShipmentModel>> createElement() {
    return _ShipmentsScheduleVmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShipmentsScheduleVmProvider &&
        other.id == id &&
        other.companyId == companyId &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShipmentsScheduleVmRef
    on AutoDisposeAsyncNotifierProviderRef<List<ShipmentModel>> {
  /// The parameter `id` of this provider.
  int? get id;

  /// The parameter `companyId` of this provider.
  int get companyId;

  /// The parameter `date` of this provider.
  DateTime get date;

  /// The parameter `userId` of this provider.
  int? get userId;
}

class _ShipmentsScheduleVmProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ShipmentsScheduleVm,
        List<ShipmentModel>> with ShipmentsScheduleVmRef {
  _ShipmentsScheduleVmProviderElement(super.provider);

  @override
  int? get id => (origin as ShipmentsScheduleVmProvider).id;
  @override
  int get companyId => (origin as ShipmentsScheduleVmProvider).companyId;
  @override
  DateTime get date => (origin as ShipmentsScheduleVmProvider).date;
  @override
  int? get userId => (origin as ShipmentsScheduleVmProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
