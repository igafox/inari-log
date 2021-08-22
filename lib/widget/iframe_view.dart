//ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IframeView extends StatelessWidget {
  final String source;

  const IframeView({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomId = Random().nextDouble();

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'iframe-element${randomId}',
        (int viewId) => IFrameElement()
          ..src = source
          ..style.border = 'none');
    return HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframe-element${randomId}',
    );
  }
}
// class _IframeViewState extends State<IframeView> {
//   //Widget _iframeWidget;
//   final IFrameElement _iframeElement= IFrameElement();
//   @override
//   void initState() {
//     super.initState();
//     _iframeElement.src= widget.source;
//     _iframeElement.style.border= 'none';
//     //ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeElement',
//           (int viewId)=> _iframeElement,
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return HtmlElementView(
//       key: UniqueKey(),
//       viewType: 'iframeElement',
//     );
//   }
// }
