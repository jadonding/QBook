# Features Layout

每个业务模块按以下结构组织：

- `presentation/`：页面、组件、状态绑定
- `application/`：用例和跨模块编排
- `domain/`：实体、值对象、仓储接口
- `data/`：数据源、DTO、仓储实现

建议新增功能时优先在 feature 内收敛依赖，避免跨模块直接访问底层数据实现。

