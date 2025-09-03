import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';


class CreditScorePage extends StatelessWidget {
  const CreditScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with provider-backed score + factors
    const score = 712; // 300 - 850
    const band = 'Good';

    Color bandColor(int s) {
      if (s >= 800) return Colors.greenAccent;
      if (s >= 740) return Colors.lightGreenAccent;
      if (s >= 670) return Colors.yellowAccent;
      if (s >= 580) return Colors.orangeAccent;
      return Colors.redAccent;
    }

    Widget gauge(int s) {
      final value = ((s - 300) / (850 - 300)).clamp(0.0, 1.0);
      return SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 160, width: 160,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 12,
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation<Color>(bandColor(s)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$s', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                Text(band, style: TextStyle(color: bandColor(s), fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      );
    }

    Widget factor(String name, String status) {
      final color = status == 'Excellent'
          ? Colors.greenAccent
          : status == 'Good'
              ? Colors.lightGreenAccent
              : status == 'Fair'
                  ? Colors.yellowAccent
                  : Colors.orangeAccent;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: color.withOpacity(0.35)),
            ),
            child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Credit Score'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            child: Column(
              children: [
                gauge(score),
                const SizedBox(height: 8),
                Text('Range: 300 – 850', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Score Factors', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                factor('Payment History', 'Good'),
                const SizedBox(height: 10),
                factor('Utilization', 'Fair'),
                const SizedBox(height: 10),
                factor('Credit Age', 'Good'),
                const SizedBox(height: 10),
                factor('Recent Inquiries', 'Excellent'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tips to Improve', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                ...[
                  'Keep utilization under 30%',
                  'Avoid late payments',
                  'Limit new credit applications',
                  'Maintain older accounts',
                ].map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 6, height: 6,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(t, style: TextStyle(color: Colors.white.withOpacity(0.9)))),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}