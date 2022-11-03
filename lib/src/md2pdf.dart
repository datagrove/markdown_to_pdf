import 'dart:io';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:markdown/markdown.dart' as md;

class Visitor {
  pw.Document doc;

  List<pw.Widget> text = [];
  List<pw.Divider> divider = [];
  List<pw.TextSpan> span = [];
  Visitor(this.doc);

  finish() {
    doc.addPage(pw.MultiPage(build: (context) => text));
  }

  add(String s) {
    text.add(pw.Text(s));
  }

  visit(Element? e) {
    if (e == null) return;
    print(e);

    switch (e.nodeType) {
      case Node.ELEMENT_NODE:
        // handle inline
        switch (e.localName) {
          case "a":
            var href = e.attributes["href"];
            print("href $href");
            text.add(pw.UrlLink(
                destination: href ?? "www.datagrove.com",
                child: pw.Text(e.text,
                    style: pw.TextStyle(color: PdfColors.blue))));
            return;
          case "strong":
            span.add(pw.TextSpan(
                text: e.text,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)));

            return;
          case "em":
            span.add(pw.TextSpan(
                text: e.text,
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic)));
            return;
          case "code":
            span.add(pw.TextSpan(
                text: e.text, style: pw.TextStyle(color: PdfColors.green)));
            return;
        }

        pw.TextStyle? s = null;
        pw.Divider? f = null;
        switch (e.localName) {
          case "blockquote":
            s = pw.TextStyle();
            f = pw.Divider();

            break;
          case "h1":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20);
            break;
          case "h2":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18);
            break;
          case "h3":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16);
            break;
          case "h4":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14);
            break;
          case "h5":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12);
            break;
          case "h6":
            s = pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
            break;
          case "hr":
            s = pw.TextStyle();
            break;
          case "img":
            s = pw.TextStyle();
            break;
          case "li":
            s = pw.TextStyle();
            break;
          case "ol":
            s = pw.TextStyle();
            break;
          case "p":
            s = pw.TextStyle();
            break;
          case "pre":
            s = pw.TextStyle();
            break;

          case "ul":
            s = pw.TextStyle();
            break;
        }
        if (span.isNotEmpty) {
          text.add(pw.RichText(text: pw.TextSpan(children: span)));
          span = [];
        }
        if (s != null) {
          text.add(pw.Text(e.text, style: s));
        }
        break;
      case Node.TEXT_NODE:
        print(e);
        if (e.text.isNotEmpty) {}
    }

    var o = e.children;
    for (var k in o) {
      visit(k);
    }
  }
}

mdtopdf(String path, String out) async {
  print(Directory.current);
  final md2 = await File(path).readAsString();
  var htmlx = md.markdownToHtml(md2, inlineSyntaxes: [
    md.InlineHtmlSyntax()
  ], blockSyntaxes: [
    const md.TableSyntax(),
    md.FencedCodeBlockSyntax(),
    md.HeaderWithIdSyntax(),
    md.SetextHeaderWithIdSyntax(),
  ]);
  File("$out.html").writeAsString(htmlx);
  var document = parse(htmlx);
  final doc = pw.Document();
  Visitor(doc)
    ..visit(document.body)
    ..finish();
  File(out).writeAsBytes(await doc.save());
}
