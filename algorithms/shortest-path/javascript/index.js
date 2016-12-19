function shortest_path(graph, source) {
  var dist = {},
      prev = {},
      q = [];

  Object.keys(graph).forEach(node => {
    dist[node] = Infinity;
    prev[node] = null;
    q.push(node);
  });

  dist[source] = 0;

  while (q.length > 0) {
    var u = Infinity,
      to_remove = null;
    q.forEach(([node, index]) => {
      if (dist[node] < u) {
        u = node;
        to_remove = index;
      }
    });
    q.splice(to_remove, 1);
    
    Object.keys(graph[u]).forEach(node => {
      var alt = dist[u] + graph[u][node];
      if (alt < dist[node]) {
        dist[node] = alt;
        prev[node] = u;
      }
    });
  }

  return { dist: dist, prev: prev };
}

if (typeof(module) !== 'undefined' && module.exports != null) {
  exports.shortest_path = shortest_path;
}
