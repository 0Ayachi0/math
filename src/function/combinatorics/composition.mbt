/// 计算组合分解数 C(n-1, k-1)
/// 表示将正整数n分解为k个正整数之和的方式数
/// 
/// # 参数
/// - n: 被分解的正整数
/// - k: 分解项数
/// 
/// # 示例
/// ```
/// composition(5, 3) // => Ok(6)
/// composition(10, 4) // => Ok(84)
/// ```
pub fn composition(n: Int, k: Int) -> Result[Int, String] {
    if n <= 0 || k <= 0 {
        return Err("Positive integer values expected in composition")
    }
    if k > n {
        return Err("k must be less than or equal to n in composition")
    }

    match combination(n - 1, k - 1) {
        Ok(v) => Ok(v)
        Err(e) => Err(e)
    }
}

// 组合数计算函数
fn combination(n: Int, k: Int) -> Result[Int, String] {
    if n < 0 || k < 0 {
        return Err("Non-negative integer values expected in combinations")
    }
    if k > n {
        return Err("k must be less than or equal to n in combinations")
    }

    // 优化计算：C(n,k) = C(n, n-k)
    let k = if k > n - k { n - k } else { k }
    let mut result = 1
    for i = 1; i < k + 1; i = i+1 {
        result = result * (n - k + i) / i
    }
    Ok(result)
}

// 测试模块
test "组合数基本测试" {
    match composition(5, 3) {
        Ok(v) => assert_eq!(v, 6)
        Err(_) => abort("Test failed")
    }
}

test "边界条件测试" {
    match composition(1, 1) {
        Ok(v) => assert_eq!(v, 1)
        Err(_) => abort("Test failed")
    }
}

test "较大数值测试" {
    match composition(10, 4) {
        Ok(v) => assert_eq!(v, 84)
        Err(_) => abort("Test failed")
    }
}

test "错误输入测试" {
    match composition(-1, 2) {
        Ok(_) => abort("Test failed")
        Err(e) => assert_eq!(e, "Positive integer values expected in composition")
    }
}
