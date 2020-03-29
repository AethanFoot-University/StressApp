import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stress_app/data/User.dart';

class EmailSender {
  static Future sendEmail() async {
    String username = 'aj9039993@gmail.com';
    String password = '@h{9Hj4j_;Zc?hz\\';

    final smtpServer = gmail(username, password);

    List<FileAttachment> attachments = [FileAttachment(await _getFile())];

    final message = Message()
      ..from = Address(username)
      ..recipients.add(User.currentUser.email)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..attachments = attachments;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString());
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Bugsy.png');
  }

  static Future<File> _getFile() async {
    final data = await rootBundle.load('assets/images/Bugsy.png');
    final buffer = data.buffer;
    final file = await _localFile;
    await file.writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    return file;
  }
}
