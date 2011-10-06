Mr. Tests
============
<img src="https://danhixon.s3.amazonaws.com/mr-tests.jpg" alt="Meet Mr.
Tests!" style="display:block;float:right" />

Mongo MapReduce Tests

Software in nacent stages. Please ignore unless you want to help.

The idea is to make MongoDB MapReduce functions testable.  I see
MapReduce examples online where javascript functions are stored as
strings in another programming language like this:

![javascript functions stored as strings in ruby... yuck,
right?](https://danhixon.s3.amazonaws.com/js-functions-as-strings-in-ruby.png)

[Kyle Banker's Mongodb Resource](http://kylebanker.com/blog/2009/12/mongodb-map-reduce-basics/)
is excellent. The above example should not reflect poorly on him.

So, let's put our javascript into .js files (or .coffee!) and write
specs for them, right? It sounds like something the cool kids would want
you to do anyway.


Installation
------------

These instructions are aspirational and written as a goal for me since
at time of writing there is no "installation", just code.

$ npm install mr_tests

Usage
-----

These instructions are also aspiration. Since there is no install or
anything more than a few crude code files.

~/your_project/ $ mr_tests js/path_to_mr_files

MR Files
--------

I'm hoping that if they are stored as JSON languages like ruby will be
able to parse them as YAML in order to pull the strings out.

weight_sums_by_gender.mr.yaml:

map: function() { emit( { gender: this.gender }, this.weight }
reduce: function (key, vals) { sum = vals.reduce(function(t,s) { return t + s }
sampleSet: [
      { _id: 14, gender: "M", weight: 165 },
      { _id: 15, gender: "M", weight: 144 },
      { _id: 12, gender: "F", weight: 125 },
      { _id: 11, gender: "F", weight: 138 }
  ]
expectedResult: [
  { gender: "M", value: 309 },
  { gender: "F", value: 263 }
  ]

Then in your application code you could parse the yaml and get the
functions as strings since that is how your mongo driver want them.


Enjoy!

License
-------

Mr. Tests is Copyright © 2011 Dan Hixon. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
