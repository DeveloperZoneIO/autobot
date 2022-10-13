import 'package:fpdart/fpdart.dart';

part 'when_handler.dart';
part 'initial_when_handler.dart';
part 'then_handler.dart';
part 'option_extension.dart';
part 'when_chain.dart';
part 'when_chain_holder.dart';
part 'when_chain_entry.dart';
part 'statement_holder.dart';

// Global accessor functions exposing the functional expression functionality

/// Starts a functional if-else expression
InitialWhen when(bool statement) => InitialWhen._(() => statement);

/// Starts a functional if-else expression which returns the explicit type of [T].
When<T> whenTyped<T>(bool statement) => When<T>(WhenChain<T>._(), () => statement);
