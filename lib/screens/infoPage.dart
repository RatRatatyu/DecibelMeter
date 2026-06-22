import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../adaptationWidgets/appLayout.dart';

Future<String> loadMarkdown() async {
  return await rootBundle.loadString('assets/texts/ruText.md');
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    final layout = LayoutProvider.of(context);
    final titleL = Theme.of(context).textTheme.titleLarge;
    final headLineS = Theme.of(context).textTheme.headlineSmall;
    final bodyL = Theme.of(context).textTheme.bodyLarge;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: layout.sizes.iconMd,
        ),
        backgroundColor: colorScheme.primary,
        title: Text(
          "Information",
          style: titleL?.copyWith(
            color: Colors.white,
          )
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
                style: headLineS?.copyWith(
                    color: Colors.white
                ),
              ),
            );
          }

          return Markdown(
              data: snapshot.data!,
              styleSheet: MarkdownStyleSheet(
                h1: headLineS?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                h2: titleL?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                p: bodyL?.copyWith(
                  color: Colors.white
                ),
                strong: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

          );
        },
      ),
      backgroundColor: backgroundColor,
    );
  }
}
