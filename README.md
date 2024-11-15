# PortWarden

PortWarden is a command-line tool written in Dart that scans a given IP address range and reports the open ports on each IP address.

## Features

- Scans a specified IP range for open ports
- Supports configurable port range
- Outputs a list of IP addresses and their open ports
- Handles errors during the scanning process

## Installation

1. Ensure you have Dart installed on your system.
2. Clone the repository or download the source files.
3. Navigate to the project directory and run the application using the following command:

```
dart run bin/port_warden.dart
```

## Usage

By default, PortWarden will scan the `192.168.1.0/24` IP range for open ports between 1 and 1024. You can customize the IP range and port range by modifying the arguments passed to the `scan()` method in the `bin/port_warden.dart` file.

```dart
final portWarden = PortWarden();
await portWarden.scan('10.0.0.0/24', 80, 443);
portWarden.printResults();
```

This will scan the `10.0.0.0/24` IP range for open ports between 80 and 443.

## Testing

PortWarden includes a set of unit tests to ensure the correctness of the port scanning functionality. You can run the tests using the following command:

```
dart test
```

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.