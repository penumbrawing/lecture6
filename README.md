# lecture6 · 基础组件与布局系统
\
## 页面与任务

| 页面 | 已实现内容 |
| --- | --- |
| 名片 | 340 宽卡片、56 头像、12 在线点、三等分统计、Wrap 标签 |
| 对齐 | start/end/center/spaceBetween/spaceAround/spaceEvenly 六个 Row |
| 弹性 | Expanded 2:1:1；短文/长文开关；换行/省略选项 |
| 层叠 | 头像角标、图片底部文字浮层；两处圆角、阴影、留白；图片 ClipRRect |

## 运行

本次验证环境：Windows、Flutter 3.47.4 stable、Dart 3.13.3。

```powershell
cd F:\1CS\FLUTTER\lecture6
flutter pub get
flutter run -d chrome
```

检查：

```powershell
flutter analyze
flutter test
flutter build web --no-web-resources-cdn
```

独立的调试入口（默认修复状态，关闭开关才故意制造溢出）：

```powershell
flutter run -d chrome -t lib/overflow_demo.dart
```

主程序是 `lib/main.dart`，不能拿故意关闭修复开关的调试页当作最终无溢出页面。

## 目录

- `lib/pages/`：四个页面；`lib/widgets/`：共用装饰卡片。
- `test/`：布局几何、交互、窄屏及溢出修复测试。
- `docs/reference/`：教师设计说明及 SVG 原稿。
- `docs/evidence/`：机器检查日志；本人证据也保存在此。
- `docs/验收与实验.md`：指标、对齐参数、实验记录、材料歧义。
- `docs/trae-record.md`：真实 Trae 记录填写位置。
- `assets/SOURCES.md`：图片来源。

## 来源与完成边界

依据教师 [flutter-book-demos](https://github.com/thiswind/flutter-book-demos) 与 [profile_card 设计说明](https://github.com/thiswind/flutter-practice-cases/blob/master/docs/profile-card-design.md) 整理实现。姓名和数据保留设计稿示例，不是学生个人信息。

本次代码、自动测试及文字草稿由 Codex 辅助完成，学生本人需核查、补真实 Inspector/Trae 证据并提交。自动检查不能替代本人理解或 Inspector 操作。独立研究选做项和 EX1–EX5 未完成，不申报其成果。Android 工程已生成，但本次未验证 Android 构建/模拟器运行。

不要把 build、.dart_tool 或本地缓存提交到 Git。仓库须独立命名 lecture6；Git 操作由本人执行。
