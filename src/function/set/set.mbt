// mathjs set 库的 MoonBit 实现

// ================ 工具函数 ================

// 展平数组（将多维数组转换为一维数组）
pub fn flatten[T](arr: Array[Array[T]]) -> Array[T] {
  let result: Array[T] = []
  let mut i = 0
  while i < arr.length() {
    let mut j = 0
    while j < arr[i].length() {
      result.push(arr[i][j])
      j = j + 1
    }
    i = i + 1
  }
  return result
}

// 将一维数组转换为多维数组
pub fn unflatten[T](arr: Array[T], rows: Int, cols: Int) -> Array[Array[T]] {
  let result: Array[Array[T]] = []
  let mut i = 0
  while i < rows {
    let row: Array[T] = []
    let mut j = 0
    while j < cols {
      if i * cols + j < arr.length() {
        row.push(arr[i * cols + j])
      }
      j = j + 1
    }
    result.push(row)
    i = i + 1
  }
  return result
}

// 比较两个值（仅支持整数比较）
pub fn compare_natural(a: Int, b: Int) -> Int {
  if a == b {
    return 0
  } else if a > b {
    return 1
  } else {
    return -1
  }
}

// 数组排序（简单冒泡排序）
pub fn sort(arr: Array[Int]) -> Array[Int] {
  let result: Array[Int] = []
  // 先将所有元素复制到新数组
  let mut i = 0
  while i < arr.length() {
    result.push(arr[i])
    i = i + 1
  }
  
  // 冒泡排序
  i = 0
  while i < result.length() {
    let mut j = 0
    while j < result.length() - i - 1 {
      if compare_natural(result[j], result[j + 1]) > 0 {
        let temp = result[j]
        result[j] = result[j + 1]
        result[j + 1] = temp
      }
      j = j + 1
    }
    i = i + 1
  }
  return result
}

// 检查元素是否在数组中
pub fn contains(arr: Array[Int], item: Int) -> Bool {
  let mut i = 0
  while i < arr.length() {
    if compare_natural(arr[i], item) == 0 {
      return true
    }
    i = i + 1
  }
  return false
}

// 复制数组
pub fn copy_array(arr: Array[Int]) -> Array[Int] {
  let result: Array[Int] = []
  let mut i = 0
  while i < arr.length() {
    result.push(arr[i])
    i = i + 1
  }
  return result
}

// ================ 集合函数 ================

// 集合并集
pub fn set_union(a: Array[Int], b: Array[Int]) -> Array[Int] {
  if a.length() == 0 {
    return copy_array(b)
  }
  
  if b.length() == 0 {
    return copy_array(a)
  }
  
  let result = copy_array(a)
  let mut i = 0
  while i < b.length() {
    if not(contains(result, b[i])) {
      result.push(b[i])
    }
    i = i + 1
  }
  
  return result
}

// 集合交集
pub fn set_intersect(a: Array[Int], b: Array[Int]) -> Array[Int] {
  if a.length() == 0 || b.length() == 0 {
    return []
  }
  
  let result: Array[Int] = []
  let mut i = 0
  while i < a.length() {
    if contains(b, a[i]) && not(contains(result, a[i])) {
      result.push(a[i])
    }
    i = i + 1
  }
  
  return result
}

// 集合差集 (a - b)
pub fn set_difference(a: Array[Int], b: Array[Int]) -> Array[Int] {
  if a.length() == 0 {
    return []
  }
  
  if b.length() == 0 {
    return copy_array(a)
  }
  
  let result: Array[Int] = []
  let mut i = 0
  while i < a.length() {
    if not(contains(b, a[i])) && not(contains(result, a[i])) {
      result.push(a[i])
    }
    i = i + 1
  }
  
  return result
}

// 集合对称差集 (a △ b)
pub fn set_sym_difference(a: Array[Int], b: Array[Int]) -> Array[Int] {
  // (a - b) ∪ (b - a)
  return set_union(set_difference(a, b), set_difference(b, a))
}

// 判断 a 是否是 b 的子集
pub fn set_is_subset(a: Array[Int], b: Array[Int]) -> Bool {
  let mut i = 0
  while i < a.length() {
    if not(contains(b, a[i])) {
      return false
    }
    i = i + 1
  }
  return true
}

// 计算元素在集合中的重复次数
pub fn set_multiplicity(e: Int, a: Array[Int]) -> Int {
  let mut count = 0
  let mut i = 0
  while i < a.length() {
    if compare_natural(a[i], e) == 0 {
      count = count + 1
    }
    i = i + 1
  }
  return count
}

// 集合大小
pub fn set_size(a: Array[Int]) -> Int {
  return a.length()
}

// 获取集合中的唯一元素
pub fn set_distinct(a: Array[Int]) -> Array[Int] {
  let result: Array[Int] = []
  let mut i = 0
  while i < a.length() {
    if not(contains(result, a[i])) {
      result.push(a[i])
    }
    i = i + 1
  }
  return result
}

// 集合的幂集
pub fn set_powerset(a: Array[Int]) -> Array[Array[Int]] {
  // 简化实现，仅支持小型集合
  let distinct_a = set_distinct(a)
  let n = distinct_a.length()
  let pow_size = 1 << n  // 2^n
  
  let result: Array[Array[Int]] = []
  
  // 添加空集
  result.push([])
  
  // 生成所有可能的子集
  let mut i = 1
  while i < pow_size {
    let subset: Array[Int] = []
    let mut j = 0
    let mut bit_mask = i
    
    while j < n {
      if (bit_mask & 1) == 1 {
        subset.push(distinct_a[j])
      }
      bit_mask = bit_mask >> 1
      j = j + 1
    }
    
    result.push(subset)
    i = i + 1
  }
  
  return result
}

// 集合的笛卡尔积
pub fn set_cartesian(a: Array[Int], b: Array[Int]) -> Array[Array[Int]] {
  let result: Array[Array[Int]] = []
  
  let mut i = 0
  while i < a.length() {
    let mut j = 0
    while j < b.length() {
      result.push([a[i], b[j]])
      j = j + 1
    }
    i = i + 1
  }
  
  return result
}

// ================ 测试代码 ================

test "flatten" {
  let a = [[1, 2], [3, 4]]
  let b = flatten(a)
  assert_eq!(b.length(), 4)
  assert_eq!(b[0], 1)
  assert_eq!(b[1], 2)
  assert_eq!(b[2], 3)
  assert_eq!(b[3], 4)
}

test "unflatten" {
  let a = [1, 2, 3, 4, 5, 6]
  let b = unflatten(a, 2, 3)
  assert_eq!(b.length(), 2)
  assert_eq!(b[0].length(), 3)
  assert_eq!(b[0][0], 1)
  assert_eq!(b[0][1], 2)
  assert_eq!(b[0][2], 3)
  assert_eq!(b[1][0], 4)
  assert_eq!(b[1][1], 5)
  assert_eq!(b[1][2], 6)
}

test "sort" {
  let a = [3, 1, 4, 2]
  let b = sort(a)
  assert_eq!(b[0], 1)
  assert_eq!(b[1], 2)
  assert_eq!(b[2], 3)
  assert_eq!(b[3], 4)
}

test "contains" {
  let a = [1, 2, 3, 4]
  assert_eq!(contains(a, 2), true)
  assert_eq!(contains(a, 5), false)
}

test "set_union" {
  let a = [1, 2, 3, 4]
  let b = [3, 4, 5, 6]
  let c = set_union(a, b)
  assert_eq!(c.length(), 6)
  assert_eq!(contains(c, 1), true)
  assert_eq!(contains(c, 2), true)
  assert_eq!(contains(c, 3), true)
  assert_eq!(contains(c, 4), true)
  assert_eq!(contains(c, 5), true)
  assert_eq!(contains(c, 6), true)
  
  // 空集测试
  let empty: Array[Int] = []
  assert_eq!(set_union(empty, a).length(), a.length())
  assert_eq!(set_union(a, empty).length(), a.length())
}

test "set_intersect" {
  let a = [1, 2, 3, 4]
  let b = [3, 4, 5, 6]
  let c = set_intersect(a, b)
  assert_eq!(c.length(), 2)
  assert_eq!(contains(c, 3), true)
  assert_eq!(contains(c, 4), true)
  
  // 空集测试
  let empty: Array[Int] = []
  let d = set_intersect(empty, a)
  assert_eq!(d.length(), 0)
}

test "set_difference" {
  let a = [1, 2, 3, 4]
  let b = [3, 4, 5, 6]
  let c = set_difference(a, b)
  assert_eq!(c.length(), 2)
  assert_eq!(contains(c, 1), true)
  assert_eq!(contains(c, 2), true)
  
  // 空集测试
  let empty: Array[Int] = []
  assert_eq!(set_difference(empty, a).length(), 0)
  assert_eq!(set_difference(a, empty).length(), a.length())
}

test "set_sym_difference" {
  let a = [1, 2, 3, 4]
  let b = [3, 4, 5, 6]
  let c = set_sym_difference(a, b)
  assert_eq!(c.length(), 4)
  assert_eq!(contains(c, 1), true)
  assert_eq!(contains(c, 2), true)
  assert_eq!(contains(c, 5), true)
  assert_eq!(contains(c, 6), true)
}

test "set_is_subset" {
  let a = [1, 2]
  let b = [1, 2, 3, 4]
  let c = [5, 6]
  
  assert_eq!(set_is_subset(a, b), true)
  assert_eq!(set_is_subset(b, a), false)
  assert_eq!(set_is_subset(c, b), false)
  
  // 空集是任何集合的子集
  let empty: Array[Int] = []
  assert_eq!(set_is_subset(empty, a), true)
}

test "set_multiplicity" {
  let a = [1, 2, 2, 3, 2, 4]
  assert_eq!(set_multiplicity(1, a), 1)
  assert_eq!(set_multiplicity(2, a), 3)
  assert_eq!(set_multiplicity(5, a), 0)
}

test "set_size" {
  let a = [1, 2, 3, 4]
  assert_eq!(set_size(a), 4)
  
  let empty: Array[Int] = []
  assert_eq!(set_size(empty), 0)
}

test "set_distinct" {
  let a = [1, 2, 2, 3, 2, 4, 3]
  let b = set_distinct(a)
  assert_eq!(b.length(), 4)
  assert_eq!(contains(b, 1), true)
  assert_eq!(contains(b, 2), true)
  assert_eq!(contains(b, 3), true)
  assert_eq!(contains(b, 4), true)
}

test "set_powerset" {
  let a = [1, 2, 3]
  let p = set_powerset(a)
  
  // 2^3 = 8个子集
  assert_eq!(p.length(), 8)
  
  // 检查是否包含空集
  let mut has_empty = false
  let mut i = 0
  while i < p.length() {
    if p[i].length() == 0 {
      has_empty = true
      break
    }
    i = i + 1
  }
  assert_eq!(has_empty, true)
  
  // 检查是否包含完整的集合
  let mut has_full = false
  i = 0
  while i < p.length() {
    if p[i].length() == 3 {
      has_full = true
      break
    }
    i = i + 1
  }
  assert_eq!(has_full, true)
}

test "set_cartesian" {
  let a = [1, 2]
  let b = [3, 4]
  let c = set_cartesian(a, b)
  
  assert_eq!(c.length(), 4)
  
  // 检查第一个元素 [1, 3]
  assert_eq!(c[0][0], 1)
  assert_eq!(c[0][1], 3)
  
  // 检查最后一个元素 [2, 4]
  assert_eq!(c[3][0], 2)
  assert_eq!(c[3][1], 4)
} 