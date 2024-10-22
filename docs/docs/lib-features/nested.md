---
sidebar_position: 5
tags: [Функционал]
---

# Вложенные запросы

:::tip

Для вложенных запросов обязательно использование функции `Псевдоним`

:::

```bsl
ВложенныйЗапрос = СхЗапрос.НовыйЗапрос("Справочник.Номенклатура")
  .Псевдоним("ВложенныйЗапрос");

ТаблицаЗначений = СхЗапрос.НовыйЗапрос(ВложенныйЗапрос)
  .ВТаблицуЗначений();
```