# 跨平台记账 App Flutter 架构与数据设计

## 1. 技术目标

本文档定义 QBook 的客户端技术选型、模块划分、项目目录、核心数据模型、同步策略和开发顺序。

目标：
- 单代码库支持 `Android / iOS / Web / Desktop`
- 以移动端为核心体验平台
- 本地优先，可离线使用
- 后续可平滑接入云同步与智能能力

## 2. 推荐技术栈

### 2.1 客户端

- 框架：`Flutter`
- 语言：`Dart`
- 状态管理：`Riverpod`
- 路由：`go_router`
- 本地数据库：`Drift`
- 网络请求：`Dio`
- JSON 序列化：`freezed` + `json_serializable`
- 图表：`fl_chart`
- 本地安全存储：`flutter_secure_storage`
- 国际化：`flutter_localizations` + `intl`
- 表单校验：`formz` 或轻量自定义验证

### 2.2 可选插件

- 语音识别：平台插件封装
- OCR：平台插件或第三方 OCR SDK
- 文件导入导出：`file_picker`、`share_plus`
- 本地通知：`flutter_local_notifications`
- 生物识别：`local_auth`
- 桌面/移动快捷入口：平台侧原生实现

### 2.3 后端建议

可选方案：
- `Supabase`：适合早期快速上线
- 自建 API：适合后期复杂同步、共享权限和智能能力

若自建后端，建议：
- API：`NestJS` / `Go`
- 数据库：`PostgreSQL`
- 对象存储：`S3` 兼容存储

## 3. 架构原则

- 本地优先：账单、分类、账户等优先写本地数据库
- 同步解耦：同步服务不影响核心记账流程
- 模块分层：页面、状态、领域、数据访问分离
- 可替换能力：OCR、NLP、行情、同步实现可替换
- 平台能力隔离：将自动记账、语音、截图识别等平台实现下沉到 adapter 层

## 4. 项目目录建议

```text
lib/
  app/
    app.dart
    bootstrap.dart
    router/
      app_router.dart
    theme/
      app_theme.dart
      app_colors.dart
      app_typography.dart
    core/
      constants/
      errors/
      utils/
      extensions/
      services/
        logger_service.dart
        analytics_service.dart
        permission_service.dart
        file_service.dart
        biometric_service.dart
  shared/
    widgets/
    components/
    models/
    enums/
  features/
    auth/
      presentation/
      application/
      domain/
      data/
    onboarding/
    home/
    ledger/
    transaction/
    account/
    category/
    tag/
    budget/
    statistics/
    book/
    reimbursement/
    debt/
    recurring/
    attachment/
    import_export/
    sync/
    member/
    investment/
    mortgage/
    settings/
    smart_entry/
      presentation/
      domain/
      data/
  data/
    local/
      db/
        app_database.dart
        tables/
        daos/
      cache/
    remote/
      api/
      dto/
      mappers/
  platform/
    speech/
    ocr/
    auto_entry/
    widget_shortcut/
  l10n/
    arb/
```

## 5. 分层设计

采用简化版的 feature-first + clean architecture。

### 5.1 Presentation

负责：
- 页面
- 组件
- 页面状态
- 用户交互

建议：
- 页面状态用 Riverpod provider 管理
- UI 状态和业务状态区分

### 5.2 Application

负责：
- 用例编排
- 事务组合
- 跨模块调用

示例：
- 新增账单
- 执行转账
- 执行报销
- 执行周期记账

### 5.3 Domain

负责：
- 实体
- 值对象
- 仓储接口
- 业务规则

### 5.4 Data

负责：
- Drift 表和 DAO
- API DTO
- 本地/远程数据映射
- 仓储实现

## 6. 模块拆分建议

### 6.1 基础模块

- `auth`：登录、注册、会话
- `book`：账本管理
- `category`：分类管理
- `account`：账户与资产
- `transaction`：账单与转账
- `budget`：预算管理
- `statistics`：统计分析
- `settings`：全局设置

### 6.2 增强模块

- `smart_entry`：智能文字记账、语音记账
- `attachment`：附件管理
- `reimbursement`：报销管理
- `debt`：借入借出
- `recurring`：周期记账
- `import_export`：导入导出
- `sync`：同步和冲突解决
- `member`：共享账本成员

### 6.3 高级模块

- `investment`：理财记录
- `mortgage`：房贷/分期
- `ocr`：截图导入
- `auto_entry`：自动记账

## 7. 路由设计

```text
/
/launch
/onboarding
/login
/home
/ledger
/ledger/detail/:id
/transaction/create
/transaction/edit/:id
/transfer/create
/statistics
/budget
/accounts
/accounts/detail/:id
/categories
/books
/recurring
/reimbursement
/debt
/investment
/import-export
/members
/settings
```

## 8. 页面建议

## 8.1 首页

内容：
- 本月收入
- 本月支出
- 本月结余
- 预算进度
- 总资产 / 净资产
- 数据小卡片区
- 最近账单

## 8.2 账单页

内容：
- 日期分组列表
- 搜索
- 快捷筛选
- 高级筛选抽屉
- 批量编辑

## 8.3 记账页

模式：
- 支出
- 收入
- 转账
- 智能输入

## 8.4 统计页

内容：
- 时间维度切换
- 趋势图
- 分类占比
- 账户统计
- 预算执行

## 8.5 我的页

内容：
- 账户管理
- 分类管理
- 账本管理
- 周期记账
- 导入导出
- 共享成员
- 设置

## 9. 数据模型设计

以下模型既适用于 Drift 本地库，也适用于服务端 PostgreSQL。

## 9.1 users

```sql
id TEXT PRIMARY KEY
email TEXT
phone TEXT
name TEXT NOT NULL
avatar_url TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
status TEXT NOT NULL
```

## 9.2 books

```sql
id TEXT PRIMARY KEY
owner_user_id TEXT NOT NULL
name TEXT NOT NULL
icon TEXT
color TEXT
currency_code TEXT NOT NULL
is_default INTEGER NOT NULL
is_archived INTEGER NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

## 9.3 book_members

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
user_id TEXT NOT NULL
role TEXT NOT NULL
nickname TEXT
joined_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

角色建议：
- owner
- admin
- member
- viewer

## 9.4 accounts

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
name TEXT NOT NULL
type TEXT NOT NULL
subtype TEXT
currency_code TEXT NOT NULL
initial_balance DECIMAL NOT NULL
current_balance DECIMAL NOT NULL
credit_limit DECIMAL
billing_day INTEGER
repayment_day INTEGER
include_in_total_assets INTEGER NOT NULL
is_hidden INTEGER NOT NULL
is_archived INTEGER NOT NULL
remark TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

账户类型建议：
- cash
- bank
- ewallet
- credit
- reimbursement
- debt_receivable
- debt_payable
- investment

## 9.5 categories

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
parent_id TEXT
name TEXT NOT NULL
type TEXT NOT NULL
icon TEXT
color TEXT
sort_order INTEGER NOT NULL
is_system INTEGER NOT NULL
is_enabled INTEGER NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

分类类型：
- income
- expense

## 9.6 tags

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
name TEXT NOT NULL
color TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

## 9.7 transactions

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
type TEXT NOT NULL
status TEXT NOT NULL
occurred_at DATETIME NOT NULL
amount DECIMAL NOT NULL
currency_code TEXT NOT NULL
account_id TEXT
category_id TEXT
transfer_out_account_id TEXT
transfer_in_account_id TEXT
fee_amount DECIMAL
discount_amount DECIMAL
merchant TEXT
remark TEXT
location_text TEXT
is_reimbursable INTEGER NOT NULL
reimbursement_account_id TEXT
created_by_user_id TEXT
source_type TEXT NOT NULL
source_ref TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

交易类型：
- expense
- income
- transfer
- adjustment

来源类型：
- manual
- smart_text
- voice
- screenshot
- auto
- import
- recurring
- reimbursement

状态建议：
- posted
- pending
- draft

## 9.8 transaction_tags

```sql
id TEXT PRIMARY KEY
transaction_id TEXT NOT NULL
tag_id TEXT NOT NULL
created_at DATETIME NOT NULL
```

## 9.9 attachments

```sql
id TEXT PRIMARY KEY
transaction_id TEXT NOT NULL
storage_type TEXT NOT NULL
local_path TEXT
remote_url TEXT
mime_type TEXT
file_size INTEGER
upload_status TEXT NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

## 9.10 budgets

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
name TEXT NOT NULL
scope_type TEXT NOT NULL
category_id TEXT
period_type TEXT NOT NULL
amount DECIMAL NOT NULL
start_date DATETIME NOT NULL
end_date DATETIME NOT NULL
alert_threshold DECIMAL
rollover_enabled INTEGER NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

预算范围：
- overall
- category

周期类型：
- monthly
- yearly
- custom

## 9.11 reimbursements

```sql
id TEXT PRIMARY KEY
transaction_id TEXT NOT NULL
status TEXT NOT NULL
expected_amount DECIMAL NOT NULL
received_amount DECIMAL NOT NULL
received_account_id TEXT
completed_at DATETIME
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

状态建议：
- pending
- partial
- completed

## 9.12 reimbursement_records

```sql
id TEXT PRIMARY KEY
reimbursement_id TEXT NOT NULL
amount DECIMAL NOT NULL
received_account_id TEXT NOT NULL
received_at DATETIME NOT NULL
remark TEXT
created_at DATETIME NOT NULL
```

## 9.13 debt_records

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
type TEXT NOT NULL
person_name TEXT NOT NULL
account_id TEXT
principal_amount DECIMAL NOT NULL
remaining_amount DECIMAL NOT NULL
occurred_at DATETIME NOT NULL
due_at DATETIME
remark TEXT
status TEXT NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

债务类型：
- borrow
- lend

## 9.14 debt_payments

```sql
id TEXT PRIMARY KEY
debt_record_id TEXT NOT NULL
amount DECIMAL NOT NULL
account_id TEXT NOT NULL
paid_at DATETIME NOT NULL
remark TEXT
created_at DATETIME NOT NULL
```

## 9.15 recurring_rules

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
kind TEXT NOT NULL
transaction_type TEXT NOT NULL
template_payload TEXT NOT NULL
repeat_type TEXT NOT NULL
interval_value INTEGER NOT NULL
weekdays TEXT
monthdays TEXT
timezone TEXT NOT NULL
start_at DATETIME NOT NULL
end_at DATETIME
next_run_at DATETIME
last_run_at DATETIME
is_enabled INTEGER NOT NULL
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

## 9.16 investments

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
name TEXT NOT NULL
symbol TEXT
type TEXT NOT NULL
market TEXT
cost_amount DECIMAL NOT NULL
holding_amount DECIMAL NOT NULL
holding_units DECIMAL
current_price DECIMAL
current_value DECIMAL
profit_amount DECIMAL
profit_rate DECIMAL
updated_quote_at DATETIME
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

## 9.17 mortgage_plans

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
account_id TEXT
name TEXT NOT NULL
loan_amount DECIMAL NOT NULL
remaining_principal DECIMAL NOT NULL
annual_rate DECIMAL
start_date DATETIME NOT NULL
end_date DATETIME
installment_day INTEGER
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
deleted_at DATETIME
```

## 9.18 mortgage_installments

```sql
id TEXT PRIMARY KEY
mortgage_plan_id TEXT NOT NULL
period_no INTEGER NOT NULL
due_date DATETIME NOT NULL
principal_amount DECIMAL NOT NULL
interest_amount DECIMAL NOT NULL
paid_amount DECIMAL NOT NULL
status TEXT NOT NULL
paid_at DATETIME
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

## 9.19 import_jobs

```sql
id TEXT PRIMARY KEY
book_id TEXT NOT NULL
source_type TEXT NOT NULL
file_name TEXT
file_path TEXT
status TEXT NOT NULL
total_count INTEGER
success_count INTEGER
failed_count INTEGER
error_message TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

## 9.20 sync_records

```sql
id TEXT PRIMARY KEY
entity_type TEXT NOT NULL
entity_id TEXT NOT NULL
operation_type TEXT NOT NULL
sync_status TEXT NOT NULL
version INTEGER NOT NULL
device_id TEXT
last_synced_at DATETIME
error_message TEXT
created_at DATETIME NOT NULL
updated_at DATETIME NOT NULL
```

## 10. 表关系

- `books 1:N accounts`
- `books 1:N categories`
- `books 1:N tags`
- `books 1:N transactions`
- `books 1:N budgets`
- `books 1:N recurring_rules`
- `books 1:N investments`
- `books 1:N mortgage_plans`
- `books 1:N debt_records`
- `books 1:N book_members`
- `transactions N:N tags`
- `transactions 1:N attachments`
- `transactions 1:0..1 reimbursements`
- `reimbursements 1:N reimbursement_records`
- `debt_records 1:N debt_payments`
- `mortgage_plans 1:N mortgage_installments`

## 11. 本地数据库设计建议

### 11.1 Drift 设计原则

- 所有表使用 `TEXT` 形式 UUID 作为主键
- 保留 `created_at`、`updated_at`、`deleted_at`
- 用软删除支持同步和恢复
- 枚举值以字符串存储，便于调试与迁移

### 11.2 DAO 建议

建议至少实现以下 DAO：
- `BooksDao`
- `AccountsDao`
- `CategoriesDao`
- `TransactionsDao`
- `TagsDao`
- `BudgetsDao`
- `RecurringRulesDao`
- `AttachmentsDao`
- `SyncDao`

### 11.3 聚合查询

建议在本地数据库直接实现：
- 月度收支汇总
- 分类占比
- 预算已用金额
- 账户余额汇总
- 净资产汇总
- 时间区间流水查询

## 12. 状态管理建议

### 12.1 provider 分类

- `RepositoryProvider`：仓储与服务
- `QueryProvider`：只读查询
- `MutationProvider`：创建、更新、删除
- `ViewModelProvider`：复杂页面状态

### 12.2 页面级状态

示例：
- 首页统计状态
- 账单筛选状态
- 记账表单状态
- 同步状态

## 13. 同步设计

## 13.1 同步原则

- 本地先写成功，再异步同步远端
- 服务端返回版本号或更新时间戳
- 使用增量同步，不做全量覆盖

## 13.2 冲突策略

建议默认策略：
- 普通实体：`last write wins`
- 金额类关键数据：若版本冲突，保留冲突记录待用户确认
- 附件：按文件 hash 去重

## 13.3 同步流程

1. 本地写入实体并记入 `sync_records`
2. 后台任务扫描待同步记录
3. 调用远端接口
4. 成功后更新 `sync_status`
5. 失败后记录错误并重试

## 14. 智能记账设计

## 14.1 智能文字记账

建议拆成两个阶段：

1. 规则解析
- 正则识别金额、日期、账户、关键词

2. 语义补全
- 分类猜测
- 账户联想
- 历史偏好修正

输出结构：

```json
{
  "type": "expense",
  "amount": 12,
  "accountName": "支付宝",
  "categoryName": "打车",
  "occurredAt": "2026-04-23T20:00:00+08:00",
  "remark": "昨日用支付宝打车花了12元",
  "confidence": 0.92
}
```

## 14.2 规则学习

用户每次修正识别结果后，保存修正规则，例如：
- 商户关键词 -> 分类
- 文本模式 -> 账户
- OCR 交易对象 -> 固定分类

## 15. 导入导出设计

## 15.1 导入

导入流程建议：

1. 读取文件
2. 识别模板类型
3. 映射字段
4. 预览结果
5. 用户确认
6. 执行导入
7. 输出失败报告

### 15.2 导出

支持：
- 全量导出
- 条件筛选后导出
- 账单与转账分开导出

## 16. 平台能力设计

## 16.1 Android / iOS

完整支持：
- 语音记账
- 截图导入
- 自动记账
- 通知提醒
- 生物识别

## 16.2 Web / Desktop

优先支持：
- 账单录入
- 报表和统计
- 导入导出
- 多账本和共享管理

弱化或不支持：
- 自动记账
- 悬浮窗
- 小组件
- 系统通知识别

## 17. 版本开发顺序

## 17.1 第一阶段

- 项目初始化
- 主题、路由、基础框架
- 本地数据库
- 账本、账户、分类、账单
- 基础统计
- 预算

## 17.2 第二阶段

- 智能文字记账
- 标签、附件
- 周期记账
- 云同步
- 搜索与高级筛选

## 17.3 第三阶段

- 报销
- 借入借出
- 共享账本
- 导入导出
- 理财和房贷

## 17.4 第四阶段

- 截图导入
- 自动记账
- 高级对账

## 18. 建议的首批任务拆分

1. 初始化 Flutter 工程和基础依赖
2. 搭建主题、路由、底部导航框架
3. 建立 Drift 数据库和基础表
4. 完成账本、账户、分类 CRUD
5. 完成账单录入、列表、详情、编辑
6. 完成首页和统计页基础汇总
7. 完成预算模块
8. 完成本地导出
9. 接入登录和同步能力

## 19. 推荐初始依赖

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  go_router: ^16.0.0
  drift: ^2.28.1
  sqlite3_flutter_libs: ^0.5.31
  path_provider: ^2.1.5
  path: ^1.9.1
  dio: ^5.9.0
  freezed_annotation: ^3.1.0
  json_annotation: ^4.9.0
  intl: ^0.20.2
  fl_chart: ^1.1.1
  flutter_secure_storage: ^10.0.0-beta.4
  file_picker: ^10.3.2
  share_plus: ^11.1.0
  local_auth: ^2.3.0
  flutter_local_notifications: ^19.4.1

dev_dependencies:
  build_runner: ^2.7.0
  drift_dev: ^2.28.2
  freezed: ^3.2.3
  json_serializable: ^6.11.0
  flutter_lints: ^6.0.0
```

版本号需以实际创建项目时为准。

