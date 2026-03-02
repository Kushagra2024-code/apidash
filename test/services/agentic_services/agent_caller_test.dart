import 'package:apidash/services/agentic_services/agent_caller.dart';
import 'package:apidash_core/apidash_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockAIAgent extends Mock implements AIAgent {}

void main() {
  group('APIDashAgentCaller', () {
    late MockWidgetRef mockRef;
    late MockAIAgent mockAgent;

    setUp(() {
      mockRef = MockWidgetRef();
      mockAgent = MockAIAgent();
    });

    test('throws Exception when no default AI model is set', () async {
      when(() => mockRef.read(any())).thenReturn(null);

      await expectLater(
        APIDashAgentCaller.instance.call(
          mockAgent,
          ref: mockRef,
          input: AgentInputs(query: 'test'),
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('NO_DEFAULT_LLM'),
          ),
        ),
      );
    });
  });
}
