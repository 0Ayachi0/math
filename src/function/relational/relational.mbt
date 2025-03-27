// mathjs 关系运算库的 MoonBit 实现

// ================ 工具函数 ================

// 获取浮点数的绝对值
pub fn abs(x: Float) -> Float {
  if x < 0.0 {
    return -x
  }
  return x
}

// 判断两个浮点数是否近似相等
pub fn nearly_equal(x: Float, y: Float, rel_tol: Float, abs_tol: Float) -> Bool {
  if x == y {
    return true
  }
  
  let diff = abs(x - y)
  
  if x == 0.0 || y == 0.0 || diff < 0.000000000001 {
    return diff < abs_tol
  } else {
    return diff / (abs(x) + abs(y)) < rel_tol
  }
}

// ================ equal 函数 ================

// 判断两个整数是否相等
pub fn equal_int(x: Int, y: Int) -> Bool {
  return x == y
}

// 判断两个浮点数是否近似相等
pub fn equal_float(x: Float, y: Float) -> Bool {
  let rel_tol: Float = 0.00000000000001
  let abs_tol: Float = 0.000000001
  return nearly_equal(x, y, rel_tol, abs_tol)
}

// 判断整数和浮点数是否近似相等
pub fn equal_int_float(x: Int, y: Float) -> Bool {
  return equal_float(x.to_float(), y)
}

// 判断浮点数和整数是否近似相等
pub fn equal_float_int(x: Float, y: Int) -> Bool {
  return equal_float(x, y.to_float())
}

// ================ unequal 函数 ================

// 判断两个整数是否不相等
pub fn unequal_int(x: Int, y: Int) -> Bool {
  return not(equal_int(x, y))
}

// 判断两个浮点数是否不近似相等
pub fn unequal_float(x: Float, y: Float) -> Bool {
  return not(equal_float(x, y))
}

// 判断整数和浮点数是否不近似相等
pub fn unequal_int_float(x: Int, y: Float) -> Bool {
  return not(equal_int_float(x, y))
}

// 判断浮点数和整数是否不近似相等
pub fn unequal_float_int(x: Float, y: Int) -> Bool {
  return not(equal_float_int(x, y))
}

// ================ compare 函数 ================

// 比较两个整数
pub fn compare_int(x: Int, y: Int) -> Int {
  if x == y {
    return 0
  } else if x > y {
    return 1
  } else {
    return -1
  }
}

// 比较两个浮点数
pub fn compare_float(x: Float, y: Float) -> Int {
  let rel_tol: Float = 0.00000000000001
  let abs_tol: Float = 0.000000001
  
  if nearly_equal(x, y, rel_tol, abs_tol) {
    return 0
  } else if x > y {
    return 1
  } else {
    return -1
  }
}

// 比较整数和浮点数
pub fn compare_int_float(x: Int, y: Float) -> Int {
  return compare_float(x.to_float(), y)
}

// 比较浮点数和整数
pub fn compare_float_int(x: Float, y: Int) -> Int {
  return compare_float(x, y.to_float())
}

// ================ larger/smaller 函数 ================

// 判断 x 是否大于 y（整数）
pub fn larger_int(x: Int, y: Int) -> Bool {
  return compare_int(x, y) == 1
}

// 判断 x 是否大于 y（浮点数）
pub fn larger_float(x: Float, y: Float) -> Bool {
  return compare_float(x, y) == 1
}

// 判断 x 是否大于等于 y（整数）
pub fn larger_eq_int(x: Int, y: Int) -> Bool {
  let cmp = compare_int(x, y)
  return cmp == 1 || cmp == 0
}

// 判断 x 是否大于等于 y（浮点数）
pub fn larger_eq_float(x: Float, y: Float) -> Bool {
  let cmp = compare_float(x, y)
  return cmp == 1 || cmp == 0
}

// 判断 x 是否小于 y（整数）
pub fn smaller_int(x: Int, y: Int) -> Bool {
  return compare_int(x, y) == -1
}

// 判断 x 是否小于 y（浮点数）
pub fn smaller_float(x: Float, y: Float) -> Bool {
  return compare_float(x, y) == -1
}

// 判断 x 是否小于等于 y（整数）
pub fn smaller_eq_int(x: Int, y: Int) -> Bool {
  let cmp = compare_int(x, y)
  return cmp == -1 || cmp == 0
}

// 判断 x 是否小于等于 y（浮点数）
pub fn smaller_eq_float(x: Float, y: Float) -> Bool {
  let cmp = compare_float(x, y)
  return cmp == -1 || cmp == 0
}

// ================ 字符串比较函数 ================

// 比较两个字符串
pub fn compare_text(x: String, y: String) -> Int {
  if x == y {
    return 0
  } else {
    // 手动实现字典序比较，确保 "2" > "10" 返回 1
    let min_len = if x.length() < y.length() { x.length() } else { y.length() }
    let mut i = 0
    while i < min_len {
      let char_x = x[i]
      let char_y = y[i]
      if char_x != char_y {
        return if char_x > char_y { 1 } else { -1 }
      }
      i = i + 1
    }
    // 如果前面的字符都相同，长度较短的字符串较小
    return if x.length() > y.length() { 1 } else { -1 }
  }
}

// 测试两个字符串是否相等
pub fn equal_text(x: String, y: String) -> Bool {
  return x == y
}

// ================ 自然比较函数 ================

// 尝试将字符串转换为浮点数
pub fn try_parse_float(s: String) -> Float {
  // 这是一个简化实现，假设字符串总是可以转换为浮点数
  // 实际上需要更健壮的解析
  if s.length() > 0 {
    // 尝试判断字符串是否只包含数字字符
    let isNumber = s.contains("0") || s.contains("1") || s.contains("2") || s.contains("3") || 
                   s.contains("4") || s.contains("5") || s.contains("6") || s.contains("7") || 
                   s.contains("8") || s.contains("9")
    if isNumber {
      return 1.0  // 简化：如果包含数字则返回非零值
    }
  }
  return 0.0
}

// 自然比较两个字符串（考虑数字值）
pub fn compare_natural(x: String, y: String) -> Int {
  // 尝试将字符串解析为数字的简化实现
  // 实际上需要更复杂的逻辑
  
  // 如果两个字符串都可以解析为数字，则按数字比较
  let isXNumber = x.contains("0") || x.contains("1") || x.contains("2") || x.contains("3") || x.contains("4") || x.contains("5") || x.contains("6") || x.contains("7") || x.contains("8") || x.contains("9")
  let isYNumber = y.contains("0") || y.contains("1") || x.contains("2") || x.contains("3") || x.contains("4") || x.contains("5") || x.contains("6") || x.contains("7") || x.contains("8") || x.contains("9")
  
  if isXNumber && isYNumber {
    // 简化的数字比较逻辑
    if x.length() != y.length() {
      return if x.length() > y.length() { 1 } else { -1 }
    }
  }
  
  // 默认按文本比较
  return compare_text(x, y)
}

// ================ 深度相等函数 ================

// 判断两个数组是否相等
pub fn arrays_equal(a: Array[Int], b: Array[Int]) -> Bool {
  if a.length() != b.length() {
    return false
  }
  
  let mut i = 0
  while i < a.length() {
    if a[i] != b[i] {
      return false
    }
    i = i + 1
  }
  return true
}

// 深度相等比较（简化版）
pub fn deep_equal(a: Int, b: Int) -> Bool {
  return a == b
}

pub fn deep_equal_float(a: Float, b: Float) -> Bool {
  return equal_float(a, b)
}

// ================ 测试代码 ================

test "nearly_equal" {
  let rel_tol: Float = 0.00000000000001
  let abs_tol: Float = 0.000000001
  
  // 完全相等的数字
  assert_eq!(nearly_equal(1.0, 1.0, rel_tol, abs_tol), true)
  
  // 接近的数字
  assert_eq!(nearly_equal(1.0, 1.0000000000001, rel_tol, abs_tol), true)
  
  // 不接近的数字
  assert_eq!(nearly_equal(1.0, 1.1, rel_tol, abs_tol), false)
  
  // 零值测试
  assert_eq!(nearly_equal(0.0, 0.0000000001, rel_tol, abs_tol), true)
}

test "equal_functions" {
  // 整数相等测试
  assert_eq!(equal_int(2, 2), true)
  assert_eq!(equal_int(2, 3), false)
  
  // 浮点数相等测试
  assert_eq!(equal_float(2.0, 2.0), true)
  assert_eq!(equal_float(2.0, 2.0000000000001), true)
  assert_eq!(equal_float(2.0, 2.1), false)
  
  // 混合类型测试
  assert_eq!(equal_int_float(2, 2.0), true)
  assert_eq!(equal_float_int(2.0, 2), true)
}

test "unequal_functions" {
  // 整数不相等测试
  assert_eq!(unequal_int(2, 3), true)
  assert_eq!(unequal_int(2, 2), false)
  
  // 浮点数不相等测试
  assert_eq!(unequal_float(2.0, 2.1), true)
  assert_eq!(unequal_float(2.0, 2.0000000000001), false)
}

test "compare_functions" {
  // 整数比较测试
  assert_eq!(compare_int(2, 3), -1)
  assert_eq!(compare_int(3, 2), 1)
  assert_eq!(compare_int(2, 2), 0)
  
  // 浮点数比较测试
  assert_eq!(compare_float(3.0, 3.1), -1)
  assert_eq!(compare_float(3.1, 3.0), 1)
  assert_eq!(compare_float(3.0, 3.0), 0)
}

test "larger_functions" {
  // 整数测试
  assert_eq!(larger_int(3, 2), true)
  assert_eq!(larger_int(2, 3), false)
  assert_eq!(larger_int(2, 2), false)
  
  // 浮点数测试
  assert_eq!(larger_float(3.1, 3.0), true)
  assert_eq!(larger_float(3.0, 3.1), false)
  assert_eq!(larger_float(3.0, 3.0), false)
}

test "larger_eq_functions" {
  // 整数测试
  assert_eq!(larger_eq_int(3, 2), true)
  assert_eq!(larger_eq_int(2, 2), true)
  assert_eq!(larger_eq_int(2, 3), false)
  
  // 浮点数测试
  assert_eq!(larger_eq_float(3.1, 3.0), true)
  assert_eq!(larger_eq_float(3.0, 3.0), true)
  assert_eq!(larger_eq_float(3.0, 3.1), false)
}

test "smaller_functions" {
  // 整数测试
  assert_eq!(smaller_int(2, 3), true)
  assert_eq!(smaller_int(3, 2), false)
  assert_eq!(smaller_int(2, 2), false)
  
  // 浮点数测试
  assert_eq!(smaller_float(3.0, 3.1), true)
  assert_eq!(smaller_float(3.1, 3.0), false)
  assert_eq!(smaller_float(3.0, 3.0), false)
}

test "smaller_eq_functions" {
  // 整数测试
  assert_eq!(smaller_eq_int(2, 3), true)
  assert_eq!(smaller_eq_int(2, 2), true)
  assert_eq!(smaller_eq_int(3, 2), false)
  
  // 浮点数测试
  assert_eq!(smaller_eq_float(3.0, 3.1), true)
  assert_eq!(smaller_eq_float(3.0, 3.0), true)
  assert_eq!(smaller_eq_float(3.1, 3.0), false)
}

test "text_comparison" {
  // 文本比较测试
  assert_eq!(compare_text("a", "b"), -1)
  assert_eq!(compare_text("b", "a"), 1)
  assert_eq!(compare_text("a", "a"), 0)
  
  // 文本相等测试
  assert_eq!(equal_text("abc", "abc"), true)
  assert_eq!(equal_text("abc", "def"), false)
}

test "natural_comparison" {
  // 简单测试
  assert_eq!(compare_natural("a", "b"), -1)
  assert_eq!(compare_natural("2", "10") != compare_text("2", "10"), true)
}

test "deep_equal_functions" {
  // 简单值测试
  assert_eq!(deep_equal(5, 5), true)
  assert_eq!(deep_equal(5, 6), false)
  
  // 浮点数测试
  assert_eq!(deep_equal_float(1.0, 1.0), true)
  assert_eq!(deep_equal_float(1.0, 2.0), false)
  
  // 数组测试
  let a1 = [1, 2, 3]
  let a2 = [1, 2, 3]
  let a3 = [1, 2, 4]
  
  assert_eq!(arrays_equal(a1, a2), true)
  assert_eq!(arrays_equal(a1, a3), false)
} 