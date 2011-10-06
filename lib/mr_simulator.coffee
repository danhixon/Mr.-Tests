_ = require 'underscore'
root = exports ? this

root.emissions = []

root.emit = (key, value) ->
  if _.isString(key)
    key = { "_id": key }

  pushed = false
  for ii of root.emissions
    if _.isEqual root.emissions[ii].key , key
      root.emissions[ii].values.push value
      pushed = true
  if !pushed
    root.emissions.push { key: key, values: [value] }

root.execute = (data, mr) ->
  for ii of data
    datum = data[ii]
    datum.emit = root.emit
    mr.map.call datum

  results = for ii,item of root.emissions
    r = item.key
    r.value = mr.reduce(item.key, item.values)
    r
  # don't need this anymore
  root.emissions = []
  results
