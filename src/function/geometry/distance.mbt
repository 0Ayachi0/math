/// 二维点结构
/// 字段：
/// - x: X坐标
/// - y: Y坐标
pub struct Point2D {
  x: Float
  y: Float
}

/// 三维点结构
/// 字段：
/// - x: X坐标
/// - y: Y坐标
/// - z: Z坐标
pub struct Point3D {
  x: Float
  y: Float
  z: Float
}

/// 二维直线一般式：ax + by + c = 0
pub struct Line2D {
  a: Float
  b: Float
  c: Float
}

/// 三维直线参数方程：(x,y,z) = (x0,y0,z0) + t*(a,b,c)
pub struct Line3D {
  x0: Float
  y0: Float
  z0: Float
  a: Float
  b: Float
  c: Float
}

/// 计算二维欧氏距离
/// # 参数
/// - p1: 第一个点
/// - p2: 第二个点
/// 
/// # 示例
/// ```
/// let p1 = { x: 0.0, y: 0.0 }
/// let p2 = { x: 3.0, y: 4.0 }
/// euclidean_distance_2d(p1, p2) // => 5.0
/// ```
pub fn euclidean_distance_2d(p1: Point2D, p2: Point2D) -> Float {
  let dx = p1.x - p2.x
  let dy = p1.y - p2.y
  Float::sqrt(dx * dx + dy * dy)
}

pub fn euclidean_distance_3d(p1: Point3D, p2: Point3D) -> Float {
  let dx = p1.x - p2.x
  let dy = p1.y - p2.y
  let dz = p1.z - p2.z
  Float::sqrt(dx * dx + dy * dy + dz * dz)
}

/// 计算点到二维直线距离
/// # 参数
/// - p: 目标点
/// - line: 直线方程系数
/// 
/// # 示例
/// ```
/// let line = { a: 3.0, b: 4.0, c: 5.0 }
/// let point = { x: 0.0, y: 0.0 }
/// point_to_line_2d(point, line) // => 1.0
/// ```
pub fn point_to_line_2d(p: Point2D, line: Line2D) -> Float {
  let numerator = Float::abs(line.a * p.x + line.b * p.y + line.c)
  let denominator = Float::sqrt(line.a * line.a + line.b * line.b)
  numerator / denominator
}

/// 计算点集中所有点对的欧氏距离
/// # 参数
/// - points: 点集合（至少包含2个点）
/// 
/// # 示例
/// ```
/// let points = [
///   { x: 0.0, y: 0.0 },
///   { x: 3.0, y: 0.0 },
///   { x: 0.0, y: 4.0 }
/// ]
/// pairwise_distance(points) // => [3.0, 4.0, 5.0]
/// ```
pub fn pairwise_distance(points: Array[Point2D]) -> Array[Float] {
  let  result = []
  for i = 0; i < points.length() - 1; i = i + 1 {
    for j = i + 1; j < points.length(); j = j + 1 {
      result.push(euclidean_distance_2d(points[i], points[j]))
    }
  }
  result
}

/// 三维点线距离计算（向量叉乘法）
/// # 参数
/// - p: 三维点
/// - line: 三维直线参数
/// 
/// # 示例
/// ```
/// let line = {
///   x0: 1.0, y0: 2.0, z0: 3.0,
///   a: 2.0, b: 1.0, c: -1.0
/// }
/// let point = { x: 4.0, y: 3.0, z: 2.0 }
/// point_to_line_3d(point, line) ≈ 0.57735 // 允许误差1e-5
/// ```
pub fn point_to_line_3d(p: Point3D, line: Line3D) -> Float {
  let vec_ap = { x: p.x - line.x0, y: p.y - line.y0, z: p.z - line.z0 }
  let dir = { x: line.a, y: line.b, z: line.c }
  
  let cross = {
    x: vec_ap.y * dir.z - vec_ap.z * dir.y,
    y: vec_ap.z * dir.x - vec_ap.x * dir.z,
    z: vec_ap.x * dir.y - vec_ap.y * dir.x
  }
  
  let cross_norm = Float::sqrt(cross.x.pow(2) + cross.y.pow(2) + cross.z.pow(2))
  let dir_norm = Float::sqrt(dir.x.pow(2) + dir.y.pow(2) + dir.z.pow(2))
  
  cross_norm / dir_norm
}

// 辅助断言函数
fn assert_approx_eq(actual: Float, expected: Float, epsilon: Float) -> Unit {
  if (actual - expected).abs() > epsilon {
    abort("Assertion failed: values not approximately equal")
  }
}

// 添加测试模块
test "平面上两点距离-正常情况" {
  let p1 = { x: 0.0, y: 0.0 }
  let p2 = { x: 3.0, y: 4.0 }
  assert_eq!(euclidean_distance_2d(p1, p2), 5.0)
}

test "平面上两点距离-零距离" {
  let p = { x: 2.5, y: 3.7 }
  assert_eq!(euclidean_distance_2d(p, p), 0.0)
}

test "平面上特殊点（原点）到直线距离-标准直线" {
  let line = { a: 3.0, b: 4.0, c: 5.0 }
  let point = { x: 0.0, y: 0.0 }
  assert_eq!(point_to_line_2d(point, line), 1.0)
}

test "平面上一般点到直线距离-点到直线的垂线长度" {
  let line = { a: 1.0, b: 0.0, c: -5.0 } // x=5
  let point = { x: 2.0, y: 3.0 }
  assert_eq!(point_to_line_2d(point, line), 3.0)
}

test "平面上成对距离计算-三点集合" {
  let points = [
    { x: 0.0, y: 0.0 },
    { x: 3.0, y: 0.0 },
    { x: 0.0, y: 4.0 }
  ]
  let distances = pairwise_distance(points)
  assert_eq!(distances, [3.0, 4.0, 5.0])
}

test "空间中两点距离-正常情况" {
  let p1 = { x: 1.0, y: 2.0, z: 3.0 }
  let p2 = { x: 4.0, y: 6.0, z: 8.0 }
  assert_eq!(euclidean_distance_3d(p1, p2), Float::sqrt(50.0))
}

test "空间中点到直线距离-正常情况" {
  let p1 = { x: 1.0, y: 2.0, z: 3.0 }
  let p2 = { x: 4.0, y: 6.0, z: 8.0 }
  assert_eq!(euclidean_distance_3d(p1, p2), Float::sqrt(50.0))
}

// 添加测试用例
test "3D点线距离-正常情况" {
  let line = {
    x0: 1.0, y0: 2.0, z0: 3.0,
    a: 2.0, b: 1.0, c: -1.0
  }
  let point = { x: 4.0, y: 3.0, z: 2.0 }
  let expected : Float = (1.0 : Float) / Float::sqrt(3.0)
  assert_approx_eq(point_to_line_3d(point, line), expected, 0.000001)
}

test "3D点线距离-点在线上" {
  let line = {
    x0: 0.0, y0: 0.0, z0: 0.0,
    a: 1.0, b: 1.0, c: 1.0
  }
  let point = { x: 2.0, y: 2.0, z: 2.0 }
  assert_eq!(point_to_line_3d(point, line), 0.0)
}

