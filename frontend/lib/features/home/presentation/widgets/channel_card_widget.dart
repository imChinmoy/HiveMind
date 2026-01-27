import 'package:flutter/material.dart';

class ChannelCardWidget extends StatefulWidget {
  final String thumbnail;
  final String title;
  final int subscriberCount;
  final VoidCallback callback;

  const ChannelCardWidget({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subscriberCount,
    required this.callback,
  });

  @override
  _ChannelCardWidgetState createState() => _ChannelCardWidgetState();
}

class _ChannelCardWidgetState extends State<ChannelCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha(150),
                      Colors.black.withAlpha(0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: Theme.of(context).textTheme.headlineSmall),
                      Text('${widget.subscriberCount} subscribers', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),        
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.policy, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],    
        ),
        clipBehavior: Clip.antiAlias,
        foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(0),
                Colors.black.withAlpha(150),
              ],
            )
        )
      ),
    );
  }
}
