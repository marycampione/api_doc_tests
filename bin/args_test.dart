// Tests for code in the args library description.
import 'package:args/args.dart';

void main() {
  testOverview1();
  testOverview2();
  testParsing1();
  testParsing2();
  testParsing3();
  specifyOptions1();
  specifyFlags1();
  specifyFlags2();
  specifyFlags3();
  testMultipleOptions1();
  testMultipleOptions2();
  testCommands1();
  testCommands2();
  testUsage();
}

testOverview1() {
  var parser = new ArgParser();
  parser.addOption('name');
}

testOverview2() {
  var parser = new ArgParser();
  parser.addFlag('name');
}

testParsing1() {
  var parser = new ArgParser();
  var results = parser.parse(['some', 'command', 'line', 'args']);
}

testParsing2() {
  var parser = new ArgParser();
  parser.addOption('mode');
  parser.addFlag('verbose', defaultsTo: true);
  var results = parser.parse(['--mode', 'debug', 'something', 'else']);

  print(results['mode']);    // debug
  print(results['verbose']); // true
  print(results.rest);       // ['something', 'else']
}

testParsing3() {
  const bool ALLOW_MORE_OPTIONS = true;
  
  var parser = new ArgParser();
  parser.addOption('mode');
  var results = parser.parse(['--mode', 'debug', 'something', 'else',
                              '--mode', 'normal'],
                             allowTrailingOptions: ALLOW_MORE_OPTIONS);

  if (ALLOW_MORE_OPTIONS) {
    assert(results['mode'] == 'normal');
  } else {
    assert(results['mode'] == 'debug');
  }
}

specifyOptions1() {
  var parser = new ArgParser();
  parser.addOption('name', abbr: 'n');
  
  var results = parser.parse(['--name=somevalue0']);
  print(results['name']); // somevalue0

  results = parser.parse(['--name somevalue1']); // BROKEN
  print(results['name']); // somevalue1

  results = parser.parse(['-nsomevalue2']);
  print(results['name']); // somevalue2

  results = parser.parse(['-n somevalue3']); // BROKEN
  print(results['name']); // somevalue3
}

specifyFlags1() {
  var parser = new ArgParser();
  parser.addFlag('name', abbr: 'n');

  var results = parser.parse(['']);
  print('value of name: ${results['name']}'); // false
  assert(!results['name']);

  results = parser.parse(['--name']);
  assert(results['name']);

  results = parser.parse(['--no-name']);
  assert(!results['name']);
}

specifyFlags2() {
  var parser = new ArgParser();
  parser.addFlag('name', defaultsTo:true, abbr: 'n');

  var results = parser.parse(['']);
  print('value of name: ${results['name']}'); // true
  assert(results['name']);

  results = parser.parse(['--name']);
  assert(results['name']);

  results = parser.parse(['--no-name']);
  assert(!results['name']);
}

specifyFlags3() {
  var parser = new ArgParser();
  parser.addFlag('verbose', abbr: 'v');
  parser.addFlag('french', abbr: 'f');
  parser.addFlag('iambic-pentameter', abbr: 'i');
  parser.addFlag('extra', abbr: 'x');
  
  var results = parser.parse(['-vfi']);
  assert(results['verbose']);
  assert(results['french']);
  assert(results['iambic-pentameter']);
  assert(!results['extra']);
}

testMultipleOptions1() {
  var parser = new ArgParser();
  parser.addOption('mode');
  var results = parser.parse(['--mode', 'on', '--mode', 'off']);
  print(results['mode']); // prints 'off'
}

testMultipleOptions2() {
  var parser = new ArgParser();
  parser.addOption('mode', allowMultiple: true);
  var results = parser.parse(['--mode', 'on', '--mode', 'off']);
  print(results['mode']); // prints '[on, off]'
}

testCommands1() {
  var parser = new ArgParser();
  var command = parser.addCommand('commit');

  command.addFlag('all', abbr: 'a');

  var results = parser.parse(['commit', '-a']);
  print(results.command.name);   // "commit"
  print(results.command['all']); // true
}

testCommands2() {
  var parser = new ArgParser();
  parser.addFlag('all', abbr: 'a');
  var command = parser.addCommand('commit');
  command.addFlag('all', abbr: 'a');

  var results = parser.parse(['commit', '-a']);
  print(results.command['all']); // true
  assert(results.command['all']);
  assert(!results['all']);
  
  results = parser.parse(['-a', 'commit']);
  assert(!results.command['all']);
  assert(results['all']);
}

testUsage() {
  var parser = new ArgParser();
  parser.addOption('mode', help: 'The compiler configuration',
      allowed: ['debug', 'release']);
  parser.addFlag('verbose', help: 'Show additional diagnostic info');
  parser.addOption('arch', help: 'The architecture to compile for',
      allowedHelp: {
        'ia32': 'Intel x86',
        'arm': 'ARM Holding 32-bit chip'
      });
  print(parser.getUsage());
}
