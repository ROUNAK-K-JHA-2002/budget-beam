// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entity/expense_entity.dart';
import 'entity/person_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 8990327161865234216),
      name: 'ExpenseEntity',
      lastPropertyId: const obx_int.IdUid(8, 1482696363997677181),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6632466701321629908),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7617675050466723072),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8896434664083929017),
            name: 'amount',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2106811194305805683),
            name: 'dateCreated',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 2798497185370770140),
            name: 'dateUpdated',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 26083768096232422),
            name: 'category',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 2975813797113228654),
            name: 'type',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 1482696363997677181),
            name: 'userId',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 1668431425687313678),
      name: 'PersonEntity',
      lastPropertyId: const obx_int.IdUid(6, 2678094975877591957),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 325377612892822902),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7522041976212263808),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7097239781311353612),
            name: 'email',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2716049936553974312),
            name: 'dateCreated',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 2678094975877591957),
            name: 'hasCompletedOnboarding',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 1668431425687313678),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [6674767527784543452],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    ExpenseEntity: obx_int.EntityDefinition<ExpenseEntity>(
        model: _entities[0],
        toOneRelations: (ExpenseEntity object) => [],
        toManyRelations: (ExpenseEntity object) => {},
        getId: (ExpenseEntity object) => object.id,
        setId: (ExpenseEntity object, int id) {
          object.id = id;
        },
        objectToFB: (ExpenseEntity object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final categoryOffset = fbb.writeString(object.category);
          final typeOffset = fbb.writeString(object.type);
          final userIdOffset = fbb.writeString(object.userId);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.amount);
          fbb.addInt64(3, object.dateCreated.millisecondsSinceEpoch);
          fbb.addInt64(4, object.dateUpdated.millisecondsSinceEpoch);
          fbb.addOffset(5, categoryOffset);
          fbb.addOffset(6, typeOffset);
          fbb.addOffset(7, userIdOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final amountParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final dateCreatedParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));
          final dateUpdatedParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0));
          final categoryParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final userIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final object = ExpenseEntity(
              id: idParam,
              name: nameParam,
              amount: amountParam,
              dateCreated: dateCreatedParam,
              dateUpdated: dateUpdatedParam,
              category: categoryParam,
              type: typeParam,
              userId: userIdParam);

          return object;
        }),
    PersonEntity: obx_int.EntityDefinition<PersonEntity>(
        model: _entities[1],
        toOneRelations: (PersonEntity object) => [],
        toManyRelations: (PersonEntity object) => {},
        getId: (PersonEntity object) => object.id,
        setId: (PersonEntity object, int id) {
          object.id = id;
        },
        objectToFB: (PersonEntity object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final emailOffset = fbb.writeString(object.email);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addInt64(3, object.dateCreated.millisecondsSinceEpoch);
          fbb.addBool(5, object.hasCompletedOnboarding);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final dateCreatedParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));
          final hasCompletedOnboardingParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 14, false);
          final object = PersonEntity(
              id: idParam,
              name: nameParam,
              email: emailParam,
              dateCreated: dateCreatedParam,
              hasCompletedOnboarding: hasCompletedOnboardingParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [ExpenseEntity] entity fields to define ObjectBox queries.
class ExpenseEntity_ {
  /// See [ExpenseEntity.id].
  static final id =
      obx.QueryIntegerProperty<ExpenseEntity>(_entities[0].properties[0]);

  /// See [ExpenseEntity.name].
  static final name =
      obx.QueryStringProperty<ExpenseEntity>(_entities[0].properties[1]);

  /// See [ExpenseEntity.amount].
  static final amount =
      obx.QueryIntegerProperty<ExpenseEntity>(_entities[0].properties[2]);

  /// See [ExpenseEntity.dateCreated].
  static final dateCreated =
      obx.QueryDateProperty<ExpenseEntity>(_entities[0].properties[3]);

  /// See [ExpenseEntity.dateUpdated].
  static final dateUpdated =
      obx.QueryDateProperty<ExpenseEntity>(_entities[0].properties[4]);

  /// See [ExpenseEntity.category].
  static final category =
      obx.QueryStringProperty<ExpenseEntity>(_entities[0].properties[5]);

  /// See [ExpenseEntity.type].
  static final type =
      obx.QueryStringProperty<ExpenseEntity>(_entities[0].properties[6]);

  /// See [ExpenseEntity.userId].
  static final userId =
      obx.QueryStringProperty<ExpenseEntity>(_entities[0].properties[7]);
}

/// [PersonEntity] entity fields to define ObjectBox queries.
class PersonEntity_ {
  /// See [PersonEntity.id].
  static final id =
      obx.QueryIntegerProperty<PersonEntity>(_entities[1].properties[0]);

  /// See [PersonEntity.name].
  static final name =
      obx.QueryStringProperty<PersonEntity>(_entities[1].properties[1]);

  /// See [PersonEntity.email].
  static final email =
      obx.QueryStringProperty<PersonEntity>(_entities[1].properties[2]);

  /// See [PersonEntity.dateCreated].
  static final dateCreated =
      obx.QueryDateProperty<PersonEntity>(_entities[1].properties[3]);

  /// See [PersonEntity.hasCompletedOnboarding].
  static final hasCompletedOnboarding =
      obx.QueryBooleanProperty<PersonEntity>(_entities[1].properties[4]);
}
