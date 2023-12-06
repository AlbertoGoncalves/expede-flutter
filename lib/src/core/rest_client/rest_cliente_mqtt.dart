import 'package:mqtt_client/mqtt_server_client.dart';

final class MqttRestClient extends MqttServerClient {
  MqttRestClient(super.server, super.clientIdentifier);

  // final client = MqttServerClient('broker.example.com', ''); // Substitua com suas credenciais
  // client.port = 1883;
  // client.logging(on: true);

  // MqttRestClient MqttServerClientonSubscribed(String topic) {
  //   print('EXAMPLE::Subscription confirmed for topic $topic');
  //   return this;
  // }

  // MqttRestClient onDisconnected() {
  //   print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  //   return this;
  // }
}
