import 'package:test/test.dart';
import 'package:port_warden/port_warden.dart';

void main() {
  group('PortWarden', () {
    test('scans IP range and finds open ports', () async {
      final portWarden = PortWarden();
      await portWarden.scan('192.168.1.0/24', 80, 82);
      expect(portWarden.openPorts.keys, contains('192.168.1.1'));
      expect(portWarden.openPorts['192.168.1.1'], contains(80));
      expect(portWarden.openPorts['192.168.1.1'], contains(81));
      expect(portWarden.openPorts['192.168.1.1'], isNot(contains(82)));
    });

    test('handles errors during port scanning', () async {
      final portWarden = PortWarden();
      await portWarden.scan('10.0.0.0/24', 1, 65535);
      expect(portWarden.openPorts.keys, isNot(contains('10.0.0.1')));
    });
  });
}