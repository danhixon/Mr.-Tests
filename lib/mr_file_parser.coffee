fs = require 'fs'
sys = require 'sys'
path = require 'path'
htmlparser = require "htmlparser"

root = exports ? this

root.read_file = (file_path, callback) ->
  path.exists file_path, (exists) ->
    if exists
      fs.readFile file_path, "ascii", (err, mr_file_contents) ->
        throw err if err
        js = ''
        handler = new htmlparser.DefaultHandler()

        parser = new htmlparser.Parser(handler)
        parser.parseComplete mr_file_contents
        # pretty brittle parser:
        js = handler.dom[2].children[1].children[0].raw
        callback eval("(#{js})")
    else
      throw "File not found: #{file_path}"
