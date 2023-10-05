import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.detailTileEdgeInsets,
    required this.isValid,
  });

  final EdgeInsets detailTileEdgeInsets;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: detailTileEdgeInsets,
      child: Row(
        children: [
          const Text(
            "Status: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            isValid ? "Valid" : "Expired",
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
