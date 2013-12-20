import 'dart:convert';
import 'dart:io';
import 'dart:async';

bool showLineNumbers = true;

main() { 

int lineNumber = 1;
Stream<List<int>> stream = new File('quotes.txt').openRead();

stream.transform(UTF8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
        if (showLineNumbers) {
          stdout.write('${lineNumber++} ');
        }
        stdout.writeln(line);
      });
  asciiTest();
  jsonTest();
  latinTest();
  utf8Test;
}

asciiTest() {
var encoded = ASCII.encode("This is ASCII!");
var decoded = ASCII.decode([0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73,
                            0x20, 0x41, 0x53, 0x43, 0x49, 0x49, 0x21]);

}

jsonTest() {
var encoded = JSON.encode([1, 2, { "a": null }]);
var decoded = JSON.decode('["foo", { "bar": 499 }]');
}

latinTest(){
var encoded = LATIN1.encode("blåbærgrød");
var decoded = LATIN1.decode([0x62, 0x6c, 0xe5, 0x62, 0xe6,
                             0x72, 0x67, 0x72, 0xf8, 0x64]);
}


utf8Test() {
var encoded = UTF8.encode("Îñţérñåţîöñåļîžåţîờñ");
var decoded = UTF8.decode([0x62, 0x6c, 0xc3, 0xa5, 0x62, 0xc3, 0xa6,
                           0x72, 0x67, 0x72, 0xc3, 0xb8, 0x64]);
}
