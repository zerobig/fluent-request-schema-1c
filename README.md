# 1С Предприятие. Fluent запросы

[![OpenYellow](https://img.shields.io/endpoint?url=https://openyellow.org/data/badges/6/874099701.json)](https://openyellow.org/grid?data=top&repo=874099701)

## Мотивация

Смотрел я на запросы в 1С, потом смотрел на то как народ создаёт библиотеки с API в "текучем" стиле. И решил это совместить. Ведь есть же такой замечательный продукт от Microsoft - [Linq](https://learn.microsoft.com/ru-ru/dotnet/csharp/linq/standard-query-operators/)! Сначала подумал что буду первопроходцем. Но оказывается всё уже придумано до нас: [Раз](https://github.com/KalyakinAG/query-model), [Два](https://infostart.ru/1c/articles/1991009/). Может быть ещё что есть, а я не нашел.

## Описание

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

### Преимущества такого подхода:

* уменьшение количества кода при той же читабельности / наглядности;
* избавление от уродских конструкций типа:
```bls
Запрос.ТекстЗапроса = СтрЗаменить(Запрос.ТекстЗапроса, "&Условие", "Номенклатура.ЭтоГруппа = ЛОЖЬ");
```

### У существующих решений есть ряд недостатков:

* излишне многословны;
* не готовы к применению в рабочих конфигурациях;
* не соответствуют стандартам разработки;
* статья на инфостарте так и осталась лишь статьёй, не вылившись в какую-то готовую разработку;

### У моего решения тоже есть недостатки:

* отсутствует автодополнение кода;
* не полная функциональность (разработка пока в статусе 'beta')

### Личные переживания и сомнения в процессе разработки

Сначала я был полон энтузиазма. Потом, по мере написания кода, начали появляться сомнения. Нужно ли это? Верной ли дорогой иду? Но когда я увидел как вот это:
```bsl
Функция ТаблицаАдресныхСокращений(НаименованияАдресныхОбъектов)

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	УровниСокращенийАдресныхСведений.Значение КАК Наименование,
	|	УровниСокращенийАдресныхСведений.Сокращение КАК Сокращение
	|ИЗ
	|	РегистрСведений.УровниСокращенийАдресныхСведений КАК УровниСокращенийАдресныхСведений 
	|ГДЕ
	|	&Условие
	|
	|СГРУППИРОВАТЬ ПО
	|	УровниСокращенийАдресныхСведений.Значение,
	|	УровниСокращенийАдресныхСведений.Сокращение
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование";
	
	Если ТипЗнч(НаименованияАдресныхОбъектов) = Тип("Массив") И НаименованияАдресныхОбъектов.Количество() > 0 Тогда
		Условие = "ИСТИНА";
	Иначе
		Условие = "УровниСокращенийАдресныхСведений.Значение В(&АдресныеСокращения)";
		Запрос.УстановитьПараметр("АдресныеСокращения", НаименованияАдресныхОбъектов);
	КонецЕсли;
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&Условие", Условие);

	Возврат Запрос.Выполнить().Выгрузить();

КонецФункции
```
превратилось вот в это:
```bsl
Функция ТаблицаАдресныхСокращений(НаименованияАдресныхОбъектов)

	Запрос = СЗ_Запрос.НовыйЗапрос("РегистрСведений.УровниСокращенийАдресныхСведений")
		.Выбрать("Значение КАК Наименование, Сокращение")
		.Сгруппировать("Значение, Сокращение")
		.Упорядочить("Наименование");
	
	Если ТипЗнч(НаименованияАдресныхОбъектов) = Тип("Массив") И НаименованияАдресныхОбъектов.Количество() > 0 Тогда
		Запрос = Запрос
			.Где(СЗ_Запрос.Предикат()
				.Реквизит("Значение").В(НаименованияАдресныхОбъектов));
	КонецЕсли;
	
	Возврат Запрос.ВТаблицуЗначений();

КонецФункции
```
все сомнения отпали! 16 строк вместо 30-ти при сохранении общей читабельности. И качество кода улучшилось за счет отказа от конструкции `СтрЗаменить()`.

По-моему это заявка на успех!

## Документация

Документация находится по [адресу](https://zerobig.github.io/fluent-request-schema-1c/). Наполнение продолжается.

## Как запустить

* Вариант 1: скачать файл с расширением cf из раздела [Releases](https://github.com/zerobig/fluent-request-schema-1c/releases) и объединить со своей конфигурацией;
* Вариант 2: скачать файл с расширением cfe из раздела [Releases](https://github.com/zerobig/fluent-request-schema-1c/releases) и установить это расширение в свою базу данных;
* Вариант 3: скачать исходники из репозитория, собрать при помощи команды `npm run build` (потребуется установленная NodeJS) и использовать результаты сборки по своему усмотрению;

## Тестирование

Тесты писались при помощи расширения для запуска тестов [YAxUnit](https://github.com/bia-technologies/yaxunit). И выполнялись на типовой конфигурации Управление торговлей ред.11.5 (11.5.18.41). Это надо учитывать при самостоятельном запуске тестов.

## Идеи по дальнейшему развитию (roadmap)

- [x] создание документации;
- [ ] расширение API методов:
  - [ ] вложенные запросы;
  - [ ] пакетные запросы;
  - [ ] временные таблицы;
  - [ ] индексирование;
- [ ] увеличение полноты покрытия тестами;
- [ ] обработка-конструктор, которая преобразует обычный запрос 1С в "текучие" выражения и обратно;
- [ ] вариант библиотеки для [OneScript](https://github.com/EvilBeaver/OneScript). Пока не понятно, возможно ли и нужно ли? Идея на этапе исследования;
- [ ] CI/CD

## Благодарности

* [YAxUnit](https://github.com/bia-technologies/yaxunit) - ребята, вы лучшие!
* [1CFilesConverter](https://github.com/arkuznetsov/1CFilesConverter) - давно пользуюсь этими скриптами. Очень помогают.
