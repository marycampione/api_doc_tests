
import 'dart:io';

import 'dart:async';
import 'dart:convert';

main() {
  HttpServer.bind('127.0.0.1', 4444)
     .then((server) => print('${server.isBroadcast}'))
     .catchError(print);

  Stream<List<int>> stream = new File('quotes.txt').openRead();
  stream.transform(UTF8.decoder).listen(print);

//querySelector('#myButton').onClick.listen((_) { print('Click.'); } );

}
