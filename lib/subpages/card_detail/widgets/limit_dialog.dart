import 'package:credit_management/models/card_model.dart';
import 'package:credit_management/subpages/card_detail/card_detail_logic.dart';
import 'package:credit_management/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetLimitWidget {
  static Future<bool?> show(BuildContext context, card) {
    return showDialog<bool?>(
      context: context,
      builder: (context) => SetlimitDialog(card: card),
    );
  }
}

class SetlimitDialog extends StatelessWidget {
  final CardModel card;

  const SetlimitDialog({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardDetailLogic(card: card),
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
                        initialValue: state.limitVal != null ? state.limitVal!.toStringAsFixed(0) : '',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Hạn mức chi tiêu",
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
                        onChanged: (value) => {logic.setLimit(value)},
                      ),
                      SizedBox(height: 10),
                      state.isValid
                          ? Text(
                              'Hãy nhập đầy đủ thông tin',
                              style: TextStyle(fontSize: 12),
                            )
                          : Text(''),
                      SizedBox(height: 10),
                      CardButton(text: 'Xác nhận', onPressed: () async {
                        await logic.setLimitSpending(context);
                      }),
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
