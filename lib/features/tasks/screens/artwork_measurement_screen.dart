import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workflow/features/tasks/custom_painters/measurement_painter.dart';
import 'package:workflow/features/tasks/data/edge.dart';
import 'package:workflow/features/tasks/data/marked_point.dart';

class ArtworkMeasurementScreen extends StatefulWidget {
  @override
  _ArtworkMeasurementScreenState createState() =>
      _ArtworkMeasurementScreenState();
}

class _ArtworkMeasurementScreenState extends State<ArtworkMeasurementScreen> {
  File? _imageFile;
  final List<MarkedPoint> _points = [];
  final List<Edge> _edges = [];

  MarkedPoint? _draggingPoint;

  bool _dimensionMode = false;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  void _addPoint(Offset localPosition) {
    // TODO: Check if can place point

    setState(() {
      final newPoint = MarkedPoint(localPosition);

      if (_points.isNotEmpty) {
        final lastPoint = _points.last;
        final Edge edge = Edge(lastPoint, newPoint);

        _edges.add(edge); // connect previous to new

        // build edge label that shows the length of the edge
        edge.labelText = "5.0";
      }
      _points.add(newPoint);
    });
  }

  MarkedPoint? _findPointNear(Offset position) {
    for (var point in _points) {
      if ((point.position - position).distance < 20) return point;
    }
    return null;
  }

  Edge? _findEdgeNear(Offset position) {
    for (var edge in _edges) {
      final path = Path()
        ..moveTo(edge.start.position.dx, edge.start.position.dy)
        ..lineTo(edge.end.position.dx, edge.end.position.dy);
      final pathMetrics = path.computeMetrics();
      for (var metric in pathMetrics) {
        final extractPath = metric.extractPath(0, metric.length);
        if (extractPath.contains(position)) return edge;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Measure Artwork")),
        floatingActionButton: FloatingActionButton(
          onPressed: _pickImage,
          child: Icon(Icons.image),
        ),
        body: _imageFile == null
            ? Center(child: Text("Select an image to start"))
            : Column(
                children: [
                  Expanded(
                    child: Listener(
                      onPointerDown: (event) {
                        final localPos = event.localPosition;
                        final tappedPoint = _findPointNear(localPos);

                        if (tappedPoint != null) {
                          _draggingPoint = tappedPoint;
                        } else {
                          // Deny the placement of the the dot if the user didn't mean to place it
                          // i.e., user is interacting with something else, might be the textfield to input dimensions

                          _addPoint(localPos); // Add new point
                        }
                      },
                      onPointerMove: (event) {
                        if (_draggingPoint != null) {
                          setState(() {
                            final index = _points.indexOf(_draggingPoint!);
                            if (index != -1) {
                              _points[index] = MarkedPoint(event.localPosition);
                              // Also update edges
                              for (var i = 0; i < _edges.length; i++) {
                                final edge = _edges[i];
                                if (edge.start == _draggingPoint) {
                                  _edges[i] = Edge(_points[index], edge.end,
                                      length: edge.length);
                                } else if (edge.end == _draggingPoint) {
                                  _edges[i] = Edge(edge.start, _points[index],
                                      length: edge.length);
                                }
                              }
                              _draggingPoint =
                                  _points[index]; // update reference
                            }
                          });
                        }
                      },
                      onPointerUp: (_) {
                        _draggingPoint = null;
                      },
                      child: Stack(
                        children: [
                          Image.file(_imageFile!,
                              fit: BoxFit.contain, width: double.infinity),
                          CustomPaint(
                            painter: MeasurementPainter(_points, _edges),
                            child: Container(),
                          ),

                          // Label Strings
                          ..._edges.map((edge) {
                            return edge.label();
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
