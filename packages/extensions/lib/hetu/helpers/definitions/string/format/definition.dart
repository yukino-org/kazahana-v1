import './functions.dart';
import '../../../model.dart';

final HetuHelperFunction hStrFmtFunction = HetuHelperFunction(
  name: 'strFmt',
  definition: strFmt,
  declaration: '''
/// (
///   string,
///   Map<string, string>, {
///   startDelimiter: string?,
///   endDelimiter: string?,
/// }) => string
external fun strFmt(template, values, { startDelimiter, endDelimiter });
      '''
      .trim(),
);
