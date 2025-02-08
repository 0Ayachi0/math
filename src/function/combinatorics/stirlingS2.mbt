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
/// stirling_S2(8, 4) // => Ok(1701)
/// stirling_S2(0, 0) // => Ok(1)
/// ```
pub fn stirling_S2(n: Int, k: Int) -> Result[Int, String] {
    if n < 0 || k < 0 {
        return Err("Non-negative integer value expected in stirling_s2")
    }
    if k > n {
        return Err("k must be less than or equal to n in stirling_s2")
    }

    // 正确初始化可变二维数组
    let  cache = {
        let  arr = Array::make(n + 1, Array::make(0, 0))
        for i = 0; i <(n + 1); i = i+1 {
            arr[i] = Array::make(n + 1, 0)
        }
        arr
    }
    
    // 使用显式循环变量修改
    for m = 0; m < (n + 1); m = m+1 {
        for i = 0; i < (m + 1); i = i+1 {
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

// 测试模块修正
test "斯特林数基本测试" {
    match stirling_S2(5, 3) {
        Ok(v) => assert_eq!(v, 25)
        Err(_) => abort("Test failed")
    }
}

test "边界条件测试" {
    match stirling_S2(0, 0) {
        Ok(v) => assert_eq!(v, 1)
        Err(_) => abort("Test failed")
    }
}

test "较大数值测试" {
    match stirling_S2(8, 4) {
        Ok(v) => assert_eq!(v, 1701)
        Err(_) => abort("Test failed")
    }
}

test "错误输入测试" {
    match stirling_S2(-1, 2) {
        Ok(_) => abort("Test failed")
        Err(e) => assert_eq!(e, "Non-negative integer value expected in stirling_s2")
    }
}
