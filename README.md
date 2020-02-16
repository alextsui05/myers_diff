A Ruby implementation of the Myers diff algorithm.

Basically a minimal and incomplete port of the [jsdiff](https://github.com/kpdecker/jsdiff) Javascript library.

# Links

* Algorithm paper: http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.4.6927
* Reference JS implementation: https://github.com/kpdecker/jsdiff

# Usage

You can use `MyersDiff#diff(s1, s2)` to calculate an edit script that changes a string `s1` into `s2`.
The return value is an edit script, represented as an array of edit commands.
The edit commands are hashes that are formatted in three ways:

1. Match: `{ count: <integer>, value: <string> }`
2. Add: `{ count: <integer>, added: true, value: <string> }`
3. Remove: `{ count: <integer>, removed: true, value: <string> }`

```.rb
diff = MyersDiff.new
diff.diff('abcabba', 'cbabac')

 => [{:count=>1, :added=>nil, :removed=>true, :value=>"a"}, {:count=>1, :added=>true, :removed=>nil, :value=>"c"}, {:count=>1, :value=>"b"}, {:count=>1, :added=>nil, :removed=>true, :value=>"c"}, {:count=>2, :value=>"ab"}, {:count=>1, :added=>nil, :removed=>true, :value=>"b"}, {:count=>1, :value=>"a"}, {:count=>1, :added=>true, :removed=>nil, :value=>"c"}]
```

# License

[MIT](https://opensource.org/licenses/MIT)
