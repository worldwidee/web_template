import 'dart:io';
import 'dart:math';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:furkanirmak/widgets.dart/expandedButton.dart';
import 'package:photo_view/photo_view.dart';
import 'package:painter/painter.dart';
import 'package:o_color_picker/o_color_picker.dart';
import '../main.dart';

class ZoomableImage extends StatefulWidget {
  double width, height, fontSize;
  Image image;
  Color backgroundcolor, textColor;
  ZoomableImage(
      {required this.width,
      required this.height,
      required this.fontSize,
      required this.image,
      required this.backgroundcolor,
      required this.textColor});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  double minRotate = pi * -2;
  double maxRotate = pi * 2;
  double minScale = 0.6;
  double maxScale = 5.0;
  double scaleValue = 0.6;
  double rotateValue = 0.0;
  double increase = 0.1;
  double defScale = 0.1;
  Color? selectedColor = Colors.black;
  late PhotoViewControllerBase controller;
  @override
  void initState() {
    controller = PhotoViewController();
    painterController = new PainterController();
    painterController.backgroundColor = Colors.transparent;
    painterController.thickness = 5;
    ex = widget.image;
    textStyle = TextStyle(color: Colors.white, fontSize: widget.fontSize);
    super.initState();
  }

  reset() {
    controller = PhotoViewController();
    minScale = 1.0;
    scaleValue = 1.0;
    rotateValue = 0.0;
    painterController.clear();
    index = 0;
  }

  @override
  void dispose() {
    painterController.dispose();
    controller.dispose();
    super.dispose();
  }

  late PainterController painterController;
  late Image ex = widget.image;
  late TextStyle textStyle;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (ex != widget.image) {
      reset();
      ex = widget.image;
    }
    return Container(
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            controller.scale != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${appText.scale} : ", style: textStyle),
                      Text(
                          controller.scale.toString().split(".")[0] +
                              "." +
                              controller.scale.toString().split(".")[1][0],
                          style: TextStyle(
                              color: Colors.red, fontSize: widget.fontSize))
                    ],
                  )
                : Text(""),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.orange,
                      thumbColor: Colors.orange,
                    ),
                    child: Container(
                      width: widget.width,
                      height: 20,
                      child: Slider(
                        value: scaleValue,
                        min: minScale,
                        max: maxScale,
                        onChanged: (double newScale) {
                          setState(() {
                            scaleValue = newScale;
                            controller.scale = newScale;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ExpandedButton(
                  onPressed: () {
                    setState(() {
                      scaleValue = minScale;
                      controller.scale = minScale;
                    });
                  },
                  flex: 2,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.refresh, color: Colors.white),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              appText.resetScale,
                              style: textStyle,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${appText.rotation} : ",
                  style: textStyle,
                ),
                Text(
                  "${controller.rotation.toString().split(".")[0]}.${controller.rotation.toString().split(".")[1][0]}",
                  style:
                      TextStyle(color: Colors.red, fontSize: widget.fontSize),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.orange,
                      thumbColor: Colors.orange,
                    ),
                    child: Container(
                      width: widget.width,
                      height: 20,
                      child: Slider(
                        value: rotateValue,
                        min: minRotate,
                        max: maxRotate,
                        onChanged: (double newRotation) {
                          controller.rotation = newRotation;
                          setState(() {
                            rotateValue = newRotation;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ExpandedButton(
                  flex: 2,
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      rotateValue = 0.0;
                      controller.rotation = 0.0;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.refresh, color: Colors.white),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              appText.resetRotate,
                              style: textStyle,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Listener(
                onPointerSignal: (pointerSignal) {
                  if (pointerSignal is PointerScrollEvent) {
                    if (index == 0) {
                      minScale = controller.scale!;
                      scaleValue = controller.scale!;
                      maxScale = minScale + 5;
                      index++;
                    }
                    if (pointerSignal.scrollDelta.dy < 0) {
                      if (scaleValue + increase <= maxScale)
                        setState(() {
                          scaleValue += increase;
                          controller.scale = scaleValue;
                        });
                      else if (scaleValue + increase > maxScale &&
                          scaleValue < maxScale)
                        setState(() {
                          scaleValue = maxScale;
                          controller.scale = scaleValue;
                        });
                    }
                    if (pointerSignal.scrollDelta.dy > 0) {
                      if (scaleValue - increase >= minScale)
                        setState(() {
                          scaleValue -= increase;
                          controller.scale = scaleValue;
                        });
                      else if (scaleValue - increase < minScale &&
                          scaleValue > minScale)
                        setState(() {
                          scaleValue = minScale;
                          controller.scale = scaleValue;
                        });
                    }
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(appText.color, style: textStyle),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                              (var states) => selectedColor!,
                            )),
                            child: Container(),
                            onPressed: () => showDialog<void>(
                              context: context,
                              builder: (_) => Material(
                                color: widget.backgroundcolor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    OColorPicker(
                                      selectedColor: selectedColor,
                                      colors: primaryColorsPalette,
                                      onColorChange: (color) {
                                        setState(() {
                                          selectedColor = color;
                                          painterController.drawColor =
                                              selectedColor!;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(appText.mode, style: textStyle),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: TextButton(
                              child: Icon(Boxicons.bx_eraser,
                                  color: selectedColor),
                              onPressed: () {
                                painterController.eraseMode = true;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextButton(
                              child: Icon(Icons.edit, color: selectedColor),
                              onPressed: () {
                                painterController.eraseMode = false;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(appText.thickness, style: textStyle),
                          ),
                          TextButton(
                            onPressed: () {
                              painterController.thickness = 5;
                            },
                            child: Icon(Boxicons.bx_circle,
                                color: selectedColor, size: 10),
                          ),
                          TextButton(
                            onPressed: () {
                              painterController.thickness = 7;
                            },
                            child: Icon(Boxicons.bx_circle,
                                color: selectedColor, size: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              painterController.thickness = 10;
                            },
                            child: Icon(Boxicons.bx_circle,
                                color: selectedColor, size: 20),
                          ),
                          TextButton(
                            onPressed: () {
                              painterController.thickness = 12;
                            },
                            child: Icon(Boxicons.bx_circle,
                                color: selectedColor, size: 25),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Stack(
                        children: [
                          PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: widget.backgroundcolor),
                            imageProvider: widget.image.image,
                            controller: controller,
                          ),
                          Painter(painterController)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
