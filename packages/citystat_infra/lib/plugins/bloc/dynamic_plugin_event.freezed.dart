// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_plugin_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DynamicPluginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicPluginEventCopyWith<$Res> {
  factory $DynamicPluginEventCopyWith(
          DynamicPluginEvent value, $Res Function(DynamicPluginEvent) then) =
      _$DynamicPluginEventCopyWithImpl<$Res, DynamicPluginEvent>;
}

/// @nodoc
class _$DynamicPluginEventCopyWithImpl<$Res, $Val extends DynamicPluginEvent>
    implements $DynamicPluginEventCopyWith<$Res> {
  _$DynamicPluginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddPluginImplCopyWith<$Res> {
  factory _$$AddPluginImplCopyWith(
          _$AddPluginImpl value, $Res Function(_$AddPluginImpl) then) =
      __$$AddPluginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddPluginImplCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$AddPluginImpl>
    implements _$$AddPluginImplCopyWith<$Res> {
  __$$AddPluginImplCopyWithImpl(
      _$AddPluginImpl _value, $Res Function(_$AddPluginImpl) _then)
      : super(_value, _then);

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddPluginImpl implements _AddPlugin {
  _$AddPluginImpl();

  @override
  String toString() {
    return 'DynamicPluginEvent.addPlugin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddPluginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return addPlugin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return addPlugin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (addPlugin != null) {
      return addPlugin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return addPlugin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return addPlugin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (addPlugin != null) {
      return addPlugin(this);
    }
    return orElse();
  }
}

abstract class _AddPlugin implements DynamicPluginEvent {
  factory _AddPlugin() = _$AddPluginImpl;
}

/// @nodoc
abstract class _$$RemovePluginImplCopyWith<$Res> {
  factory _$$RemovePluginImplCopyWith(
          _$RemovePluginImpl value, $Res Function(_$RemovePluginImpl) then) =
      __$$RemovePluginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$RemovePluginImplCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$RemovePluginImpl>
    implements _$$RemovePluginImplCopyWith<$Res> {
  __$$RemovePluginImplCopyWithImpl(
      _$RemovePluginImpl _value, $Res Function(_$RemovePluginImpl) _then)
      : super(_value, _then);

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$RemovePluginImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemovePluginImpl implements _RemovePlugin {
  _$RemovePluginImpl({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'DynamicPluginEvent.removePlugin(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemovePluginImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemovePluginImplCopyWith<_$RemovePluginImpl> get copyWith =>
      __$$RemovePluginImplCopyWithImpl<_$RemovePluginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return removePlugin(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return removePlugin?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (removePlugin != null) {
      return removePlugin(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return removePlugin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return removePlugin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (removePlugin != null) {
      return removePlugin(this);
    }
    return orElse();
  }
}

abstract class _RemovePlugin implements DynamicPluginEvent {
  factory _RemovePlugin({required final String name}) = _$RemovePluginImpl;

  String get name;

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemovePluginImplCopyWith<_$RemovePluginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$DynamicPluginEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of DynamicPluginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadImpl implements _Load {
  _$LoadImpl();

  @override
  String toString() {
    return 'DynamicPluginEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() addPlugin,
    required TResult Function(String name) removePlugin,
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? addPlugin,
    TResult? Function(String name)? removePlugin,
    TResult? Function()? load,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? addPlugin,
    TResult Function(String name)? removePlugin,
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddPlugin value) addPlugin,
    required TResult Function(_RemovePlugin value) removePlugin,
    required TResult Function(_Load value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddPlugin value)? addPlugin,
    TResult? Function(_RemovePlugin value)? removePlugin,
    TResult? Function(_Load value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddPlugin value)? addPlugin,
    TResult Function(_RemovePlugin value)? removePlugin,
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements DynamicPluginEvent {
  factory _Load() = _$LoadImpl;
}
