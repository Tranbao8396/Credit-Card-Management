import 'package:credit_management/src/models/mcc_model.dart';

class SearchState {
  String? query;
  bool? isLoading;
  bool? isPaginated;
  int? searchResultsCount;
  int? totalPages;
  int currentPage = 1;
  List<MccModel> searchResults = [];
}