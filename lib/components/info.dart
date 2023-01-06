import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 210,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 26),
            const Text(
                "     mod(키보드입력:%):   13 mod 5 = 3     (13 ÷ 5 = 2 ⋯ 3)"),
            const SizedBox(height: 12),
            const Text("     ^(거듭제곱):   2 ^ 5 = 32     (= 2 × 2 × 2 × 2 × 2)"),
            const SizedBox(height: 12),
            const Text("     최대수:   999,999,999,999,999.9"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("     소수점아래:   최대 9자리"),
                Text("유효숫자:   최대 16       "),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 5),
                Switch(
                  activeThumbImage: const AssetImage("assets/images/equal.png"),
                  value: false,
                  onChanged: (value) {},
                  activeTrackColor: Colors.orange.shade200,
                  activeColor: Colors.orange.shade500,
                ),
                const Expanded(
                  child: Text(
                    "수식을 입력",
                    textAlign: TextAlign.start,
                  ),
                ),
                Switch(
                  activeThumbImage: const AssetImage("assets/images/equal.png"),
                  value: true,
                  onChanged: (value) {},
                  activeTrackColor: Colors.orange.shade200,
                  activeColor: Colors.orange.shade500,
                ),
                const Expanded(
                  child: Text(
                    "계산결과를 입력",
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
