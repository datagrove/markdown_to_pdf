import 'package:markdown_to_pdf/markdown_to_pdf.dart';
import 'package:args/args.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

void main2(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser();
  //..addFlag(lineNumber, negatable: false, abbr: 'n');

  ArgResults argResults = parser.parse(arguments);
  final paths = argResults.rest;

  for (var o in paths) {
    final fx = File(o);
    final md = await fx.readAsString();
    mdtopdf(md, "${p.dirname(o)}/${p.basenameWithoutExtension(o)}.pdf");
  }
}
