import 'dart:io';
import 'dart:math';

class PortWarden {
  final _openPorts = <String, List<int>>{};

  Map<String, List<int>> get openPorts => _openPorts;

  Future<void> scan(String ipRange, int startPort, int endPort) async {
    final ipAddresses = await _getIPAddresses(ipRange);
    for (final ip in ipAddresses) {
      await _scanIPAddress(ip, startPort, endPort);
    }
  }

  void printResults() {
    for (final entry in _openPorts.entries) {
      stdout.writeln('Open ports on ${entry.key}: ${entry.value}');
    }
  }

  Future<void> _scanIPAddress(String ip, int startPort, int endPort) async {
    final openPorts = <int>[];
    for (var port = startPort; port <= endPort; port++) {
      try {
        await Socket.connect(ip, port, timeout: Duration(seconds: 1));
        openPorts.add(port);
      } catch (_) {}
    }
    if (openPorts.isNotEmpty) {
      _openPorts[ip] = openPorts;
    }
  }

  Future<List<String>> _getIPAddresses(String ipRange) async {
    final parts = ipRange.split('/');
    final baseIP = parts[0];
    final prefix = int.parse(parts[1]);
    final netmask = pow(2, 32 - prefix).toInt() - 1;
    final baseIPParts = baseIP.split('.').map(int.parse).toList();
    final startIP = _getIPAddress(baseIPParts);
    final endIP = startIP + netmask;
    return [for (var ip = startIP; ip <= endIP; ip++) _formatIPAddress(ip)];
  }

  int _getIPAddress(List<int> parts) =>
      (parts[0] << 24) + (parts[1] << 16) + (parts[2] << 8) + parts[3];

  String _formatIPAddress(int ip) =>
      '${(ip >> 24) & 0xFF}.${(ip >> 16) & 0xFF}.${(ip >> 8) & 0xFF}.${ip & 0xFF}';
}