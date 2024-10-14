import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/api_service.dart';
import '../widgets/footer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> transactions = [];
  double balance = 0.0;
  String _errorMessage = '';
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/deposit');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/withdraw');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/send-money');
        break;
    }
  }

  Future<void> fetchTransactions() async {
    final token = Provider.of<UserProvider>(context, listen: false).token;
    try {
      final data = await ApiService.fetchTransactions(token);
      setState(() {
        transactions = data['transactions'];
        balance = data['balance'];
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Text('Balance: \$${balance.toStringAsFixed(2)}'),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text('Amount: ${transaction['amount']}'),
                  subtitle: Text('Date: ${transaction['created_at']}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
