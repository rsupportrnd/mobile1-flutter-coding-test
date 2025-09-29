// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_local_service.dart';

// ignore_for_file: type=lint
class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('text'),
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    roomId,
    sender,
    content,
    timestamp,
    messageType,
    localId,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessageData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      messageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_type'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessageData extends DataClass implements Insertable<ChatMessageData> {
  final int id;
  final String messageId;
  final String roomId;
  final String sender;
  final String content;
  final DateTime timestamp;
  final String messageType;
  final String? localId;
  final int syncStatus;
  const ChatMessageData({
    required this.id,
    required this.messageId,
    required this.roomId,
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.messageType,
    this.localId,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<String>(messageId);
    map['room_id'] = Variable<String>(roomId);
    map['sender'] = Variable<String>(sender);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['message_type'] = Variable<String>(messageType);
    if (!nullToAbsent || localId != null) {
      map['local_id'] = Variable<String>(localId);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      messageId: Value(messageId),
      roomId: Value(roomId),
      sender: Value(sender),
      content: Value(content),
      timestamp: Value(timestamp),
      messageType: Value(messageType),
      localId: localId == null && nullToAbsent
          ? const Value.absent()
          : Value(localId),
      syncStatus: Value(syncStatus),
    );
  }

  factory ChatMessageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessageData(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String>(json['messageId']),
      roomId: serializer.fromJson<String>(json['roomId']),
      sender: serializer.fromJson<String>(json['sender']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      messageType: serializer.fromJson<String>(json['messageType']),
      localId: serializer.fromJson<String?>(json['localId']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String>(messageId),
      'roomId': serializer.toJson<String>(roomId),
      'sender': serializer.toJson<String>(sender),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'messageType': serializer.toJson<String>(messageType),
      'localId': serializer.toJson<String?>(localId),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  ChatMessageData copyWith({
    int? id,
    String? messageId,
    String? roomId,
    String? sender,
    String? content,
    DateTime? timestamp,
    String? messageType,
    Value<String?> localId = const Value.absent(),
    int? syncStatus,
  }) => ChatMessageData(
    id: id ?? this.id,
    messageId: messageId ?? this.messageId,
    roomId: roomId ?? this.roomId,
    sender: sender ?? this.sender,
    content: content ?? this.content,
    timestamp: timestamp ?? this.timestamp,
    messageType: messageType ?? this.messageType,
    localId: localId.present ? localId.value : this.localId,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  ChatMessageData copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessageData(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      sender: data.sender.present ? data.sender.value : this.sender,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      messageType: data.messageType.present
          ? data.messageType.value
          : this.messageType,
      localId: data.localId.present ? data.localId.value : this.localId,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessageData(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('roomId: $roomId, ')
          ..write('sender: $sender, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('messageType: $messageType, ')
          ..write('localId: $localId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    roomId,
    sender,
    content,
    timestamp,
    messageType,
    localId,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessageData &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.roomId == this.roomId &&
          other.sender == this.sender &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.messageType == this.messageType &&
          other.localId == this.localId &&
          other.syncStatus == this.syncStatus);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessageData> {
  final Value<int> id;
  final Value<String> messageId;
  final Value<String> roomId;
  final Value<String> sender;
  final Value<String> content;
  final Value<DateTime> timestamp;
  final Value<String> messageType;
  final Value<String?> localId;
  final Value<int> syncStatus;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.roomId = const Value.absent(),
    this.sender = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.messageType = const Value.absent(),
    this.localId = const Value.absent(),
    this.syncStatus = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required String messageId,
    required String roomId,
    required String sender,
    required String content,
    required DateTime timestamp,
    this.messageType = const Value.absent(),
    this.localId = const Value.absent(),
    this.syncStatus = const Value.absent(),
  }) : messageId = Value(messageId),
       roomId = Value(roomId),
       sender = Value(sender),
       content = Value(content),
       timestamp = Value(timestamp);
  static Insertable<ChatMessageData> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? roomId,
    Expression<String>? sender,
    Expression<String>? content,
    Expression<DateTime>? timestamp,
    Expression<String>? messageType,
    Expression<String>? localId,
    Expression<int>? syncStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (roomId != null) 'room_id': roomId,
      if (sender != null) 'sender': sender,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (messageType != null) 'message_type': messageType,
      if (localId != null) 'local_id': localId,
      if (syncStatus != null) 'sync_status': syncStatus,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? messageId,
    Value<String>? roomId,
    Value<String>? sender,
    Value<String>? content,
    Value<DateTime>? timestamp,
    Value<String>? messageType,
    Value<String?>? localId,
    Value<int>? syncStatus,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      messageType: messageType ?? this.messageType,
      localId: localId ?? this.localId,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('roomId: $roomId, ')
          ..write('sender: $sender, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('messageType: $messageType, ')
          ..write('localId: $localId, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }
}

abstract class _$ChatLocalService extends GeneratedDatabase {
  _$ChatLocalService(QueryExecutor e) : super(e);
  $ChatLocalServiceManager get managers => $ChatLocalServiceManager(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [chatMessages];
}

typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      required String messageId,
      required String roomId,
      required String sender,
      required String content,
      required DateTime timestamp,
      Value<String> messageType,
      Value<String?> localId,
      Value<int> syncStatus,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      Value<String> messageId,
      Value<String> roomId,
      Value<String> sender,
      Value<String> content,
      Value<DateTime> timestamp,
      Value<String> messageType,
      Value<String?> localId,
      Value<int> syncStatus,
    });

class $$ChatMessagesTableFilterComposer
    extends Composer<_$ChatLocalService, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$ChatLocalService, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$ChatLocalService, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get roomId =>
      $composableBuilder(column: $table.roomId, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$ChatLocalService,
          $ChatMessagesTable,
          ChatMessageData,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (
            ChatMessageData,
            BaseReferences<
              _$ChatLocalService,
              $ChatMessagesTable,
              ChatMessageData
            >,
          ),
          ChatMessageData,
          PrefetchHooks Function()
        > {
  $$ChatMessagesTableTableManager(
    _$ChatLocalService db,
    $ChatMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String> roomId = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> messageType = const Value.absent(),
                Value<String?> localId = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                messageId: messageId,
                roomId: roomId,
                sender: sender,
                content: content,
                timestamp: timestamp,
                messageType: messageType,
                localId: localId,
                syncStatus: syncStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String messageId,
                required String roomId,
                required String sender,
                required String content,
                required DateTime timestamp,
                Value<String> messageType = const Value.absent(),
                Value<String?> localId = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
              }) => ChatMessagesCompanion.insert(
                id: id,
                messageId: messageId,
                roomId: roomId,
                sender: sender,
                content: content,
                timestamp: timestamp,
                messageType: messageType,
                localId: localId,
                syncStatus: syncStatus,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$ChatLocalService,
      $ChatMessagesTable,
      ChatMessageData,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (
        ChatMessageData,
        BaseReferences<_$ChatLocalService, $ChatMessagesTable, ChatMessageData>,
      ),
      ChatMessageData,
      PrefetchHooks Function()
    >;

class $ChatLocalServiceManager {
  final _$ChatLocalService _db;
  $ChatLocalServiceManager(this._db);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
}
