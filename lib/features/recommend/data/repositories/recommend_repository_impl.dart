import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/computer_item.dart';
import '../../domain/entities/milestone.dart';
import '../../domain/entities/program_fit.dart';
import '../../domain/entities/recommend_input.dart';
import '../../domain/entities/recommend_output.dart';
import '../../domain/repositories/recommend_repository.dart';
import '../datasources/recommend_local_data_source.dart';
import '../datasources/recommend_remote_data_source.dart';

class RecommendRepositoryImpl implements RecommendRepository {
  final RecommendLocalDataSource localDataSource;
  final RecommendRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecommendRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<String> getTodayTip(int num) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    return localDataSource.getTodayTip(num);
  }

  @override
  Future<List<ProgramFit>> getComputerProgramFit(int vgaId, int purpose) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerProgramFit(vgaId, purpose);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<double> getBottleneckCPUVGA(int cpuId, int vgaId) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getBottleneckCPUVGA(cpuId, vgaId);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<List<RecommendOutput>> getRecommendOutput(
      RecommendInput recommendInput) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getRecommendOutput(recommendInput);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<Milestone> getMilestone() async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getMilestone();
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<int> getComputerCPUIdHit(int rank) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerCPUIdHit(rank);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<List<int>> getComputerCPUIdBestRange(int start, int end) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerCPUIdBestRange(start, end);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerCPU> getComputerCPU(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerCPU(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerVGA> getComputerVGA(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerVGA(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerRAM> getComputerRAM(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerRAM(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerMainBoard> getComputerMainBoard(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerMainBoard(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerSSD> getComputerSSD(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerSSD(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerHDD> getComputerHDD(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerHDD(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerCooler> getComputerCooler(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerCooler(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerPower> getComputerPower(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerPower(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerCase> getComputerCase(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerCase(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerMonitor> getComputerMonitor(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerMonitor(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerKeyboard> getComputerKeyboard(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerKeyboard(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<ComputerMouse> getComputerMouse(int id) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.getComputerMouse(id);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<bool> isExistAccount(String id, String pw) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.isExistAccount(id, pw);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }

  @override
  Future<bool> postNewAccount(String id, String pw) async {
    if (kDebugMode) await Future.delayed(Duration(seconds: 3));
    if (!await networkInfo.isConnected) {
      return Future.error(ConnectionFailure());
    }
    try {
      return remoteDataSource.postNewAccount(id, pw);
    } on ClientException {
      return Future.error(ClientFailure());
    } catch (e) {
      return Future.error(UnknownFailure());
    }
  }
}
