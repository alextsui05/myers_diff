# 1.1.1 - 2020/05/28

* Align `WordDiff` behavior to [jsdiff](https://github.com/kpdecker/jsdiff)'s behavior
  * Preserves whitespace when recombining tokens
  * Behaves nicely around symbols, extended Latin script

# 1.1.0 - 2020/05/27

* Add `WordDiff`, which works like `CharDiff` except uses space-delimited words
  as the unit of difference.

# 1.0.0 - 2020/05/22

* Rename the diffing class `CharDiff` and put it under `MyersDiff` namespace

# 0.1.2 - 2020/02/16

* Optimization: Stop using Marshal for cloning paths

# 0.1.1 - 2019/11/23

- Fixed a bug in `build_values`

# 0.1.0 - 2019/02/28

- Initial minimal port of algorithm from jsdiff
