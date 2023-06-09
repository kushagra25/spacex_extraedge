import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:retrofit/retrofit.dart';

import 'rocket_api.dart';

final rocketServiceProvider = Provider<RocketService>((ref) {
  return RocketService();
});

class RocketService {
  static const String _databaseName = 'rockets.db';
  static const String _tableName = 'rockets';
  static const int _databaseVersion = 1;

  late Database _database;
  late RocketApi _rocketApi;

  Future<void> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_tableName(
          id TEXT PRIMARY KEY,
          name TEXT,
          country TEXT,
          enginesCount INTEGER,
          flickerImages TEXT,
          active INTEGER,
          costPerLaunch INTEGER,
          successRatePercent INTEGER,
          description TEXT,
          wikipedia TEXT,
          height TEXT,
          diameter TEXT
        )
        ''');
      },
    );
  }

  Future<void> _initRocketApi() async {
    final dio = Dio();
    _rocketApi =
        RocketApi(dio, baseUrl: 'https://api.spacexdata.com/v4/rockets');
  }

  Future<List<Rocket>> getRockets() async {
    await _openDatabase();

    final List<Map<String, dynamic>> rocketsMapList =
        await _database.query(_tableName);
    if (rocketsMapList.isNotEmpty) {
      return rocketsMapList
          .map((rocketMap) => Rocket.fromJson(rocketMap))
          .toList();
    }

    try {
      await _initRocketApi();
      final rockets = await _rocketApi.getRockets();
      if (rockets.isEmpty) {
        print('Rockets not found.');
        throw RocketApiException('Rockets not found');
      }
      for (final rocket in rockets) {
        final rocketMap = rocket.toJson();
        await _database.insert(_tableName, rocketMap);
      }

      return rockets;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print('Rockets not found.');
        throw RocketApiException('Rockets not found');
      } else {
        print('Error fetching rockets: $e');
        throw RocketApiException('Failed to fetch rockets: $e');
      }
    } catch (e) {
      print('Error fetching rockets: $e');
      throw RocketApiException('Failed to fetch rockets: $e');
    }
  }

  Future<Rocket> getRocket(String rocketId) async {
    await _openDatabase();

    final List<Map<String, dynamic>> rocketsMapList = await _database.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [rocketId],
    );
    if (rocketsMapList.isNotEmpty) {
      return Rocket.fromJson(rocketsMapList.first);
    }

    try {
      await _initRocketApi();
      final rocket = await _rocketApi.getRocket(rocketId);
      final rocketMap = rocket.toJson();
      await _database.insert(_tableName, rocketMap);

      return rocket;
    } catch (e) {
      print('Error fetching rocket: $e');
      throw RocketApiException('Failed to fetch rocket: $e');
    }
  }
}
