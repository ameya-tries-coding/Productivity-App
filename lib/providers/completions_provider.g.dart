// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyCompletionsHash() => r'8e63932028c1cba99c8c3bd25f934d758e1f08f2';

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

abstract class _$DailyCompletions
    extends BuildlessAutoDisposeAsyncNotifier<List<TaskCompletion>> {
  late final DateTime date;

  FutureOr<List<TaskCompletion>> build(
    DateTime date,
  );
}

/// See also [DailyCompletions].
@ProviderFor(DailyCompletions)
const dailyCompletionsProvider = DailyCompletionsFamily();

/// See also [DailyCompletions].
class DailyCompletionsFamily extends Family<AsyncValue<List<TaskCompletion>>> {
  /// See also [DailyCompletions].
  const DailyCompletionsFamily();

  /// See also [DailyCompletions].
  DailyCompletionsProvider call(
    DateTime date,
  ) {
    return DailyCompletionsProvider(
      date,
    );
  }

  @override
  DailyCompletionsProvider getProviderOverride(
    covariant DailyCompletionsProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'dailyCompletionsProvider';
}

/// See also [DailyCompletions].
class DailyCompletionsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DailyCompletions, List<TaskCompletion>> {
  /// See also [DailyCompletions].
  DailyCompletionsProvider(
    DateTime date,
  ) : this._internal(
          () => DailyCompletions()..date = date,
          from: dailyCompletionsProvider,
          name: r'dailyCompletionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyCompletionsHash,
          dependencies: DailyCompletionsFamily._dependencies,
          allTransitiveDependencies:
              DailyCompletionsFamily._allTransitiveDependencies,
          date: date,
        );

  DailyCompletionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  FutureOr<List<TaskCompletion>> runNotifierBuild(
    covariant DailyCompletions notifier,
  ) {
    return notifier.build(
      date,
    );
  }

  @override
  Override overrideWith(DailyCompletions Function() create) {
    return ProviderOverride(
      origin: this,
      override: DailyCompletionsProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DailyCompletions,
      List<TaskCompletion>> createElement() {
    return _DailyCompletionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyCompletionsProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DailyCompletionsRef
    on AutoDisposeAsyncNotifierProviderRef<List<TaskCompletion>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _DailyCompletionsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DailyCompletions,
        List<TaskCompletion>> with DailyCompletionsRef {
  _DailyCompletionsProviderElement(super.provider);

  @override
  DateTime get date => (origin as DailyCompletionsProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
