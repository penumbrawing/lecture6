# 课堂实践进度报告六

## 一、任务理解

这次要解决的是：给定一张名片设计稿，怎样用 Flutter 的基础组件把尺寸、间距和层级落实到页面上。除了复现名片，还要做对齐、2:1:1 弹性分配、两种层叠效果和卡片装饰，并留下可以核查的运行记录。

## 二、环境与工具

- Windows；工程目录 `F:\1CS\FLUTTER\lecture6`。
- Flutter 3.47.4 stable，Dart 3.13.3。
- Android 平台骨架已生成，本次没有验证 Android 构建或模拟器运行。

## 三、过程记录

1. 从教师设计稿拆出头像、姓名、统计条、标签四个区域，保留示例姓名和数据。
2. 给姓名区和统计条加 Expanded，分别处理剩余空间和三等分；用 Wrap 排列标签。
3. 添加圆角、阴影、内边距，用 Stack 和 Positioned 放置在线点。
4. 把对齐、弹性分配、层叠与装饰放到独立页面，便于切换实验和截图。
5. 增加布局与交互测试，修复 Material 绘制层问题，保存失败和通过日志。

## 四、关键代码

```dart
Row(children: [
  Expanded(flex: 2, child: first),
  Expanded(flex: 1, child: second),
  Expanded(flex: 1, child: third),
])
```

Row 在主轴分配空间，三个 flex 相加为 4。在本页没有额外占宽组件的前提下，三栏得到一半、四分之一、四分之一的宽度。文字变长后是在自己的栏内换行，不会直接把比例改掉。

第二处：头像右下的在线点。

```dart
Positioned(
  right: 0,
  bottom: 0,
  child: Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: const Color(0xFF2E9E5B),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
  ),
)
```

这段放在 56×56 的 Stack 内，排在头像后面绘制。right 和 bottom 是相对 Stack 的定位，不是相对整个屏幕。完整代码见 `lib/pages/profile_page.dart`。

第三处：卡片装饰与图片剪裁。

```dart
BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
  ],
)
```

装饰负责背景、边角和阴影；图片子项另外用 ClipRRect 剪裁。仅设置背景圆角不等于图片也被剪成圆角。

## 五、检查点结果

自动检查结果见 `docs/evidence/`，由 Codex 在本机执行。

| 检查项 | 当前结果 |
| --- | --- |
| 静态分析 | 通过，无问题 |
| Widget 测试 | 6 项通过 |
| 名片关键尺寸 | 340 宽、16 内边距、56 头像、12 间距、统计三等分通过测试 |
| 六种标准主轴对齐 | 六种位置公式测试通过；课堂原卡对应关系待核对 |
| 2:1:1 与长文 | 比例保持、长文切换与省略测试通过 |
| 两种层叠与容器美化 | 已实现；图片加载和浮层位置测试通过 |
| 窄屏 | 320 逻辑像素视口测试无异常 |
| 溢出修复实验 | 捕获预期 120 像素溢出，修复后三列各 80 |
| Web 构建与浏览器检查 | 以 `docs/evidence/verification.md` 实际记录为准 |


## 六、问题与调试

问题一是布局溢出定位练习。调试入口给 Row 240 的宽度，三个子项各请求 120，总宽超出 120。加回 Expanded 后，每个子项得到宽 80 的紧约束，原先请求的 120 不能突破这个约束，溢出消失。自动测试已复现修前与修后。

问题二是 SwitchListTile 的绘制层。初次自动测试提示 ListTile 背景或墨水效果可能不可见，定位到 StudyCard 的白色 Container 位于 Material 与 ListTile 之间。修复是在装饰内部添加透明 Material；原来失败的页面测试通过。修复由 Codex 执行，日志保留在 `debug-material-before.txt` 与 `flutter-test.txt`。

## 七、AI 使用记录

| 工具/来源 | 实际贡献 | 验证与记录 |
| --- | --- | --- |
| 教师仓库与设计稿 | 案例目标、尺寸规范、课程图片 | 保留来源和设计原稿 |
| Trae | 要求整理、问题修复、报告草稿  |  |

## 八、证据截图

## 九、自评
独立研究选做项;并提高AI利用度;

## 十、一句话收获与下一步计划
子组件写出的宽度是请求，最终尺寸仍要服从父级约束；Expanded 改变的是主轴空间的分配方式。
