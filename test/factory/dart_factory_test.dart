// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: invalid_use_of_protected_member
@TestOn('browser')
import 'dart:js';

import 'package:test/test.dart';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart';
import 'package:react/react_client/react_interop.dart';

import '../util.dart';
import 'common_factory_tests.dart';

main() {
  setClientConfiguration();

  group('ReactDartComponentFactoryProxy', () {
    test('has a type corresponding to the backing JS class', () {
      expect(Foo.type, equals(Foo.reactClass));
    });

    group('- common factory behavior -', () {
      group('Component -', () {
        group('- common factory behavior -', () {
          commonFactoryTests(Foo, isComponent2: false);
        });

        group('- refs -', () {
          refTests<_Foo>(Foo, verifyRefValue: (ref) {
            expect(ref, TypeMatcher<_Foo>());
          });
        });
      });

      group('Component2 -', () {
        group('- common factory behavior -', () {
          commonFactoryTests(Foo2, isComponent2: true);
        });

        group('- refs -', () {
          refTests<_Foo2>(Foo2, verifyRefValue: (ref) {
            expect(ref, TypeMatcher<_Foo2>());
          });
        });
      });

      group('utils', () {
        test('ReactDartComponentVersion.fromType', () {
          expect(ReactDartComponentVersion.fromType(react.div({}).type), isNull);
          expect(ReactDartComponentVersion.fromType(JsFoo({}).type), isNull);
          expect(ReactDartComponentVersion.fromType(Foo({}).type), ReactDartComponentVersion.component);
          expect(ReactDartComponentVersion.fromType(Foo2({}).type), ReactDartComponentVersion.component2);
        });
      });

      group('test utils', () {
        // todo move somewhere else
        test('isDartComponent2', () {
          expect(isDartComponent2(react.div({})), isFalse);
          expect(isDartComponent2(JsFoo({})), isFalse);
          expect(isDartComponent2(Foo({})), isFalse);
          expect(isDartComponent2(Foo2({})), isTrue);
        });

        test('isDartComponent1', () {
          expect(isDartComponent1(react.div({})), isFalse);
          expect(isDartComponent1(JsFoo({})), isFalse);
          expect(isDartComponent1(Foo({})), isTrue);
          expect(isDartComponent1(Foo2({})), isFalse);
        });

        test('isDartComponent', () {
          expect(isDartComponent(react.div({})), isFalse);
          expect(isDartComponent(JsFoo({})), isFalse);
          expect(isDartComponent(Foo({})), isTrue);
          expect(isDartComponent(Foo2({})), isTrue);
        });
      });
    });
  });
}

final Foo = react.registerComponent(() => new _Foo()) as ReactDartComponentFactoryProxy;

class _Foo extends react.Component {
  @override
  render() => react.div({});
}

final Foo2 = react.registerComponent(() => new _Foo2()) as ReactDartComponentFactoryProxy2;

class _Foo2 extends react.Component2 {
  @override
  render() => react.div({});
}

final JsFoo = ReactJsComponentFactoryProxy(React.createClass(ReactClassConfig(
  displayName: 'JsFoo',
  render: allowInterop(() => react.div({})),
)));
