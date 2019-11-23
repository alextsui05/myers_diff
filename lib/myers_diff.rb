class MyersDiff
  def diff(s1, s2, **options)
    old_string = cast_input(s1)
    new_string = cast_input(s2)

    old_string = remove_empty(tokenize(old_string))
    new_string = remove_empty(tokenize(new_string))

    new_len = new_string.size
    old_len = old_string.size
    edit_length = 1
    max_edit_length = new_len + old_len
    best_path = { }
    best_path[0] = { new_pos: -1, components: [] }

    old_pos = extract_common(best_path[0], new_string, old_string, 0)
    if best_path[0][:new_pos] + 1 >= new_len && old_pos + 1 >= old_len
      return [ { value: join(new_string), count: new_string.size } ]
    end

    exec_edit_length = lambda do
      diagonal_path = -1 * edit_length
      while diagonal_path <= edit_length
        add_path = best_path[diagonal_path - 1]
        remove_path = best_path[diagonal_path + 1]
        old_pos = (remove_path ? remove_path[:new_pos] : 0) - diagonal_path
        best_path[diagonal_path - 1] = nil if add_path

        can_add = add_path && add_path[:new_pos] + 1 < new_len
        can_remove = remove_path && 0 <= old_pos && old_pos < old_len
        if !can_add && !can_remove
          best_path[diagonal_path] = nil
          diagonal_path += 2
          next
        end

        base_path = if !can_add || (can_remove && add_path[:new_pos] < remove_path[:new_pos])
          p = clone(remove_path)
          push_component(p[:components], nil, true)
          p
        else
          p = add_path
          p[:new_pos] += 1
          push_component(p[:components], true, nil)
          p
        end

        old_pos = extract_common(base_path, new_string, old_string, diagonal_path)

        if base_path[:new_pos] + 1 >= new_len && old_pos + 1 >= old_len
          return build_values(base_path[:components], new_string, old_string)
        else
          best_path[diagonal_path] = base_path
        end

        diagonal_path += 2
      end

      edit_length += 1
      nil
    end

    while edit_length <= max_edit_length
      if res = exec_edit_length.call
        return res
      end
    end

    'death'
  end

  def push_component(components, added, removed)
    last = components.last
    if last && last[:added] == added && last[:removed] == removed
      components[-1] = clone(last).tap { |this| this[:count] += 1 }
    else
      components.push(count: 1, added: added, removed: removed)
    end
  end

  # base_path : { new_pos: int, components: [] }
  # diagonal_path : int
  def extract_common(base_path, new_string, old_string, diagonal_path)
    new_len = new_string.size
    old_len = old_string.size
    new_pos = base_path[:new_pos]
    old_pos = new_pos - diagonal_path
    common_count = 0

    while new_pos + 1 < new_len && old_pos + 1 < old_len && equals(new_string[new_pos + 1], old_string[old_pos + 1])
      new_pos += 1
      old_pos += 1
      common_count += 1
    end

    if common_count > 0
      base_path[:components].push(count: common_count)
    end

    base_path[:new_pos] = new_pos
    old_pos
  end

  def equals(l, r)
    l == r
    # TODO: support custom comparator
    # TODO: support case-insensitive
  end

  def remove_empty(array)
    array.compact
  end

  def cast_input(str)
    str
  end

  def tokenize(str)
    str.split('')
  end

  def join(chars)
    chars.join('')
  end

  # new_string - tokenized string i.e. array of strings
  def build_values(components, new_string, old_string, use_longest_token = true)
    component_pos = 0
    component_len = components.size
    new_pos = 0
    old_pos = 0

    while component_pos < component_len
      component = components[component_pos]
      if !component[:removed]
        if !component[:added] && use_longest_token
          value = new_string[new_pos, component[:count]]
          value = value.map.with_index do |val, i|
            old_val = old_string[old_pos + i]
            old_val.size > val.size ? old_val : val
          end

          component[:value] = join(value)
        else
          component[:value] = join(new_string[new_pos, component[:count]])
        end

        new_pos += component[:count]
        old_pos += component[:count] unless component[:added]
      else
        component[:value] = join(old_string[old_pos, component[:count]])
        old_pos += component[:count]

        if component_pos && 0 <= component_pos - 1 && components[component_pos - 1][:added]
          tmp = components[component_pos - 1]
          components[component_pos - 1] = components[component_pos]
          components[component_pos] = tmp
        end
      end

      component_pos += 1
    end

    last_component = components[component_len - 1]
    if component_len > 1 &&
        last_component[:value].is_a?(String) &&
        (last_component[:added] || last_component[:removed]) &&
        equals('', last_component[:value])
      components[component_len - 2][:value] += last_component[:value]
      components.pop
    end

    components
  end

  def clone(o)
    Marshal.load(Marshal.dump(o))
  end
end
