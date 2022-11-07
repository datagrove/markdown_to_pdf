import 'package:markdown_to_pdf/markdown_to_pdf.dart';
// import 'package:test/test.dart'; 

void main() async {
  await mdtopdf("test/test.md", "test/test.pdf");
}
