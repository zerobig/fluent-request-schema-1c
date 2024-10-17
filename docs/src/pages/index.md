---
sidebar_position: 0
slug: /
---

# 1С Предприятие. Fluent запросы

Библиотека позволяет писать запросы 1С Предприятия в функциональном стиле. Например, вот такой код:
```bsl
ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура").ВТаблицуЗначений();
```
будет аналогичен:
```bsl
Запрос = Новый Запрос;
Запрос.Текст = "ВЫБРАТЬ
|	Номенклатура.Ссылка КАК Ссылка
|ИЗ
|	Справочник.Номенклатура КАК Номенклатура";

ТаблицаЗначений = Запрос.Выполнить().Выгрузить();
```

## Благодарности

- [YAxUnit](https://github.com/bia-technologies/yaxunit)
- [1CFilesConverter](https://github.com/arkuznetsov/1CFilesConverter)

## Лицензия

Copyright © 2024 [Бушин Илья](https://github.com/zerobig/)

Distributed under the [MIT License](https://www.mit.edu/~amini/LICENSE.md)
