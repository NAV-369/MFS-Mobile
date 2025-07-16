import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreditScorePage extends StatelessWidget {
  const CreditScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('AI Credit Score'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('dashboard'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreOverview(),
            const SizedBox(height: 32),
            _buildImprovementTips(),
            const SizedBox(height: 32),
            _buildFactorsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreOverview() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Your Credit Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: 0.8,
                      strokeWidth: 12,
                      backgroundColor: Color(0xFFECF0F1),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF27AE60)),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '80',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                              height: 0.9,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '%',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7F8C8D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'out of 100',
              style: TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
            ),
            SizedBox(height: 8),
            Text(
              'Excellent',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF27AE60)),
            ),
            SizedBox(height: 24),
            Text(
              'Your credit score is above average, which means you qualify for better loan terms.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
            ),
        ],
        ),
      ),
    );
  }

  Widget _buildImprovementTips() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Improve Your Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50)),
            ),
            SizedBox(height: 16),
            _TipItem(text: 'Make all loan payments on time'),
            _TipItem(text: 'Keep credit utilization below 30%'),
            _TipItem(text: 'Maintain a mix of different types of credit'),
            _TipItem(text: 'Avoid applying for multiple new loans in a short period'),
            _TipItem(text: 'Regularly check your credit report for errors'),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Factors Affecting Your Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50)),
            ),
            const SizedBox(height: 24),
            _FactorItem(
              title: 'Payment History',
              description: 'You have made all your payments on time.',
              impact: 'high',
              impactColor: Color(0xFFE74C3C),
            ),
            _FactorItem(
              title: 'Credit Utilization',
              description: 'You are using 30% of your available credit.',
              impact: 'medium',
              impactColor: Color(0xFFF39C12),
            ),
            _FactorItem(
              title: 'Loan Repayment',
              description: 'You have repaid 70% of your loans on time.',
              impact: 'medium',
              impactColor: Color(0xFFF39C12),
            ),
            _FactorItem(
              title: 'Credit History Length',
              description: 'Your credit history is relatively new.',
              impact: 'low',
              impactColor: Color(0xFF27AE60),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;
  
  const _TipItem({required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Color(0xFF3498DB)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactorItem extends StatelessWidget {
  final String title;
  final String description;
  final String impact;
  final Color impactColor;
  
  const _FactorItem({
    required this.title,
    required this.description,
    required this.impact,
    required this.impactColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50)),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
          ),
          const SizedBox(height: 8),
          Text(
            'impact: $impact',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: impactColor),
          ),
        ],
      ),
    );
  }
}