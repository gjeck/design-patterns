const assert = require('assert');
const dijkstra = require('../index.js');
const shortest_path = dijkstra.shortest_path;

describe('Dijkstra\'s Algorithm', function() {
  it('should return a dictionary', function() {
    const result = shortest_path({}, 'a');
    assert.equal(typeof(result), 'object');
  });

  it('should resolve the shortest path', function() {
    const graph = {
      a: { b: 6, d: 1},
      b: { a: 6, d: 2, e: 2, c: 5 },
      c: { b: 5, e: 5 },
      d: { a: 1, b: 2, e: 1 },
      e: { d: 1, b: 2, c: 5 }
    };

    const expected_result = {
      dist: { a: 0, b: 3, c: 7, d: 1, e: 2 },
      prev: { a: null, b: 'd', c: 'e', d: 'a', e: 'd' }
    };

    const result = shortest_path(graph, 'a');
    assert.deepEqual(result, expected_result);
  });
});
