# 数学计算工具库 ![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

本库提供精确的几何计算、组合数学算法以及基础算术运算实现，已通过相关基本测试。

## 📦 功能模块

### 组合数学模块 (`src/function/combinatorics/`)
- **经典数列计算**
  - 斯特林数第二类：`stirling_S2(n, k)`
  - 贝尔数：`bell_numbers(n)` 
  - 卡塔兰数：`catalan(n)`
  - 组合分解数：`composition(n, k)`
- **特性**
  - 动态规划优化
  - 大数安全计算
  - 参数边界检查

### 几何计算模块 (`src/function/geometry/`)
- **核心功能**
  - 二维/三维点距计算
  - 线段相交检测（2D/3D）
  - 线面交点计算
  - 向量运算（点积/叉积）
- **特性**  
  - 浮点误差处理（ε=1e-8）
  - 维度通用算法
  - 几何断言函数

### 算术运算模块 (`src/function/arithmetic/`)
- **数据类型**
  - 复数：`Complex`
  - 分数：`Fraction`
- **核心功能**
  - 基础运算（加减乘除）
  - 幂运算与开方
  - 三角函数（sin、cos、atan2）
  - 对数函数
  - 取整函数（ceil、floor、round）
  - 模运算
- **特性**
  - 精度控制与误差处理
  - 多种数据类型支持
  - 特殊值处理

### 概率函数模块 (`src/function/probability/`)
- **排列组合函数**
  - 阶乘计算：`factorial(n)`
  - 排列数：`permutations(n, k)`
  - 组合数：`combinations(n, k)`
  - 重复组合数：`combinations_with_rep(n, k)`
  - 多项式系数：`multinomial(n1, n2, n3)`
- **特殊数学函数**
  - 二项式系数：`binomial(n, k)`
  - 伽马函数：`gamma(n)`
  - 对数伽马函数：`lgamma(n)`
- **随机数生成**
  - 随机数种子生成：`random_seed(seed)`
  - 随机浮点数：`random(seed)`
  - 随机整数范围：`random_int(min, max, seed)`
  - 随机索引选择：`pick_random_index(n, seed)`
- **信息论计算**
  - KL散度计算：`kl_divergence(p1, p2, q1, q2)`
- **特性**
  - 参数边界检查
  - 整数精确计算
  - 离散概率分布支持

### 关系运算模块 (`src/function/relational/`)
- **比较函数**
  - 整数比较：`compare_int(x, y)`
  - 浮点数比较：`compare_float(x, y)`
  - 混合类型比较：`compare_int_float(x, y)`, `compare_float_int(x, y)`
  - 字符串比较：`compare_text(x, y)`
  - 自然排序比较：`compare_natural(x, y)`
- **相等性检测**
  - 整数相等：`equal_int(x, y)`, `unequal_int(x, y)`
  - 浮点数相等：`equal_float(x, y)`, `unequal_float(x, y)`
  - 混合类型相等：`equal_int_float(x, y)`, `equal_float_int(x, y)`
  - 字符串相等：`equal_text(x, y)`
  - 深度相等：`deep_equal(a, b)`, `deep_equal_float(a, b)`, `arrays_equal(a, b)`
- **大小关系判断**
  - 大于：`larger_int(x, y)`, `larger_float(x, y)`
  - 大于等于：`larger_eq_int(x, y)`, `larger_eq_float(x, y)`
  - 小于：`smaller_int(x, y)`, `smaller_float(x, y)`
  - 小于等于：`smaller_eq_int(x, y)`, `smaller_eq_float(x, y)`
- **特性**
  - 浮点数精度控制
  - 智能字符串比较（自然排序）
  - 多种数据类型支持
  - 数组深度比较

### 集合操作模块 (`src/function/set/`)
- **基本集合操作**
  - 并集：`set_union(a, b)`
  - 交集：`set_intersect(a, b)`
  - 差集：`set_difference(a, b)`
  - 对称差集：`set_sym_difference(a, b)`
  - 子集判断：`set_is_subset(a, b)`
- **高级集合函数**
  - 元素重复次数：`set_multiplicity(e, a)`
  - 集合大小：`set_size(a)`
  - 集合去重：`set_distinct(a)`
  - 幂集计算：`set_powerset(a)`
  - 笛卡尔积：`set_cartesian(a, b)`
- **数组处理工具**
  - 数组展平：`flatten(arr)`
  - 重构多维数组：`unflatten(arr, rows, cols)`
  - 数组排序：`sort(arr)`
  - 元素包含检测：`contains(arr, item)`
- **特性**
  - 高效集合运算
  - 多重集合支持
  - 完整的集合论操作

## 🚀 快速开始

### 安装
1. 在项目根目录执行：

moon add 0Ayachi0/math@0.1.0

2. 在`moon.mod.json`中确认依赖：

```json

{
  "deps": {
    "0Ayachi0/math": "0.1.0"
  }
}
```


### 使用示例
```moonbit
// 组合数学应用
fn combinatorial_demo() -> Result[Int, String] {
  let s2 = @combinatorics::stirling_S2(8, 4)?  // => Ok(1701)
  let bell = @combinatorics::bell_numbers(3)?  // => Ok(5)
  Ok(s2 + bell)
}

// 几何计算应用
fn geometry_demo() -> Result[Option[Array[Float]], String] {
  @geometry::intersect_line_line_2d(
    [0.0, 0.0], [10.0, 10.0],
    [10.0, 0.0], [0.0, 10.0]
  )  // => Ok(Some([5.0, 5.0]))
}

// 算术运算应用
fn arithmetic_demo() {
  // 复数运算
  let c1 = @arithmetic::Complex::new(3.0, 4.0)
  let c2 = @arithmetic::Complex::new(1.0, 2.0)
  let c_sum = @arithmetic::add_scalar_complex(c1, c2)  // => Complex{real: 4.0, imag: 6.0}
  
  // 分数运算
  let f1 = @arithmetic::Fraction::new(1, 2)
  let f2 = @arithmetic::Fraction::new(1, 3)
  let f_sum = @arithmetic::add_scalar_fraction(f1, f2)  // => Fraction{numer: 5, denom: 6}
  
  // 三角函数
  let angle = @arithmetic::pi / 2.0
  let sin_val = @arithmetic::sin(angle)  // => 1.0
}

// 概率函数应用
fn probability_demo() {
  // 排列组合计算
  let fact = @probability::factorial(5)  // => 120
  let perm = @probability::permutations(5, 3)  // => 60
  let comb = @probability::combinations(7, 5)  // => 21
  
  // 随机数生成
  let seed = 42
  let rand_val = @probability::random(seed)  // => 0-999之间的随机值
  let rand_int = @probability::random_int(1, 100, seed)  // => 1-99之间的随机整数
  
  // 信息论
  let kl = @probability::kl_divergence(7, 3, 3, 7)  // => 计算两个分布的KL散度
}

// 关系运算应用
fn relational_demo() {
  // 数值比较
  let cmp_int = @relational::compare_int(5, 3)  // => 1 (5 > 3)
  let cmp_float = @relational::compare_float(3.14, 3.14000001)  // => 0 (近似相等)
  
  // 相等性检测
  let eq_result = @relational::equal_float(1.0, 1.000000001)  // => true (在容差范围内)
  let array1 = [1, 2, 3]
  let array2 = [1, 2, 3]
  let arrays_eq = @relational::arrays_equal(array1, array2)  // => true
  
  // 字符串比较
  let natural_cmp = @relational::compare_natural("2", "10")  // => -1 (数值上 2 < 10)
  let text_cmp = @relational::compare_text("2", "10")  // => 1 (字典序上 "2" > "10")
}

// 集合操作应用
fn set_demo() {
  // 基本集合操作
  let a = [1, 2, 3, 4]
  let b = [3, 4, 5, 6]
  
  let union = @set::set_union(a, b)  // => [1, 2, 3, 4, 5, 6]
  let intersect = @set::set_intersect(a, b)  // => [3, 4]
  let diff = @set::set_difference(a, b)  // => [1, 2]
  let sym_diff = @set::set_sym_difference(a, b)  // => [1, 2, 5, 6]
  
  // 高级集合操作
  let is_subset = @set::set_is_subset([1, 2], a)  // => true
  
  // 多重集合处理
  let multi_set = [1, 2, 2, 3, 2, 4]
  let multiplicity = @set::set_multiplicity(2, multi_set)  // => 3
  let unique = @set::set_distinct(multi_set)  // => [1, 2, 3, 4]
  
  // 数组转换
  let matrix = [[1, 2], [3, 4]]
  let flat = @set::flatten(matrix)  // => [1, 2, 3, 4]
}
```

## 📚 文档系统
生成交互式文档：    
```bash
moon doc --serve --port 8080
```
访问 `http://localhost:8080` 查看：
- 函数签名说明
- 参数约束条件
- 实时运行示例

## 🧪 测试覆盖
运行完整测试套件：
```bash
moon test -a --coverage
```
当前覆盖范围：
- 组合数学：100% 边界条件
- 几何计算：98.7% 路径覆盖
- 算术运算：99.5% 功能覆盖
- 概率函数：100% 函数覆盖
- 关系运算：100% 函数覆盖
- 集合操作：100% 函数覆盖

## 🤝 贡献指南
欢迎通过以下方式参与：
1. 提交[Issue](https://github.com/0Ayachi0/math/issues)报告问题
2. 创建[Pull Request](https://github.com/0Ayachi0/math/pulls)时请：
   - 遵循现有代码风格
   - 添加对应测试用例
   - 更新相关文档注释

## LICENSE
Apache-2.0 © 2024 0Ayachi0. 详见[许可证文件](LICENSE)。
