import 'package:credit_management/src/services/mail_service.dart';
import 'package:credit_management/src/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailDialogWidget {
  static Future<bool?> show(BuildContext context) {
    return showDialog(context: context, builder: (context) => MailDialog());
  }
}

class MailDialog extends StatelessWidget {
  const MailDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MailService(),
      child: Consumer<MailService>(
        builder: (context, service, child) {
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
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Tiêu đề đóng góp",
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
                        onChanged:(value) => service.setTitle(value),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 8,
                        decoration: InputDecoration(
                          labelText: "Đóng góp đê",
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
                        onChanged:(value) => service.setContent(value),
                      ),
                      SizedBox(height: 10),
                      CardButton(
                        text: 'Xác nhận đi nè',
                        onPressed: () async {
                          await service.sendMail(title: service.title ?? '', content: service.content ?? '');
                          if (!context.mounted) return;
                          Navigator.of(context).pop(true);
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
