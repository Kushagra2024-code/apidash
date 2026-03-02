import 'package:apidash/services/agentic_services/agents/agents.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponseSemanticAnalyser', () {
    late ResponseSemanticAnalyser agent;

    setUp(() {
      agent = ResponseSemanticAnalyser();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'RESP_SEMANTIC_ANALYSER');
    });

    test('validator always returns true', () async {
      expect(await agent.validator('any response'), isTrue);
      expect(await agent.validator(''), isTrue);
    });

    test('outputFormatter returns SEMANTIC_ANALYSIS key', () async {
      final result = await agent.outputFormatter('some analysis');
      expect(result, {'SEMANTIC_ANALYSIS': 'some analysis'});
    });
  });

  group('IntermediateRepresentationGen', () {
    late IntermediateRepresentationGen agent;

    setUp(() {
      agent = IntermediateRepresentationGen();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'INTERMEDIATE_REP_GEN');
    });

    test('validator always returns true', () async {
      expect(await agent.validator('any response'), isTrue);
    });

    test('outputFormatter strips yaml code fences', () async {
      final result =
          await agent.outputFormatter('```yaml\nkey: value\n```');
      expect((result as Map)['INTERMEDIATE_REPRESENTATION'],
          '\nkey: value\n');
    });

    test('outputFormatter returns plain text unchanged', () async {
      final result = await agent.outputFormatter('key: value');
      expect((result as Map)['INTERMEDIATE_REPRESENTATION'], 'key: value');
    });
  });

  group('StacGenBot', () {
    late StacGenBot agent;

    setUp(() {
      agent = StacGenBot();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'STAC_GEN');
    });

    test('validator returns true for valid JSON', () async {
      expect(await agent.validator('{"key": "value"}'), isTrue);
    });

    test('validator returns true for JSON wrapped in code fences', () async {
      expect(
          await agent.validator('```json\n{"key": "value"}\n```'), isTrue);
    });

    test('validator returns false for invalid JSON', () async {
      expect(await agent.validator('not json'), isFalse);
    });

    test('outputFormatter strips json code fences', () async {
      final result =
          await agent.outputFormatter('```json\n{"key":"value"}\n```');
      expect((result as Map)['STAC'], '\n{"key":"value"}\n');
    });

    test('outputFormatter replaces bold with w700', () async {
      final result = await agent.outputFormatter('{"fontWeight": "bold"}');
      expect((result as Map)['STAC'], '{"fontWeight": "w700"}');
    });
  });

  group('StacModifierBot', () {
    late StacModifierBot agent;

    setUp(() {
      agent = StacModifierBot();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'STAC_MODIFIER');
    });

    test('validator returns true for valid JSON', () async {
      expect(await agent.validator('{"key": "value"}'), isTrue);
    });

    test('validator returns false for invalid JSON', () async {
      expect(await agent.validator('bad json'), isFalse);
    });

    test('outputFormatter replaces bold with w700', () async {
      final result = await agent.outputFormatter('{"fontWeight": "bold"}');
      expect((result as Map)['STAC'], '{"fontWeight": "w700"}');
    });
  });

  group('StacToFlutterBot', () {
    late StacToFlutterBot agent;

    setUp(() {
      agent = StacToFlutterBot();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'STAC_TO_FLUTTER');
    });

    test('validator always returns true', () async {
      expect(await agent.validator('any response'), isTrue);
    });

    test('outputFormatter strips dart code fences', () async {
      final result =
          await agent.outputFormatter('```dart\nvoid main(){}\n```');
      expect((result as Map)['CODE'], '\nvoid main(){}\n');
    });

    test('outputFormatter returns plain code unchanged', () async {
      final result = await agent.outputFormatter('void main(){}');
      expect((result as Map)['CODE'], 'void main(){}');
    });
  });

  group('APIToolFunctionGenerator', () {
    late APIToolFunctionGenerator agent;

    setUp(() {
      agent = APIToolFunctionGenerator();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'APITOOL_FUNCGEN');
    });

    test('validator always returns true', () async {
      expect(await agent.validator('any response'), isTrue);
    });

    test('outputFormatter strips python code fences', () async {
      final result =
          await agent.outputFormatter('```python\ndef foo(): pass\n```');
      expect((result as Map)['FUNC'], '\ndef foo(): pass\n');
    });

    test('outputFormatter strips javascript code fences', () async {
      final result =
          await agent.outputFormatter('```javascript\nfunction foo(){}\n```');
      expect((result as Map)['FUNC'], '\nfunction foo(){}\n');
    });
  });

  group('ApiToolBodyGen', () {
    late ApiToolBodyGen agent;

    setUp(() {
      agent = ApiToolBodyGen();
    });

    test('agentName is correct', () {
      expect(agent.agentName, 'APITOOL_BODYGEN');
    });

    test('validator always returns true', () async {
      expect(await agent.validator('any response'), isTrue);
    });

    test('outputFormatter strips python code fences', () async {
      final result =
          await agent.outputFormatter('```python\ndef foo(): pass\n```');
      expect((result as Map)['TOOL'], '\ndef foo(): pass\n');
    });

    test('outputFormatter strips javascript code fences', () async {
      final result =
          await agent.outputFormatter('```javascript\nfunction foo(){}\n```');
      expect((result as Map)['TOOL'], '\nfunction foo(){}\n');
    });
  });
}
