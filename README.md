A Dart package to calculate catholic liturgy

## Features

* Calculate liturgy
* Provide liturgy descriptions in english and italian

## Getting started

To use this plugin, add `catholic_liturgy` as a [dependency in your pubspec.yaml file](https://plus.fluttercommunity.dev/docs/overview).

## Usage


```dart
import 'package:catholic_liturgy/catholic_liturgy.dart';
final liturgyModel = liturgy(date, isEpiphanyOn6thJan); //In anglophone country, Epiphany is usually not on 6th January, but on a Sunday, so the flag isEpiphanyOn6thJan should be false
initializeLanguage(LiturgyLanguage.it);
final liturgyDescription = liturgyDescriptions(liturgyModel, LiturgyLanguage.it);
```
