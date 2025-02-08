# 数学计算工具库 ![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)

本库提供精确的几何计算与组合数学算法实现，已通过相关基本测试。

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

## 🤝 贡献指南
欢迎通过以下方式参与：
1. 提交[Issue](https://github.com/0Ayachi0/math/issues)报告问题
2. 创建[Pull Request](https://github.com/0Ayachi0/math/pulls)时请：
   - 遵循现有代码风格
   - 添加对应测试用例
   - 更新相关文档注释

## LICENSE
Apache-2.0 © 2024 0Ayachi0. 详见[许可证文件](LICENSE)。
