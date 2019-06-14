import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:yun_dao/entity_generator.dart';

Builder yunEntityGenerator(BuilderOptions options) =>
    LibraryBuilder(EntityGenerator(options), generatedExtension: '.dao.dart');

///flutter packages pub run build_runner build
