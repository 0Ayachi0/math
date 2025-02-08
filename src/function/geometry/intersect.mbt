// 数组操作工具函数
/// 将两个Float数组合并为元组数组
/// 取较短数组的长度作为合并后的长度
fn zip(a: Array[Float], b: Array[Float]) -> Array[(Float, Float)] {
    let  result = []
    let mut len = 0
    if(a.length() < b.length()){
      len = a.length()
    }else{
      len = b.length()
    }
    let mut i = 0

    while i < len {
        result.push((a[i], b[i]))
        i += 1
    }
    result
}

/// 计算两个数组的逐元素差
/// 要求输入数组长度相同
fn vector_sub(a: Array[Float], b: Array[Float]) -> Array[Float] {
    let  result = []
    let pairs = zip(a, b)
    let mut i = 0
    while i < pairs.length() {
        let (x, y) = pairs[i]
        result.push(x - y)
        i += 1
    }
    result
}

/// 计算两个向量的点积
/// 要求输入数组长度相同
fn dot_product(a: Array[Float], b: Array[Float]) -> Float {
    let mut sum : Float= 0.0
    let pairs = zip(a, b)
    let mut i = 0
    while i < pairs.length() {
        let (x, y) = pairs[i]
        sum += x * y
        i += 1
    }
    sum
}

/// 计算三维向量叉积
/// # 注意
/// 仅支持三维向量，输入非三维向量将abort
fn cross_product(a: Array[Float], b: Array[Float]) -> Array[Float] {
    if a.length() < 3 || b.length() < 3 {
        abort("cross_product requires 3D vectors")
    }
    [
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0]
    ]
}

/// 计算二维线段交点
/// 使用参数方程法求解，返回交点坐标或None
/// 
/// # 参数
/// - p1a: 线段1起点 [x, y]
/// - p1b: 线段1终点 [x, y]
/// - p2a: 线段2起点 [x, y]
/// - p2b: 线段2终点 [x, y]
/// 
/// # 返回值
/// - Ok(Some([x, y])): 有效交点
/// - Ok(None): 无交点
/// - Err(String): 输入无效
/// 
/// # 示例
/// ```
/// intersect_line_line_2d([0.0,0.0], [10.0,10.0], [10.0,0.0], [0.0,10.0]) 
/// // => Ok(Some([5.0, 5.0]))
/// ```
pub fn intersect_line_line_2d(
    p1a: Array[Float], p1b: Array[Float],
    p2a: Array[Float], p2b: Array[Float]
) -> Result[Option[Array[Float]], String] {
    if p1a.length() != 2 || p1b.length() != 2 ||

       p2a.length() != 2 || p2b.length() != 2 {
        return Err("Invalid 2D points")
    }
    
    let d1 = vector_sub(p1b, p1a)
    let d2 = vector_sub(p2b, p2a)
    
    let det : Float = d1[0] * d2[1] - d2[0] * d1[1]
    if det.abs() < (0.000000000001 : Float) {
        return Ok(None)
    }
    
    let t = (d2[0] * (p1a[1] - p2a[1]) - d2[1] * (p1a[0] - p2a[0])) / det
    let s = (d1[0] * (p1a[1] - p2a[1]) - d1[1] * (p1a[0] - p2a[0])) / det
    
    if t < 0.0 || t > 1.0 || s < 0.0 || s > 1.0 {
        return Ok(None)
    }

    Ok(Some([
        p1a[0] + t * d1[0],
        p1a[1] + t * d1[1]
    ]))
}

/// 计算三维线段与平面交点
/// 平面方程形式：ax + by + cz + d = 0
/// 
/// # 参数
/// - line_start: 线段起点 [x, y, z]
/// - line_end: 线段终点 [x, y, z]
/// - plane: 平面系数数组 [a, b, c, d]
/// 
/// # 示例
/// ```
/// intersect_line_plane([1.0,0.0,1.0], [4.0,-2.0,2.0], [1.0,1.0,1.0,-6.0])
/// // => Ok(Some([7.0, -4.0, 3.0]))
/// ```
pub fn intersect_line_plane(
    line_start: Array[Float], line_end: Array[Float],
    plane: Array[Float]
) -> Result[Option[Array[Float]], String] {
    if plane.length() != 4 {

        return Err("Plane equation needs 4 coefficients")
    }
    
    let dir = vector_sub(line_end, line_start)
    let normal = [plane[0], plane[1], plane[2]]
    
    let mut denominator : Float= 0.0
    let mut i = 0
    while i < 3 {
        denominator += normal[i] * dir[i]
        i += 1
    }
    
    if denominator.abs() < (0.000000000001 : Float) {
        return Ok(None)
    }
    
    // 正确平面方程处理：ax + by + cz + d = 0
    let  numerator = -(plane[0] * line_start[0] + plane[1] * line_start[1] + plane[2] * line_start[2]) - plane[3]
    
    let t = numerator / denominator
    Ok(Some([
        line_start[0] + t * dir[0],
        line_start[1] + t * dir[1],
        line_start[2] + t * dir[2]
    ]))
}

/// 计算三维线段交点（共面情况）
/// 使用克莱姆法则解线性方程组
/// 
/// # 注意
/// 仅处理共面线段，异面直线返回None
/// 
/// # 示例
/// ```
/// intersect_line_line_3d(
///   [0.0,0.0,0.0], [2.0,2.0,0.0],
///   [2.0,0.0,0.0], [0.0,2.0,0.0]
/// ) // => Ok(Some([1.0, 1.0, 0.0]))
/// ```
pub fn intersect_line_line_3d(
    p1: Array[Float], p2: Array[Float],
    p3: Array[Float], p4: Array[Float]
) -> Result[Option[Array[Float]], String] {
    // 参数校验
    if p1.length() != 3 || p2.length() != 3 ||
       p3.length() != 3 || p4.length() != 3 {
        return Err("Invalid 3D points")
    }
    
    let dir1 = vector_sub(p2, p1)
    let dir2 = vector_sub(p4, p3)
    let cross = cross_product(dir1, dir2)
    
    // 检查线段是否共面
    let vec = vector_sub(p3, p1)
    let coplanar_check = dot_product(vec, cross)
    if coplanar_check.abs() > (0.000000000001 : Float) {
        return Ok(None)  // 异面直线
    }
    
    // 构造线性方程组
    let a1 = dir1[0]
    let b1 = -dir2[0]
    let c1 = p3[0] - p1[0]
    let a2 = dir1[1]
    let b2 = -dir2[1]
    let c2 = p3[1] - p1[1]
    let a3 = dir1[2]
    let b3 = -dir2[2]
    let c3 = p3[2] - p1[2]
    
    // 使用克莱姆法则解方程
    let det = a1*b2 - a2*b1
    if det.abs() < (0.000000000001 : Float) {
        return Ok(None)  // 平行或重合
    }
    
    let t = (c1*b2 - c2*b1) / det
    let s = (a1*c2 - a2*c1) / det
    
    // 验证第三个方程
    let residual = a3*t + b3*s - c3
    if residual.abs() > (0.000000001 : Float) {
        return Ok(None)
    }
    
    // 计算交点坐标
    Ok(Some([
        p1[0] + t * dir1[0],
        p1[1] + t * dir1[1],
        p1[2] + t * dir1[2]
    ]))
} 

/// 断言浮点数组近似相等（测试用）
/// 
/// # 参数
/// - actual: 实际结果
/// - expected: 期望数组
/// - epsilon: 允许误差
fn assert_approx_eq1(actual: Result[Option[Array[Float]], String], expected: Array[Float], epsilon: Float) -> Unit {
    match actual {
        Ok(Some(arr)) => {
            if arr.length() != expected.length() {
                abort("Array length mismatch")
            }

            let mut i = 0
            while i < arr.length() {
                if (arr[i] - expected[i]).abs() > epsilon {
                    abort("Value not match")
                }
                i += 1
            }
        }
        Ok(None) => abort("Expected intersection point but got None")
        Err(e) => abort(e)
    }
}

test "二维线段相交-正常情况" {
    let result = intersect_line_line_2d(
        [0.0, 0.0], [10.0, 10.0],
        [10.0, 0.0], [0.0, 10.0]
    )

    assert_approx_eq1(result, [5.0, 5.0], 0.0001)
}

test "三维线面相交-正常情况" {
    let result = intersect_line_plane(
        [1.0, 0.0, 1.0], [4.0, -2.0, 2.0],
        [1.0, 1.0, 1.0, -6.0]
    )

    assert_approx_eq1(result, [7.0, -4.0, 3.0], 0.000001)
}

test "三维线段相交-共面情况" {
    let result = intersect_line_line_3d(
        [0.0, 0.0, 0.0], [2.0, 2.0, 0.0],
        [2.0, 0.0, 0.0], [0.0, 2.0, 0.0]
    )

    assert_approx_eq1(result, [1.0, 1.0, 0.0], 0.0001)
}
