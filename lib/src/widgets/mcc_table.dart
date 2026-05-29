import 'package:credit_management/src/pages/searchPage/search_page_logic.dart';
import 'package:credit_management/src/pages/searchPage/search_state.dart';
import 'package:credit_management/src/widgets/notify_dialog.dart';
import 'package:flutter/material.dart';

class MccTable extends StatelessWidget {
  final SearchState mccState;
  final SearchPageLogic mccLogic;

  const MccTable({super.key, required this.mccState, required this.mccLogic});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Có ${mccState.searchResultsCount ?? '0'} kết quả tìm kiếm'),

        Row(
          children: [
            SizedBox(
              width: 50,
              child: TextFormField(
                initialValue: mccState.currentPage.toString(),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 4,
                    ),
                  ),
                ),
                onFieldSubmitted: (value) =>
                    mccLogic.paginate(context, int.tryParse(value) ?? 1),
              ),
            ),
            SizedBox(width: 10),
            Text('/ ${mccState.totalPages ?? 1}'),
          ],
        ),
        SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 123, 163),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
                width: 4,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 360,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      dividerThickness: 0,
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'MCC',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Cửa hàng',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Danh mục',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: mccState.searchResults
                          .map(
                            (item) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(item.code ?? '')),
                                DataCell(
                                  TextButton(
                                    child: Text(item.name ?? ''),
                                    onPressed: () {
                                      NotifyDialogWidget.show(context, 'Text', "Text");
                                    },
                                  ),
                                ),
                                DataCell(Text(item.cats?.join(', ') ?? '')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
