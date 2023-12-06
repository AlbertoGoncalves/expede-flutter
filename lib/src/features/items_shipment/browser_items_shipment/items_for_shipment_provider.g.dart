// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_for_shipment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getItemsForShipmentHash() =>
    r'6dd59d91d60875f7a3b2bfcf9c5dd0e6e9c5fcbc';

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

/// See also [getItemsForShipment].
@ProviderFor(getItemsForShipment)
const getItemsForShipmentProvider = GetItemsForShipmentFamily();

/// See also [getItemsForShipment].
class GetItemsForShipmentFamily
    extends Family<AsyncValue<List<ItemShipmentModel>>> {
  /// See also [getItemsForShipment].
  const GetItemsForShipmentFamily();

  /// See also [getItemsForShipment].
  GetItemsForShipmentProvider call(
    int shipmentId,
  ) {
    return GetItemsForShipmentProvider(
      shipmentId,
    );
  }

  @override
  GetItemsForShipmentProvider getProviderOverride(
    covariant GetItemsForShipmentProvider provider,
  ) {
    return call(
      provider.shipmentId,
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
  String? get name => r'getItemsForShipmentProvider';
}

/// See also [getItemsForShipment].
class GetItemsForShipmentProvider
    extends AutoDisposeFutureProvider<List<ItemShipmentModel>> {
  /// See also [getItemsForShipment].
  GetItemsForShipmentProvider(
    int shipmentId,
  ) : this._internal(
          (ref) => getItemsForShipment(
            ref as GetItemsForShipmentRef,
            shipmentId,
          ),
          from: getItemsForShipmentProvider,
          name: r'getItemsForShipmentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getItemsForShipmentHash,
          dependencies: GetItemsForShipmentFamily._dependencies,
          allTransitiveDependencies:
              GetItemsForShipmentFamily._allTransitiveDependencies,
          shipmentId: shipmentId,
        );

  GetItemsForShipmentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.shipmentId,
  }) : super.internal();

  final int shipmentId;

  @override
  Override overrideWith(
    FutureOr<List<ItemShipmentModel>> Function(GetItemsForShipmentRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetItemsForShipmentProvider._internal(
        (ref) => create(ref as GetItemsForShipmentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        shipmentId: shipmentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ItemShipmentModel>> createElement() {
    return _GetItemsForShipmentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetItemsForShipmentProvider &&
        other.shipmentId == shipmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, shipmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetItemsForShipmentRef
    on AutoDisposeFutureProviderRef<List<ItemShipmentModel>> {
  /// The parameter `shipmentId` of this provider.
  int get shipmentId;
}

class _GetItemsForShipmentProviderElement
    extends AutoDisposeFutureProviderElement<List<ItemShipmentModel>>
    with GetItemsForShipmentRef {
  _GetItemsForShipmentProviderElement(super.provider);

  @override
  int get shipmentId => (origin as GetItemsForShipmentProvider).shipmentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
