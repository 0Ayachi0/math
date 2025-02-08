// 斯特林数第二类实现
// 斯特林数第二类实现
/// 计算第二类斯特林数 S(n, k)
/// 表示将n个不同元素划分为k个非空集合的方式数
/// 
/// # 参数
/// - n: 元素总数，需满足 n >= 0
/// - k: 划分的集合数，需满足 0 <= k <= n
/// 
/// # 返回值
/// - Ok(Int): 成功时返回整数值
/// - Err(String): 参数非法时返回错误描述
/// 
/// # 示例
/// ```
/// stirling_s2(3, 2) // => Ok(3)
/// stirling_s2(0, 0) // => Ok(1)
/// ```
pub fn stirling_s2(n: Int, k: Int) -> Result[Int, String] {
    if n < 0 || k < 0 {
        return Err("Non-negative integer value expected in stirling_s2")
    }
    if k > n {
        return Err("k must be less than or equal to n in stirling_s2")
    }

    // 正确初始化二维数组（每行独立）
    let cache = {
        let arr = Array::make(n + 1, Array::make(0, 0))
        for i = 0; i < (n + 1); i = i+1 {
            arr[i] = Array::make(n + 1, 0)
        }
        arr
    }
    
    // 修正递推逻辑
    for m = 0; m < (n + 1); m = m+1 {
        for i = 0; i <(m + 1); i = i+1 {  // 优化循环范围
            cache[m][i] = if m == 0 {
                if i == 0 { 1 } else { 0 }
            } else if i == 0 {
                0
            } else if i == 1 || i == m {
                1
            } else {
                i * cache[m-1][i] + cache[m-1][i-1]
            }
        }
    }
    Ok(cache[n][k])
}

/// 计算第n个贝尔数（所有划分方式的总数）
/// 等于第二类斯特林数从k=0到k=n的和
/// 
/// # 参数
/// - n: 非负整数
/// 
/// # 示例
/// ```
/// bell_numbers(3) // => Ok(5)
/// bell_numbers(0) // => Ok(1)
/// ```
pub fn bell_numbers(n: Int) -> Result[Int, String] {
    if n < 0 {
        return Err("Non-negative integer value expected in bell_numbers")
    }

    let mut result = 0
    for k = 0; k < n + 1; k = k+1 {
        match stirling_s2(n, k) {
            Ok(v) => result += v
            Err(e) => return Err(e)
        }
    }
    Ok(result)
}

// 测试模块
test "贝尔数基本测试" {
    match bell_numbers(3) {
        Ok(v) => assert_eq!(v, 5)
        Err(_) => abort("Test failed")
    }
}

test "边界条件测试" {
    match bell_numbers(0) {
        Ok(v) => assert_eq!(v, 1)
        Err(_) => abort("Test failed")
    }
}

test "较大数值测试" {
    match bell_numbers(8) {
        Ok(v) => assert_eq!(v, 4140)
        Err(_) => abort("Test failed")
    }
}