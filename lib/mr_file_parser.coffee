fs = require 'fs'
path = require 'path'
root = exports ? this

root.read_file = (file_path, callback) ->
  path.exists file_path, (exists) ->
    if exists
      fs.readFile file_path, "ascii", (err, mr_file_contents) ->
        throw err if err
        js = eval "(#{mr_file_contents})"
        callback js
    else
      throw "File not found: #{file_path}"
