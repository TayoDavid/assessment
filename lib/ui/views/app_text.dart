import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.color,
    this.align,
    this.size,
    this.weight,
    this.spacing,
    this.height,
    this.maxLines,
    this.overflow,
    this.underline,
    this.textStyle,
    this.fontFamily,
  });

  final String text;
  final Color? color;
  final TextAlign? align;
  final double? size;
  final FontWeight? weight;
  final double? spacing;
  final double? height;
  final int? maxLines;
  final String? fontFamily;
  final TextOverflow? overflow;
  final TextDecoration? underline;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle?.copyWith(
            height: height,
            fontSize: size,
            letterSpacing: spacing,
            color: color,
            fontWeight: weight,
            decoration: underline,
          ) ??
          TextStyle(
            height: height,
            fontSize: size ?? 16,
            letterSpacing: spacing,
            color: color ?? Theme.of(context).colorScheme.onBackground,
            fontWeight: weight ?? FontWeight.w400,
            decoration: underline ?? TextDecoration.none,
          ),
    );
  }
}

class HeadingSmall extends StatelessWidget {
  const HeadingSmall(this.title, {super.key, this.align, this.overflow});

  final String title;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      textStyle: Theme.of(context).textTheme.headlineSmall,
      align: align ?? TextAlign.center,
      overflow: overflow,
    );
  }
}

class HeadingMedium extends StatelessWidget {
  const HeadingMedium(this.title,
      {super.key, this.color, this.align, this.overflow});

  final String title;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      color: color,
      textStyle: Theme.of(context).textTheme.headlineMedium,
      align: align ?? TextAlign.center,
      overflow: overflow,
      maxLines: 1,
    );
  }
}

class HeadingLarge extends StatelessWidget {
  const HeadingLarge(this.title, {super.key, this.align, this.overflow});

  final String title;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      textStyle: Theme.of(context).textTheme.headlineLarge,
      align: align ?? TextAlign.center,
      overflow: overflow,
    );
  }
}

class DisplayTextLarge extends StatelessWidget {
  const DisplayTextLarge(this.title, {super.key, this.align, this.overflow});

  final String title;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      textStyle: Theme.of(context).textTheme.displayLarge,
      align: align ?? TextAlign.center,
      overflow: overflow,
    );
  }
}

class DisplayTextMedium extends StatelessWidget {
  const DisplayTextMedium(this.title, {super.key, this.align, this.overflow});

  final String title;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      textStyle: Theme.of(context).textTheme.displayMedium,
      align: align ?? TextAlign.center,
      overflow: overflow,
    );
  }
}

class DisplayTextSmall extends StatelessWidget {
  const DisplayTextSmall(this.title, {super.key, this.align, this.overflow});

  final String title;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      textStyle: Theme.of(context).textTheme.displaySmall,
      align: align ?? TextAlign.center,
      overflow: overflow,
    );
  }
}
