import 'dart:convert';

import 'package:credit_management/models/mcc_model.dart';
import 'package:credit_management/pages/searchPage/search_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPageLogic extends ChangeNotifier {
  final SearchState state = SearchState();

  void setQuery(String value) {
    state.query = value;
    notifyListeners();
  }

  Future<void> search(BuildContext context) async {
    if (state.query == null || state.query!.isEmpty) {
      return;
    }

    state.isLoading = true;
    notifyListeners();

    FocusScope.of(context).unfocus();

    try {
      // Thực hiện logic tìm kiếm tại đây
      String urlApi =
          'https://rcgv.vn/wp-json/rv/v1/mcc?q=${state.query}&page=1&per=10';
      final response = await http.get(Uri.parse(urlApi));
      if (response.statusCode == 200) {
        final data = response.body;
        final jsonData = jsonDecode(data);

        state.searchResultsCount = jsonData['total'] as int?;
        state.totalPages = (jsonData['total'] as int?) != null
            ? ((jsonData['total'] as int?)! / 10).ceil()
            : 0;
        state.searchResults = jsonData['rows']
            .map<MccModel>((item) => MccModel.fromJson(item))
            .toList();
        state.currentPage = 1;
      }
    } catch (e) {
      throw Exception('Lỗi khi tìm kiếm: $e');
    } finally {
      state.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> paginate(BuildContext context, int page) async {
    if (state.query == null || state.query!.isEmpty) {
      return;
    }

    state.isLoading = true;
    notifyListeners();

    FocusScope.of(context).unfocus();

    try {
      // Thực hiện logic phân trang tại đây
      String urlApi =
          'https://rcgv.vn/wp-json/rv/v1/mcc?q=${state.query}&page=$page&per=10';
      final response = await http.get(Uri.parse(urlApi));

      if (response.statusCode == 200) {
        final data = response.body;
        final jsonData = jsonDecode(data);
        state.searchResults = jsonData['rows']
            .map<MccModel>((item) => MccModel.fromJson(item))
            .toList();
        state.currentPage = page;
      }
    } catch (e) {
      throw Exception('Lỗi khi tìm kiếm: $e');
    } finally {
      state.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearSearch() async {
    state.query = null;
    state.isLoading = null;
    state.isPaginated = null;
    state.searchResultsCount = null;
    state.totalPages = null;
    state.searchResults = [];
    notifyListeners();
  }
}
