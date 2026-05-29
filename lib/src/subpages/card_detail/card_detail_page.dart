import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/subpages/card_detail/card_detail_logic.dart';
import 'package:credit_management/src/widgets/limit_dialog.dart';
import 'package:credit_management/src/widgets/transaction_dialog.dart';
import 'package:credit_management/src/widgets/card_button.dart';
import 'package:credit_management/src/widgets/lined_title.dart';
import 'package:credit_management/src/widgets/name_card.dart';
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
                  LinedTitle(title: 'Danh mục được hoàn'),
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
                  LinedTitle(title: 'Mức chi tiêu'),
                  NameCard(
                    cardColor: const Color.fromARGB(255, 201, 148, 250),
                    onSettingsPressed: () async {
                      final res = await SetLimitWidget.show(context, card, state.limitVal);
                      if (res == true) {
                        await logic.getLimitSpending();
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Chi tiêu tháng ${DateFormat.yMd().format(DateTime(DateTime.now().year, DateTime.now().month, 1))}', style: TextStyle(
                              fontSize: 14
                            ),),
                            Text(' - ${DateFormat.yMd().format(DateTime(DateTime.now().year, DateTime.now().month + 1, 0))}', style: TextStyle(
                              fontSize: 14
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${state.totalSpending?.toStringAsFixed(0) ?? '0'} / ', style: TextStyle(
                              fontSize: 16
                            ),),
                            Text(
                              '${state.limitVal?.toStringAsFixed(0) ?? '-'} vnd',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  LinedTitle(title: 'Dao dịch'),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          style: TextStyle(fontSize: 14),
                          readOnly: true,
                          controller: TextEditingController(
                            text: state.startDate != null
                                ? DateFormat.yMd().format(state.startDate!)
                                : '',
                          ),
                          decoration: InputDecoration(
                            labelText: "Ngày bắt đầu",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
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
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              logic.setStartDate(pickedDate);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          style: TextStyle(fontSize: 14),
                          readOnly: true,
                          controller: TextEditingController(
                            text: state.endDate != null
                                ? DateFormat.yMd().format(state.endDate!)
                                : '',
                          ),
                          decoration: InputDecoration(
                            labelText: "Ngày kết thúc",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
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
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              logic.setEndDate(pickedDate);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        flex: 2,
                        child: CardButton(
                          fontSize: 18,
                          text: '⌕',
                          onPressed: () async {
                            await logic.getTransactionsList();
                          },
                          buttonColor: const Color.fromARGB(255, 80, 108, 131),
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
                        await logic.getTransactionCost();
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
                                    Text('${item.price.toStringAsFixed(0)} vnd'),
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
                                    Text('${item?.cashBackRatio.toStringAsFixed(2)}%'),
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
                                      '${((item?.cashBackRatio / 100) * item?.price).toStringAsFixed(0)} vnd',
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
                                        item?.createdOn,
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
