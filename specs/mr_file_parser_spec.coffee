file_parser = require '../lib/mr_file_parser'
map_reducer = {}

describe 'file parser', ->
  beforeEach ->
    file_parser.read_file 'test_files/test.html', (mr) ->
      map_reducer = mr
    # the file is read asyncronously so we have to wait for it
    waitsFor ->
      map_reducer.map

  it 'should read the sample collection', ->
    expect(map_reducer.collection).toEqual [
      { _id: 14, gender: "M", weight: 165 },
      { _id: 15, gender: "M", weight: 144 },
      { _id: 12, gender: "F", weight: 125 },
      { _id: 11, gender: "F", weight: 138 }
    ]

  it 'should read the expected result', ->
    expect(map_reducer.expectedResults).toEqual [
      { gender: "M", value: 309 },
      { gender: "F", value: 265 }
    ]

  it 'should read the map method', ->
    expect(map_reducer.map).toBeDefined ->
      emit { gender: this.gender }, this.weight

  it 'should read the reduce method', ->
    expect(map_reducer.reduce(null,[2,3])).toEqual 5
