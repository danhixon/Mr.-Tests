{
  collection: [
      { _id: 14, gender: "M", weight: 165 },
      { _id: 15, gender: "M", weight: 144 },
      { _id: 12, gender: "F", weight: 125 },
      { _id: 11, gender: "F", weight: 138 }
  ],
  expectedResults: [
    { gender: "M", value: 309 },
    { gender: "F", value: 263 }
  ],
  map: function() {
    emit({ gender: this.gender }, this.weight);
  },
  reduce: function(key, vals) {
    return vals.reduce(function(t, s) {
      return t + s;
    });
  }
}
