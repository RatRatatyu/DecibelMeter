import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sound_metter/uiStyle/style.dart';

Future<String> loadMarkdown() async {
  return await rootBundle.loadString('assets/texts/ruText.md');
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: uiSize(context, 0.06),
        ),
        backgroundColor: colorScheme.primary,
        title: Text(
          "Information",
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize(context, 0.05),
          ),
        ),
      ),

      body: FutureBuilder<String>(
        future: loadMarkdown(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(Colors.deepPurple),));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.white, fontSize: textSize(context, 0.06)),
              ),
            );
          }

          return Markdown(
              data: snapshot.data!,
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                    fontSize: textSize(context, 0.06),
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                h2: TextStyle(
                    fontSize: textSize(context, 0.050),
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
                p: TextStyle(
                    fontSize: textSize(context, 0.05),
                    height: 1.5,
                    color: Colors.white
                ),
                strong: const TextStyle(fontWeight: FontWeight.bold),
              ),

          );
        },
      ),
      backgroundColor: backgroundColor,
    );
  }
}
