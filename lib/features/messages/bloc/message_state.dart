import 'package:mobile1_flutter_coding_test/app/index.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoadInProgress extends MessageState {}

class MessageLoadSuccess extends MessageState {
  final List<Message> messages;

  const MessageLoadSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessageLoadFailure extends MessageState {
  final String errorMessage;

  const MessageLoadFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
