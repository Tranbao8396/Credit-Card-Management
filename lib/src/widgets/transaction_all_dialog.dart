import 'package:credit_management/src/subpages/card_detail/card_detail_logic.dart';
import 'package:credit_management/src/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionAllDialogWidget {
  static Future<bool?> show(BuildContext context, transactionName) {
    return showDialog<bool?>(
      context: context,
      builder: (context) =>
          TransactionAllDialog(transactionName: transactionName),
    );
  }
}

class TransactionAllDialog extends StatelessWidget {
  final String? transactionName;

  const TransactionAllDialog({super.key, this.transactionName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardDetailLogic(),
      child: Consumer<CardDetailLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 255, 10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 3,
                ),
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: transactionName),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tên cửa hàng",
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
                        onChanged: (value) => {logic.setTransactionName(value)},
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          ...(state.userCards ?? []).map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item.cardName ?? ''),
                            ),
                          ),
                        ],
                        onChanged: (value) async => {logic.setCard(value)},
                        decoration: InputDecoration(
                          labelText: "Ngân hàng",
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
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          ...(state.cashBackCat ?? []).map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item?.categoryName ?? ''),
                            ),
                          ),
                        ],
                        onChanged: (value) => {logic.setCategory(value)},
                        decoration: InputDecoration(
                          labelText: "Ngành Hàng",
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
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Tiền thanh toán",
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
                        onChanged: (value) => {logic.setPrice(value)},
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: state.transactionDate != null
                              ? DateFormat.yMd().format(state.transactionDate!)
                              : '',
                        ),
                        decoration: InputDecoration(
                          labelText: "Ngày dao dịch",
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
                            logic.setTransactionDate(pickedDate);
                          }
                        },
                      ),
                      state.isValid
                          ? Text(
                              'Hãy nhập đầy đủ thông tin',
                              style: TextStyle(fontSize: 12),
                            )
                          : Text(''),
                      SizedBox(height: 10),
                      CardButton(
                        text: 'Thêm giao dịch',
                        onPressed: () async {
                          if (transactionName != null) logic.setTransactionName(transactionName ?? '');
                          await logic.addTransaction(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
