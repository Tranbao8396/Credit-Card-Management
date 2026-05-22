import 'package:credit_management/pages/searchPage/search_page_logic.dart';
import 'package:credit_management/pages/searchPage/widgets/mcc_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchPageLogic(),
      child: Consumer<SearchPageLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nhập mã mcc, tên cửa hàng, hoặc ngành hàng.",
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => logic.search(context),
                    ),
                  ),
                  onChanged: (value) => logic.setQuery(value),
                ),
                SizedBox(height: 20),

                // MARK: TableDataList
                state.isLoading == null
                    ? Container()
                    : state.isLoading == true
                    ? CircularProgressIndicator()
                    : MccTable(
                        mccState: state,
                        mccLogic: logic,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
