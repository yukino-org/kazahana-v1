import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:utilx/utilities/utils/enum.dart';
import './class.dart';
import '../../../../utils/webview/utils.dart';
import '../../model.dart';

class WebviewClassBinding extends HTExternalClass {
  WebviewClassBinding() : super('Webview');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
    final bool error = true,
  }) {
    switch (varName) {
      case 'Webview.create':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              Webview.createWebview(),
        );

      default:
        throw HTError.undefined(varName);
    }
  }

  @override
  dynamic instanceMemberGet(final dynamic object, final String varName) {
    final Webview webview = object as Webview;

    switch (varName) {
      case 'disposed':
        return webview.disposed;

      case 'open':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.open(
            positionalArgs.first as String,
            EnumUtils.find(
              WebviewWaitUntil.values,
              positionalArgs[1] as String,
            ),
          ),
        );

      case 'getHtml':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.getHtml(),
        );

      case 'evalJavascript':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.evalJavascript(positionalArgs.first as String),
        );

      case 'getCookies':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.getCookies(positionalArgs.first as String),
        );

      case 'deleteCookie':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.deleteCookie(
            positionalArgs.first as String,
            positionalArgs[1] as String,
          ),
        );

      case 'clearAllCookies':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.clearAllCookies(),
        );

      case 'addExtraHeaders':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.addExtraHeaders(
            parseHetuReturnedMap(positionalArgs[0]).cast<String, String?>(),
          ),
        );

      case 'dispose':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              webview.dispose(),
        );

      case 'tryBypassBrowserVerification':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              WebviewUtils.tryBypassBrowserVerification(
            webview.instance,
            (final String html) => (positionalArgs[0] as HTFunction)
                .call(positionalArgs: <dynamic>[html]) as bool,
          ),
        );

      case 'tryBypassCloudfareBrowserVerification':
        return createHTExternalFunction(
          (
            final HTEntity entity, {
            final List<dynamic> positionalArgs = const <dynamic>[],
            final Map<String, dynamic> namedArgs = const <String, dynamic>{},
            final List<HTType> typeArgs = const <HTType>[],
          }) =>
              WebviewUtils.tryBypassBrowserVerification(
            webview.instance,
            WebviewUtils.isCloudflareVerification,
          ),
        );

      default:
        throw HTError.undefined(varName);
    }
  }
}
