---
sidebar_position: 2
tags: [Функционал]
---

# Сортировка (УПОРЯДОЧИТЬ ПО)

## Общий вариант

```bsl
ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
    .Выбрать("Ссылка, ЭтоГруппа")
    .Упорядочить("ЭтоГруппа, Наименование")
    .ВТаблицуЗначений();
```

## С указанием направления

```bsl
ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
    .Выбрать("Ссылка, ЭтоГруппа")
    .Упорядочить("ЭтоГруппа УБЫВ, Наименование")
    .ВТаблицуЗначений();
```

:::info

Варианты сортировки с учетом иерархии находятся в разработке

:::