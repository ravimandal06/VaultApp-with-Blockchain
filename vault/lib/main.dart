import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accountAddress = '';
  final Web3 _web3 = Web3(
    InfuraProvider.getProvider(
        'https://sepolia.infura.io/v3/YOUR_INFURA_ID', 'eth-sepolia'),
  );

  Future<void> _connect() async {
    // Connect to Ethereum
    final eth = await _web3.eth.getBlockNumber();
    print('Connected to Ethereum: $eth');

    // Get accounts
    final accounts = await _web3.eth.getAccounts();
    setState(() {
      _accountAddress = accounts[0];
    });

    // Listen for account changes
    final subscription = _web3.eth.accountsChanged.listen((newAccounts) {
      setState(() {
        _accountAddress = newAccounts[0];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Account Address: $_accountAddress'),
          ],
        ),
      ),
    );
  }
}
