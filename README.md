# Markdown-To-PDF
Dart package for transforming markdown files to HTML and HTML to PDF.

## Run and Test

open test/test.dart, click debug.
fix code
repeat!

## Project Goal:
A package to convert markdown to html and the resulting html to PDF.

Leverage the following packages:
- [markdown](https://pub.dev/packages/markdown)
- [html](https://pub.dev/packages/html)
- [pdf](https://pub.dev/packages/pdf)

### Requirements:
- Pure Dart
- Works on all dart platforms including all flutter platforms
- Accepts box constraint
  - Returns amount of html rendered such that rendering can resume on a subsequent page
- Follow standards and requirements for publication on pub.dev
- Support enough html to support basic markdown
- Use the dart markdown extension to extend markdown

### Additional Features:
- Support for additional html embedded into markdown
  - Reference the [flutter_html](https://pub.dev/packages/flutter_html) as an example of a package that implements growing and extendible subset of html
- Be able to create a PDF of marp-style slide decks
  - [Marp Markdown](https://marp.app)
- We should have our own plugin system for html2pdf postprocessor. Maybe based on 
<script class='plugin'>{
 // json

}</script>

### Additional References:
- [Python Solution](https://weasyprint.org)
