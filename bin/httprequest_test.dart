import 'dart:io';

final HOST = InternetAddress.LOOPBACK_IP_V4;
final PORT = 4040;

void main() {
  HttpServer.bind(HOST, PORT).then((_server) {
    _server.listen((HttpRequest request) {
      switch (request.method) {
        case 'GET': 
          handleGetRequest(request);
          break;
        case 'POST': 
          // handle post request
        }
      },
      onError: handleError);    // listen() failed.
    }).catchError(handleError);
  
}

void handleGetRequest(HttpRequest req) {
  HttpResponse res = req.response;
  var body = [];
  req.listen((List<int> buffer) => body.add(buffer),
      onDone: () {
        res.write('Received ${body.length} for request ');
        res.write(' ${req.method}: ${req.uri.path}');
        res.close();
      },
      onError: handleError);
}

void handleError(_){
  // handle error
}