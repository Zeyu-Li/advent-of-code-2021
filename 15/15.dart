// run with `dart 15.dart`
// A* might be overkill so just do dijkstra 
import 'package:collection/collection.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:io';

// not matrix representation (too much memory and will be lots of 0s)
// class Graph {
//   List<List<int>> graphState;
//   List<List<int>> matrix = [];
//   Graph(this.graphState)

//   void buildGraph() {
//     // initialize matrix
//     for (int i = 0; i < 10000; i++) {
//       this.matrix.add([for (int j = 0; j < 10000; j++) 0])
//     }
//     for (int i = 0; i < 100; i++) {
//       for (int j = 0; j < 100; j++) {
//         // if in bounds add bidirectional edge
//         if (i+1 < 100) {
//           this.matrix[i][j] = graphState[i+1][j];
//         }
//         this.matrix.add([])
//       }
//     }
//   }
// }
// nodes and edges
class Edge {
  int x;
  int y;
  int weight;
  Edge(this.x, this.y, this.weight);
}

class Node {
  int x;
  int y;
  Set<Edge> edges;
  int dist_start = 1<<31;
  Node(this.x, this.y, {this.edges = const {}});
  
  @override
  int get hashCode => 17 + x.hashCode + y.hashCode;
  
  @override
  bool operator == (Object other) {
    return (other is Node) && this.x == other.x && this.y == other.y;
  }
}

class Graph {
  Set<Node> nodes;
  Graph(this.nodes);
}

void main() async {
  // read from file and place in matrix
  String file = "15.in";
  List<List<int>> matrix = [];
  await File(file)
    .openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => matrix.add([for (var char in line.split('')) int.parse(char)]));
    
  var nodes = <Node>{};
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      var edges = <Edge>{};
      if (i+1 < 100) {
        edges.add(Edge(i + 1, j, matrix[i + 1][j]));
      }
      if (j+1 < 100) {
        edges.add(Edge(i, j + 1, matrix[i][j + 1]));
      }
      if (i-1 >= 0) {
        edges.add(Edge(i - 1, j, matrix[i - 1][j]));
      }
      if (j-1 >= 0) {
        edges.add(Edge(i, j - 1, matrix[i][j - 1]));
      }
      nodes.add(Node(i, j, edges: edges));
    }
  }

  // initialize first as 0
  var visited = <Node>{};
  // set start to 0
  nodes.first.dist_start = 0;
  var openSet = new PriorityQueue<Node>((item1, item2) => item1.dist_start.compareTo(item2.dist_start));
  // enqueue starting node
  openSet.add(nodes.first);
  // while priority queue is not empty
  while (openSet.length != 0) {
    // print(openSet.length);
    // dequeue
    var currNode = openSet.removeFirst();
    // print(visited.length);
    // print(openSet.length);

    // break if we found the goal
    if (currNode == Node(99, 99)) {
      var dist = currNode.dist_start;
      print("Length = $dist");
      break;
    }

    // for edges
    for (var edge in currNode.edges) {
      var currEdge = Node(edge.x, edge.y);
      if (visited.contains(currEdge)) {
        continue;
      }
      currEdge = nodes.firstWhere((e) => e == currEdge);
      // added current node to visited
      openSet.add(currEdge);

      // update current dist
      if (currNode.dist_start + edge.weight < currEdge.dist_start) {
        currEdge.dist_start = currNode.dist_start + edge.weight;
      }
    }

    openSet.remove(currNode);
    visited.add(currNode);
  }
}
