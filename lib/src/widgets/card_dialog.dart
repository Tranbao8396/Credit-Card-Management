import 'package:credit_management/src/pages/cardPage/card_page_logic.dart';
import 'package:credit_management/src/widgets/card_button.dart';
import 'package:credit_management/src/widgets/month_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDialogWidget {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => CardDialog(),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageLogic(),
      child: Consumer<HomePageLogic>(
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
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // MARK: ngan hang
                      DropdownButtonFormField(
                        items: [
                          ...(state.banks).map(
                            (bank) => DropdownMenuItem(
                              value: bank,
                              child: Text(bank.bankName ?? ''),
                            ),
                          ),
                        ],
                        onChanged: (value) => logic.setBank(value),
                        decoration: InputDecoration(
                          labelText: "Ngân Hàng",
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
                      // MARK: ten the
                      DropdownButtonFormField(
                        items: [
                          ...(state.bankCards)!.map(
                            (card) => DropdownMenuItem(
                              value: card,
                              child: Text(card.cardName ?? ''),
                            ),
                          ),
                        ],
                        initialValue: state.cardInfo,
                        onChanged: (value) => logic.setCardInfo(value!),
                        decoration: InputDecoration(
                          labelText: "Thẻ",
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
                      // MARK: so the
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Só thẻ",
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
                        onChanged: (value) => logic.setCardNumber(value),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          // MARK: ngay het han
                          Expanded(
                            child: MonthPicker(
                              controller: TextEditingController(
                                text: state.cardExpiryDate != null
                                    ? "${state.cardExpiryDate!.month}/${state.cardExpiryDate!.year}"
                                    : "",
                              ),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              onDateSelected: (selectedDate) {
                                if (selectedDate != null) {
                                  logic.setCardExpiryDate(selectedDate);
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          // MARK: loai the
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(
                                text: state.cardType ?? "",
                              ),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Kiểu thẻ",
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      state.isError
                          ? Text(
                              "Vui lòng điền đầy đủ thông tin và đảm bảo số thẻ không trùng lặp",
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink(),
                      state.isLoading
                          ? CircularProgressIndicator()
                          : CardButton(
                              text: "Thêm thẻ",
                              onPressed: () {
                                logic.addCard(context);
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
