import 'dart:convert';

import 'package:clean_architecture_flutter/features/recommend/data/models/computer_combine_model.dart';
import 'package:clean_architecture_flutter/features/recommend/data/models/milestone_model.dart';
import 'package:clean_architecture_flutter/features/recommend/domain/entities/recommend_output.dart';
import 'package:clean_architecture_flutter/features/recommend/domain/entities/milestone.dart';
import 'package:clean_architecture_flutter/features/recommend/domain/usecases/get_computer_item_hit%20copy.dart';
import 'package:clean_architecture_flutter/features/recommend/domain/usecases/get_computer_program_fit.dart';
import 'package:clean_architecture_flutter/features/recommend/domain/usecases/get_recommend_output.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/program_fit.dart';
import '../../domain/entities/recommend_input.dart';
import '../models/computer_item_model.dart';
import '../models/program_fit_model.dart';

abstract class RecommendLocalDataSource {
  Future<String> getTodayTip(int num);
}

class RecommendLocalDataSourceImpl implements RecommendLocalDataSource {
  @override
  Future<String> getTodayTip(int num) async {
    String rawData = await rootBundle.loadString('today_tips.json');
    List<dynamic> jsonData = json.decode(rawData);
    return jsonData[num];
  }
}