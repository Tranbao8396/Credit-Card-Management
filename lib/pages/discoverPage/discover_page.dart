import 'package:credit_management/pages/discoverPage/discover_page_logic.dart';
import 'package:credit_management/services/url_service.dart';
import 'package:credit_management/widgets/card_button.dart';
import 'package:credit_management/widgets/lined_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiscoverPageLogic()..getUSerBanksList(),
      child: Consumer<DiscoverPageLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                LinedTitle(title: 'Ưu đãi từ thẻ'),
                ListView(
                  shrinkWrap: true,
                  children: [
                    for (var bank in state.bankList ?? [])
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: CardButton(
                          text: "Ưu đãi từ ${bank.bankName}",
                          buttonColor: Colors.blueGrey,
                          onPressed: () {
                            UrlService.openUrl(bank.bankUrl ?? '');
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
