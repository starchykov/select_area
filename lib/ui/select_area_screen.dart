import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectAreaScreen extends StatefulWidget {
  const SelectAreaScreen({super.key});

  @override
  State<SelectAreaScreen> createState() => _SelectAreaScreenState();
}

class _SelectAreaScreenState extends State<SelectAreaScreen> {
  double _currentSliderValue = 40;
  bool isSliding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('3 of 3', style: Theme.of(context).textTheme.titleMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton.outlined(onPressed: () {}, icon: const Icon(Icons.question_mark_outlined)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'How far are you willing to walk ?',
                style: Theme.of(context).textTheme.headlineLarge?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Center(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                            image: AssetImage('assets/images/map.png'),
                          ),
                          shape: BoxShape.circle,
                          color: Colors.black12,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          width: (constraints.maxWidth - 24) * (_currentSliderValue / 100),
                          height: (constraints.maxWidth - 24) * (_currentSliderValue / 100),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.white),
                            color: const Color(0x3f22a0ff),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.centerRight,
                            children: [
                              Positioned(
                                right: -24,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  clipBehavior: Clip.hardEdge,
                                  width: 24 * 2,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.black,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.chevron_left, color: Colors.white),
                                      Icon(Icons.chevron_right, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * .5,
                        alignment: Alignment.centerRight,
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 0,
                            thumbShape: SliderComponentShape.noOverlay,
                            overlayShape: SliderComponentShape.noOverlay,
                            showValueIndicator: ShowValueIndicator.never,
                            minThumbSeparation: 10,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Slider(
                              value: _currentSliderValue,
                              max: 100,
                              min: 40,
                              divisions: 10,
                              label: _currentSliderValue.round().toString(),
                              onChangeStart: (_) => setState(() => isSliding = true),
                              onChangeEnd: (_) => setState(() => isSliding = false),
                              onChanged: (double value) {
                                HapticFeedback.lightImpact();
                                setState(() => _currentSliderValue = value);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth,
                        child: Container(
                          width: isSliding ? 80.0 : 72.0,
                          height: isSliding ? 80.0 : 72.0,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (_currentSliderValue / 10).toString(),
                                style: TextStyle(
                                  fontSize: isSliding ? 28 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'min',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: double.maxFinite,
              margin: const EdgeInsets.all(16),
              child: FilledButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
