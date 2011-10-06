(function() {
  var emit, root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  emit = function(key, value) {
    console.log(key);
    return console.log(value);
  };
  root.execute = function(data, mr) {
    var datum, _results;
    mr.emit = emit;
    _results = [];
    for (datum in data) {
      _results.push(mr.map.apply(datum));
    }
    return _results;
  };
}).call(this);
