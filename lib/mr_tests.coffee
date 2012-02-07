util = require 'util'
file_parser = require './mr_file_parser'
simulator = require './mr_simulator'
exports = exports ? this
exports.passing_tests = 0
exports.failing_tests = 0

exports.test_file = (path) ->
	file_parser.read_file path, (mr) ->
		results = simulator.execute mr.collection, mr
		# sigh... string comparison.
		# I'd love to use jasmine to compare these two
		# objects but I couldn't figure it out today.
		#if util.inspect(results)==util.inspect(mr.expectedResults)
		if collections_equal(results, mr.expectedResults)
			exports.passing_tests += 1
			process.stdout.write(".")
		else
			exports.failing_tests += 1
			console.log "expected:"
			console.log mr.expectedResults
			console.log "but was:"
			console.log results

collections_equal = (a,b) ->
	if a.length != b.length
		return false

	for document, i in a
		if !documents_equal(a[i],b[i])
			return false

	return true
	
documents_equal = (a,b) ->
	for k,v of a
		if util.inspect(a[k])!=util.inspect(b[k])
			return false
	return true


program = require("commander")
program.version("0.0.1").usage('<file list or folder path>').parse process.argv

exports.test_file p for p in program.args


process.on 'exit', ->
  console.log "\nPassing Tests: #{exports.passing_tests}, Failing: #{exports.failing_tests}"
