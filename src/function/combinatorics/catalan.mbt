/// 计算第n个卡塔兰数
/// 使用组合数公式 C(2n, n)/(n+1)
/// 
/// # 参数
/// - n: 非负整数
/// 
/// # 示例
/// ```
/// catalan(3) // => Ok(5)
/// catalan(8) // => Ok(1430)
/// ```
pub fn catalan(n: Int) -> Result[Int, String] {
    if n < 0 {
        return Err("Non-negative integer value expected in catalan")
    }

    match combinations(2 * n, n) {
        Ok(c) => {
            if c % (n + 1) != 0 {
                Err("Calculation error: division not exact")
            } else {
                Ok(c / (n + 1))
            }
        }
        Err(e) => Err(e)
    }
}

// 组合数计算函数
fn combinations(n: Int, k: Int) -> Result[Int, String] {
    if n < 0 || k < 0 {
        return Err("Non-negative integer values expected in combinations")
    }
    if k > n {
        return Err("k must be less than or equal to n in combinations")
    }

    // 优化计算：C(n,k) = C(n, n-k)
    let k = if k > n - k { n - k } else { k }
    let mut result = 1
    for i = 1; i < k + 1; i =i+1 {
        result = result * (n - k + i) / i
    }
    Ok(result)
}

// 测试模块
test "卡塔兰数基本测试" {
    match catalan(3) {
        Ok(v) => assert_eq!(v, 5)
        Err(_) => abort("Test failed")
    }
}

test "边界条件测试" {
    match catalan(0) {
        Ok(v) => assert_eq!(v, 1)
        Err(_) => abort("Test failed")
    }
}

test "较大数值测试" {
    match catalan(8) {
        Ok(v) => assert_eq!(v, 1430)
        Err(_) => abort("Test failed")
    }
}

test "错误输入测试" {
    match catalan(-1) {
        Ok(_) => abort("Test failed")
        Err(e) => assert_eq!(e, "Non-negative integer value expected in catalan")
    }
}
