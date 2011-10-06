map_reducer = require '../lib/mr_simulator'

describe 'map reduce simulator', ->
  it 'should perform a simple map reduction', ->
    people = [
      { _id: 14, gender: "M", weight: 165 },
      { _id: 15, gender: "M", weight: 144 },
      { _id: 12, gender: "F", weight: 125 },
      { _id: 11, gender: "F", weight: 138 }
    ]
    sums = [
      { gender: "M", value: 309 },
      { gender: "F", value: 263 }
    ]

    mr_set =
      map: ->
        this.emit { gender: this.gender }, this.weight
      reduce: (key, vals) ->
        sum = vals.reduce (t, s) -> t + s

    reduction = map_reducer.execute people, mr_set
    expect(reduction).toEqual sums

  it 'should handle the tags sample from mongodb.org', ->
    things = [
      { _id : 1, tags : ['dog', 'cat'] },
      { _id : 2, tags : ['cat'] },
      { _id : 3, tags : ['mouse', 'cat', 'dog'] },
      { _id : 4, tags : []  }
    ]
    expected_result = [
      { _id : 'dog', value : { count : 2 } },
      { _id : 'cat', value : { count : 3 } },
      { _id : 'mouse', value : { count : 1 } }
    ]

    mr_set =
      map: ->
        @tags.forEach (z) ->
          map_reducer.emit z, count: 1
      reduce: (key, values) ->
        total = 0
        i = 0

        while i < values.length
          total += values[i].count
          i++
        count: total

    reduction = map_reducer.execute things, mr_set
    expect(reduction).toEqual expected_result

#  it 'should handle ', ->

#
# from: http://nosql.mypopescu.com/post/394779847/mongodb-tutorial-mapreduce
#The MapReduce engine may invoke reduce functions iteratively; thus, these functions 
# must be idempotent. That is, the following must hold for your reduce function:
#for all k,vals : reduce( k, [reduce(k,vals)] ) == reduce(k,vals)
#Currently, the return value from a reduce function cannot be an array (it’s typically an object or a number).
#If you need to perform an operation only once, use a finalize function.
