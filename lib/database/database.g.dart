// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorIndtProductsDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IndtProductsDataBaseBuilder databaseBuilder(String name) =>
      _$IndtProductsDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$IndtProductsDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$IndtProductsDataBaseBuilder(null);
}

class _$IndtProductsDataBaseBuilder {
  _$IndtProductsDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$IndtProductsDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$IndtProductsDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<IndtProductsDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$IndtProductsDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$IndtProductsDataBase extends IndtProductsDataBase {
  _$IndtProductsDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`title` TEXT, `description` TEXT, `images` TEXT, `price` REAL, `discountPercentage` REAL, `rating` REAL, `stock` INTEGER, `brand` TEXT, `category` TEXT, `thumbnail` TEXT, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `serverId` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'images': item.images,
                  'price': item.price,
                  'discountPercentage': item.discountPercentage,
                  'rating': item.rating,
                  'stock': item.stock,
                  'brand': item.brand,
                  'category': item.category,
                  'thumbnail': item.thumbnail,
                  'id': item.id,
                  'serverId': item.serverId
                }),
        _productUpdateAdapter = UpdateAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'images': item.images,
                  'price': item.price,
                  'discountPercentage': item.discountPercentage,
                  'rating': item.rating,
                  'stock': item.stock,
                  'brand': item.brand,
                  'category': item.category,
                  'thumbnail': item.thumbnail,
                  'id': item.id,
                  'serverId': item.serverId
                }),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'Product',
            ['id'],
            (Product item) => <String, Object?>{
                  'title': item.title,
                  'description': item.description,
                  'images': item.images,
                  'price': item.price,
                  'discountPercentage': item.discountPercentage,
                  'rating': item.rating,
                  'stock': item.stock,
                  'brand': item.brand,
                  'category': item.category,
                  'thumbnail': item.thumbnail,
                  'id': item.id,
                  'serverId': item.serverId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final UpdateAdapter<Product> _productUpdateAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Future<List<Product?>> fetchAll() async {
    return _queryAdapter.queryList('SELECT * FROM Product',
        mapper: (Map<String, Object?> row) => Product(
            id: row['id'] as int?,
            serverId: row['serverId'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            images: row['images'] as String?,
            price: row['price'] as double?,
            discountPercentage: row['discountPercentage'] as double?,
            rating: row['rating'] as double?,
            stock: row['stock'] as int?,
            brand: row['brand'] as String?,
            category: row['category'] as String?,
            thumbnail: row['thumbnail'] as String?));
  }

  @override
  Future<List<int?>> fetchAllServerId() async {
    return _queryAdapter.queryList('SELECT serverId FROM Product',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int> insertLocally(Product object) {
    return _productInsertionAdapter.insertAndReturnId(
        object, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateLocally(Product object) {
    return _productUpdateAdapter.updateAndReturnChangedRows(
        object, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteLocally(Product object) {
    return _productDeletionAdapter.deleteAndReturnChangedRows(object);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
