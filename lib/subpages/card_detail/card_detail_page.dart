import 'package:credit_management/models/card_model.dart';
import 'package:credit_management/subpages/card_detail/card_detail_logic.dart';
import 'package:credit_management/subpages/card_detail/widgets/transaction_dialog.dart';
import 'package:credit_management/widgets/card_button.dart';
import 'package:credit_management/widgets/lined_title.dart';
import 'package:credit_management/widgets/month_picker.dart';
import 'package:credit_management/widgets/name_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardDetailPage extends StatelessWidget {
  final CardModel card;
  const CardDetailPage({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardDetailLogic(card: card),
      child: Consumer<CardDetailLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${card.bankName} ${card.cardName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinedTitle(title: 'Danh muc được hoàn'),
                  SizedBox(height: 5),
                  NameCard(
                    cardColor: const Color.fromARGB(255, 104, 203, 241),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in state.cashBackCat ?? [])
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.categoryName,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text('${item.cashBack.toString()}%'),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  LinedTitle(title: 'Dao dịch'),
                  Row(
                    children: [
                      Expanded(
                        child: MonthPicker(
                          labelText: 'Tháng bắt đầu',
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                        child: Text('tới', style: TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child: MonthPicker(
                          labelText: 'Tháng kết thúc',
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CardButton(
                    text: 'Thêm giao dịch',
                    onPressed: () async {
                      final res = await TransactionDialogWidget.show(
                        context,
                        state.cashBackCat,
                        card,
                      );
                      if (res == true) {
                        await logic.getTransactionsList();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        for (var item in state.transactions ?? [])
                          NameCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.transactionName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Text('${item.price.toString()} vnd'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item?.categoryName ?? '',
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Text('${item.cashBackRatio.toString()}%'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Cash Back',
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${((item.cashBackRatio / 100) * item.price).toString()} vnd',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Ngày dao dịch',
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      (DateFormat.yMd().format(
                                        item.createdOn,
                                      )).toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
