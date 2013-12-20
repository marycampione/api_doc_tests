
import 'dart:io';
import 'dart:async';
import 'dart:convert';

WebSocket ws;

handleMsg(string) {
  print(string);
}

main() {

File myFile = new File('myFile.txt');
myFile.rename('yourFile.txt').then((_) => print('file renamed'));


String myPath = 'quotes.txt';

FileSystemEntity.isDirectory(myPath).then((isDir) {
  if (isDir) {
    print('$myPath is a directory');
  } else {
    print('$myPath is not a directory');
  }
});

Process.start('ls', ['-R', 'web']).then((process) {
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  process.exitCode.then(print);
});

runZoned(() {
  HttpServer.bind('127.0.0.1', 4040).then((server) {
    server.listen((HttpRequest req) {
      if (req.uri.path == '/ws') {
        WebSocketTransformer.upgrade(req).then((socket) {
          socket.listen(handleMsg);
        });
      }
    });
  });
},
onError: (e) => print("An error occurred."));


WebSocket.connect('ws://127.0.0.1:4040/ws').then((socket) {
  socket.add('Hello, World!');
 });



ServerSocket.bind('127.0.0.1', 4041)
  .then((serverSocket) {
    serverSocket.listen((socket) {
      socket.transform(UTF8.decoder).listen(print);
    });
  });
Socket.connect('127.0.0.1', 4041).then((socket) {
  socket.write('Hello, World!');
});

stdout.writeln('Hello, World!');
stderr.writeAll([ 'That ', 'is ', 'an ', 'error.', '\n']);
 String inputText = stdin.readLineSync();

}
