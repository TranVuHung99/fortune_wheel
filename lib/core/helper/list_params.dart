
import 'package:lucid_decision/core/helper/pagination_params.dart';
import 'package:lucid_decision/core/helper/sort_params.dart';

class ListParams {
  final PaginationParams? paginationParams;
  final SortParams? sortParams;

  ListParams({
    this.paginationParams,
    this.sortParams,
  });
}
