---
sidebar_position: 2
tags: [Функционал]
---

# Итоги (ИТОГИ ПО)

```bsl
ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
    .Итоги("ЭтоГруппа")
    .ВТаблицуЗначений();
```
