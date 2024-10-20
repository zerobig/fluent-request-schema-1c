﻿#Область ОбъявлениеТестов

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты.УдалениеТестовыхДанных()
		.ДобавитьТестовыйНабор("СЗ: Базовые")
			.ДобавитьТест("ИсключениеИсточникОтсутствует")
			.ДобавитьТест("ИсключениеИсточникПустаяСтрока")
			.ДобавитьТест("ЗапросВТаблицуЗначений")
			.ДобавитьТест("ЗапросВМассив")
			.ДобавитьТест("Первые")
			.ДобавитьТест("Различные")
			.ДобавитьТест("Разрешенные")
		.ДобавитьТестовыйНабор("СЗ: Поля")
			.ДобавитьТест("ИсключениеПолеОтсутствует")
			.ДобавитьТест("ДобавитьПоляССинонимами")
			.ДобавитьТест("ДобавитьНесколькоПолей")
			.ДобавитьТест("ДобавитьНесколькоПолейСПереносомСтроки")
			.ДобавитьТест("ДобавитьПоляССинонимамиИСписком")
			.ДобавитьТест("ВсеПоляДляНеСсылочногоТипа")
			.ДобавитьТест("ВсеПоляДляСсылочногоТипа")
		.ДобавитьТестовыйНабор("СЗ: Условия")
			.ДобавитьТест("ЗапросСУсловиемРавно")
			.ДобавитьТест("ЗапросСУсловиемНеРавно")
			.ДобавитьТест("ЗапросСУсловиемПодобно")
			.ДобавитьТест("ЗапросСУсловиемНеПодобно")
			.ДобавитьТест("ЗапросСУсловиемМежду")
			.ДобавитьТест("ЗапросСУсловиемВСписке")
				.Перед("Перед_ЗапросСУсловиемВСписке")
			.ДобавитьТест("ЗапросСУсловиемНеВСписке")
				.Перед("Перед_ЗапросСУсловиемНеВСписке")
		.ДобавитьТестовыйНабор("СЗ: Соединения")
			.ДобавитьТест("СоединениеПоИсточникуСтроке")
				.СПараметрами("Левое")
				.СПараметрами("Правое")
				.СПараметрами("Внутреннее")
			.ДобавитьТест("ЛевоеСоединениеПоИсточникуЗапросу")
			.ДобавитьТест("ЛевоеСоединениеСГлубокоВложеннымЗапросом")
			.ДобавитьТест("ЛевоеСоединениеБезПредиката")
			.ДобавитьТест("ЛевоеСоединениеНесколькоУсловийВПредикате")
			.ДобавитьТест("ЛевоеСоединениеПредикатЭтоПараметр")
			.ДобавитьТест("ЛевоеСоединениеБезПсевдонимовВСоединении")
			.ДобавитьТест("НесколькоЛевыхСоединений")
		.ДобавитьТестовыйНабор("СЗ: Вложенный запрос")
			.ДобавитьТест("ИсключениеВложенныйЗапросБезПсевдонима")
			.ДобавитьТест("ВложенныйЗапрос")
			.ДобавитьТест("ОченьГлубокоВложенныйЗапрос")
		.ДобавитьТестовыйНабор("СЗ: Объединить")
			.ДобавитьТест("Объединить")
			.ДобавитьТест("ОбъединитьВсе")
			.ДобавитьТест("ОбъединитьВсеНаЧетыреИсточника")
			.ДобавитьТест("ОбъединитьВсеСПолями")
			.ДобавитьТест("ОбъединитьВсеСРазнымКоличествомПолей")
			.ДобавитьТест("ОбъединитьВсеСВложеннымЗапросом")
		.ДобавитьТестовыйНабор("СЗ: Прочее")
			.ДобавитьТест("Порядок")
			.ДобавитьТест("ПорядокУбывания")
			.ДобавитьТест("Итоги")
		.ДобавитьТестовыйНабор("СЗ: Реальные запросы")
			.ДобавитьТест("АдресныйКлассификаторСлужебный_ТаблицаАдресныхСокращений")
				.Перед("Перед_АдресныйКлассификаторСлужебный_ТаблицаАдресныхСокращений")
	;
	
КонецПроцедуры

#КонецОбласти

#Область События

Процедура Перед_ЗапросСУсловиемВСписке() Экспорт
	
	ПодготовитьСписокНоменклатуры();
	
КонецПроцедуры

Процедура Перед_ЗапросСУсловиемНеВСписке() Экспорт
	
	ПодготовитьСписокНоменклатуры();
	
	Контекст = ЮТест.КонтекстТеста();
	
	МассивНоменклатуры = СЗ_ЗапросТестСлужебныйВызовСервера
		.ПолучитьНоменклатуруНеСписке(Контекст.МассивНоменклатуры);
	Контекст.Вставить("МассивНоменклатурыНеВСписке", МассивНоменклатуры);
	
КонецПроцедуры

Процедура Перед_АдресныйКлассификаторСлужебный_ТаблицаАдресныхСокращений() Экспорт
	
	Для Сч = 1 По 3 Цикл
		ЮТест.Данные().КонструкторОбъекта("РегистрСведений.УровниСокращенийАдресныхСведений")
			.Установить("Значение", "Абонентский Ящик")
			.Установить("Сокращение", "А/Я")
			.Записать()
		;
	КонецЦикла;
	Для Сч = 1 По 5 Цикл
		ЮТест.Данные().КонструкторОбъекта("РегистрСведений.УровниСокращенийАдресныхСведений")
			.Установить("Значение", "Деревня")
			.Установить("Сокращение", "Д.")
			.Записать()
		;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Тесты

#Область Базовые

Процедура ИсключениеИсточникОтсутствует() Экспорт
	
	Обработка = ПолучитьФорму("Обработка.СЗ_ПроцессорСхемЗапроса.Форма.Форма");
	
	ЮТест.ОжидаетЧто(Обработка)
		.Метод("ВТаблицуЗначений")
		.ВыбрасываетИсключение("ПолучитьТекстЗапроса: источник данных запроса не определен");
	
КонецПроцедуры

Процедура ИсключениеИсточникПустаяСтрока() Экспорт
	
	Запрос = СЗ_Запрос.НовыйЗапрос("");
	
	ЮТест.ОжидаетЧто(Запрос)
		.Метод("ВТаблицуЗначений")
		.ВыбрасываетИсключение("ПолучитьТекстЗапроса: источник данных запроса не определен");
	
КонецПроцедуры

Процедура ЗапросВТаблицуЗначений() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	
КонецПроцедуры

Процедура ЗапросВМассив() Экспорт
	
	Массив = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.ВМассив("Ссылка")
	;
	
	ЮТест.ОжидаетЧто(Массив)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(Массив.Количество())
		.Больше(0)
	;
	
КонецПроцедуры

Процедура Первые() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура", 10)
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Равно(10)
	;
	
КонецПроцедуры

Процедура Различные() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура",, Истина)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;

КонецПроцедуры

Процедура Разрешенные() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура",,, Истина)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	
КонецПроцедуры

#КонецОбласти

#Область Поля

// TODO: Поля могут быть выражениями

Процедура ИсключениеПолеОтсутствует() Экспорт
	
	НеправильноеНаименованиеПоля = "йцукен";
	
	Запрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать(НеправильноеНаименованиеПоля)
	;

	ЮТест.ОжидаетЧто(Запрос)
		.Метод("ВТаблицуЗначений")
		.ВыбрасываетИсключение(
			СтрШаблон("Поле %1 в источнике не определено", НеправильноеНаименованиеПоля));
	
КонецПроцедуры

Процедура ДобавитьПоляССинонимами() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать(СЗ_Запрос.НовоеПоле("Ссылка",, "СсылкаНоменклатуры"))
		.Выбрать(СЗ_Запрос.НовоеПоле("Наименование",, "НаименованиеНоменклатуры"))
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("СсылкаНоменклатуры")
		.ИмеетСвойство("НаименованиеНоменклатуры")
	;
	
КонецПроцедуры

Процедура ДобавитьНесколькоПолей() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, Наименование, ЭтоГруппа")
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("Наименование")
		.ИмеетСвойство("ЭтоГруппа")
	;
	
КонецПроцедуры

Процедура ДобавитьНесколькоПолейСПереносомСтроки() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, Наименование,
			|ЭтоГруппа")
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("Наименование")
		.ИмеетСвойство("ЭтоГруппа")
	;
	
КонецПроцедуры

Процедура ДобавитьПоляССинонимамиИСписком() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать(СЗ_Запрос.НовоеПоле("Ссылка",, "СсылкаНоменклатуры"))
		.Выбрать("Наименование КАК НаименованиеНоменклатуры, ЭтоГруппа")
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("СсылкаНоменклатуры")
		.ИмеетСвойство("НаименованиеНоменклатуры")
		.ИмеетСвойство("ЭтоГруппа")
	;
	
КонецПроцедуры

Процедура ВсеПоляДляНеСсылочногоТипа() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("РегистрСведений.КурсыВалют")
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Валюта")
		.ИмеетСвойство("Курс")
		.ИмеетСвойство("Кратность")
	;
	
КонецПроцедуры

Процедура ВсеПоляДляСсылочногоТипа() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.ВыбратьВсе()
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("Наименование")
		.ИмеетСвойство("ЭтоГруппа")
	;
	
КонецПроцедуры

#КонецОбласти

#Область Условия

Процедура ЗапросСУсловиемРавно() Экспорт
	
	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("ЭтоГруппа").Равно(Ложь)
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, ЭтоГруппа")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("ЭтоГруппа").Равно(Ложь))
	;

КонецПроцедуры

Процедура ЗапросСУсловиемНеРавно() Экспорт
	
	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("ЭтоГруппа").НеРавно(Ложь)
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, ЭтоГруппа")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("ЭтоГруппа").Равно(Истина))
	;

КонецПроцедуры

Процедура ЗапросСУсловиемПодобно() Экспорт
	
	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("Наименование").Подобно("Хлеб")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, Наименование")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	Утверждения = ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
	;
	
	СЗ_ЗапросТестСлужебныйВызовСервера.ПроверитьПодобноПоРегулярномуВыражению(ТаблицаЗначений);

КонецПроцедуры

Процедура ЗапросСУсловиемНеПодобно() Экспорт
	
	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("Наименование").НеПодобно("Хлеб")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, Наименование")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
	;

	СЗ_ЗапросТестСлужебныйВызовСервера.ПроверитьНеПодобноПоРегулярномуВыражению(ТаблицаЗначений);
	
КонецПроцедуры

Процедура ЗапросСУсловиемМежду() Экспорт
	
	ДатаНачала = Дата("20230601000000");
	ДатаОкончания = Дата("20230630235959");
	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("Дата").Между(ДатаНачала, ДатаОкончания)
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ЗаказКлиента")
		.Выбрать("Ссылка, Дата")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Дата").Между(ДатаНачала, ДатаОкончания))
	;

КонецПроцедуры

Процедура ЗапросСУсловиемВСписке() Экспорт
	
	Контекст = ЮТест.КонтекстТеста();

	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("Ссылка").ВСписке(Контекст.МассивНоменклатуры)
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлину(5)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ВСписке(Контекст.МассивНоменклатуры))
	;
	
КонецПроцедуры

Процедура ЗапросСУсловиемНеВСписке() Экспорт

	Контекст = ЮТест.КонтекстТеста();

	Предикат = СЗ_Запрос.Предикат()
		.Реквизит("Ссылка").НеВСписке(Контекст.МассивНоменклатуры)
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Где(Предикат)
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ВСписке(Контекст.МассивНоменклатурыНеВСписке))
	;

КонецПроцедуры

#КонецОбласти

#Область Соединения

Процедура СоединениеПоИсточникуСтроке(ТипСоединения) Экспорт
	
	ПредикатДляСоединения = СЗ_Запрос.Предикат()
		.Реквизит("НоменклатураСоединение.Ссылка").Равно("Номенклатура.Родитель")
	;
	
	Запрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка,
			|НоменклатураСоединение.Ссылка КАК НоменклатураСоединениеСсылка")
	;
	Если ТипСоединения = "Левое" Тогда
		Запрос
			.ЛевоеСоединение("Справочник.Номенклатура КАК НоменклатураСоединение", ПредикатДляСоединения)
		;
	ИначеЕсли ТипСоединения = "Правое" Тогда
		Запрос
			.ПравоеСоединение("Справочник.Номенклатура КАК НоменклатураСоединение", ПредикатДляСоединения)
		;
	Иначе // Если ТипСоединения = "Внутреннее" Тогда
		Запрос
			.ВнутреннееСоединение("Справочник.Номенклатура КАК НоменклатураСоединение", ПредикатДляСоединения)
		;
	КонецЕсли;
	
	ТаблицаЗначений = Запрос.ВТаблицуЗначений();
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("НоменклатураСоединениеСсылка")
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеПоИсточникуЗапросу() Экспорт
	
	ЗапросДляСоединения = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Псевдоним("НоменклатураСоединение")
	;
	ПредикатДляСоединения = СЗ_Запрос.Предикат()
		.Реквизит("Ссылка").Равно("Родитель")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка,
			|НоменклатураСоединение.Ссылка КАК НоменклатураСоединениеСсылка")
		.ЛевоеСоединение(ЗапросДляСоединения, ПредикатДляСоединения)
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("НоменклатураСоединениеСсылка")
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеСГлубокоВложеннымЗапросом() Экспорт
	
	ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, Родитель")
		.Псевдоним("ВложенныйЗапрос_0")
	;

	Для Сч = 1 По 9 Цикл
		ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос)
			.Выбрать("Ссылка, Родитель")
			.Псевдоним("ВложенныйЗапрос_" + Сч)
		;
	КонецЦикла;

	ПредикатДляСоединения = СЗ_Запрос.Предикат()
		.Реквизит("Ссылка").Равно("Родитель")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка,
			|ВложенныйЗапрос_9.Ссылка КАК ВложенныйЗапрос_9Ссылка")
		.ЛевоеСоединение(ВложенныйЗапрос, ПредикатДляСоединения)
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").Заполнено())
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("ВложенныйЗапрос_9Ссылка").Заполнено())
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеБезПредиката() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("РегистрСведений.ПримененияЕНВД")
		.Выбрать("ПримененияЕНВД.Организация КАК Организация,
			|ПримененияЕНВДСоединение.Склад КАК Склад")
		.ЛевоеСоединение("РегистрСведений.ПримененияЕНВД КАК ПримененияЕНВДСоединение")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Организация")
		.ИмеетСвойство("Склад")
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеНесколькоУсловийВПредикате() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка,
			|НоменклатураСоединение.Ссылка КАК НоменклатураСоединениеСсылка")
		.ЛевоеСоединение("Справочник.Номенклатура КАК НоменклатураСоединение", СЗ_Запрос.Предикат()
			.Реквизит("НоменклатураСоединение.Ссылка").Равно("Номенклатура.Родитель")
			.Реквизит("НоменклатураСоединение.ЭтоГруппа").Равно("ИСТИНА"))
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("НоменклатураСоединениеСсылка")
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеПредикатЭтоПараметр() Экспорт

	// Подготовка
	МассивПараметров = Новый Массив;
	МассивПараметров.Добавить(Новый Структура("ИмяПараметра, Значение",
		"Родитель", СЗ_ЗапросТестСлужебныйВызовСервера.ПолучитьГруппуНоменклатуры()));
	
	// Выполнение
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка,
			|НоменклатураСоединение.Ссылка КАК НоменклатураСоединениеСсылка")
		.ЛевоеСоединение("Справочник.Номенклатура КАК НоменклатураСоединение", СЗ_Запрос.Предикат()
			.Реквизит("НоменклатураСоединение.Родитель").Равно("&Родитель"))
		.Параметры(МассивПараметров)
		.ВТаблицуЗначений()
	;
	
	// Проверки
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("НоменклатураСоединениеСсылка")
	;
	
КонецПроцедуры

Процедура ЛевоеСоединениеБезПсевдонимовВСоединении() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка, Номенклатура1.Ссылка")
		.ЛевоеСоединение("Справочник.Номенклатура", СЗ_Запрос.Предикат()
			.Реквизит("Ссылка").Равно("Родитель")
			.Реквизит("ЭтоГруппа").Равно("ИСТИНА"))
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("Ссылка1")
	;
	
КонецПроцедуры

Процедура НесколькоЛевыхСоединений() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Номенклатура.Ссылка, Номенклатура1.Ссылка, Номенклатура2.Ссылка")
		.ЛевоеСоединение("Справочник.Номенклатура", СЗ_Запрос.Предикат()
			.Реквизит("Ссылка").Равно("Родитель")
			.Реквизит("ЭтоГруппа").Равно("ИСТИНА"))
		.ЛевоеСоединение("Справочник.Номенклатура", СЗ_Запрос.Предикат()
			.Реквизит("Ссылка").Равно("Родитель")
			.Реквизит("ЭтоГруппа").Равно("ИСТИНА"))
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений.Количество())
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений[0])
		.ИмеетСвойство("Ссылка")
		.ИмеетСвойство("Ссылка1")
		.ИмеетСвойство("Ссылка2")
	;
	
КонецПроцедуры

#КонецОбласти

#Область ВложенныеЗапросы

Процедура ИсключениеВложенныйЗапросБезПсевдонима() Экспорт
	
	ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура");
	
	Запрос = СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос);

	ЮТест.ОжидаетЧто(Запрос)
		.Метод("ВТаблицуЗначений")
		.ВыбрасываетИсключение("У вложенного запроса обязательно должен быть псевдоним");
	
КонецПроцедуры

Процедура ВложенныйЗапрос() Экспорт
	
	ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Псевдоним("ВложенныйЗапрос")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос)
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
	;
	
КонецПроцедуры

Процедура ОченьГлубокоВложенныйЗапрос() Экспорт
	
	ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Псевдоним("ВложенныйЗапрос_0")
	;

	Для Сч = 1 По 9 Цикл
		ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос)
			.Псевдоним("ВложенныйЗапрос_" + Сч)
		;
	КонецЦикла;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос)
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
	;
	
КонецПроцедуры

#КонецОбласти

#Область Объединить

Процедура Объединить() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.Объединить("Документ.РеализацияТоваровУслуг")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг"))
	;

КонецПроцедуры

Процедура ОбъединитьВсе() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.ОбъединитьВсе("Документ.РеализацияТоваровУслуг")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг"))
	;
	
КонецПроцедуры

Процедура ОбъединитьВсеНаЧетыреИсточника() Экспорт

	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.ОбъединитьВсе("Документ.РеализацияТоваровУслуг")
		.ОбъединитьВсе("Документ.ВозвратТоваровОтКлиента")
		.ОбъединитьВсе("Документ.ВозвратТоваровПоставщику")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ВозвратТоваровОтКлиента"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ВозвратТоваровПоставщику"))
	;

КонецПроцедуры

Процедура ОбъединитьВсеСПолями() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.Выбрать("Ссылка, Дата, Номер")
		.ОбъединитьВсе(СЗ_Запрос.НовыйЗапрос("Документ.РеализацияТоваровУслуг")
			.Выбрать("Ссылка, Дата, Номер"))
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг"))
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Дата").Заполнено()
			.Реквизит("Номер").Заполнено())
	;
	
КонецПроцедуры

Процедура ОбъединитьВсеСРазнымКоличествомПолей() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.Выбрать("Ссылка, Дата, Номер")
		.ОбъединитьВсе(СЗ_Запрос.НовыйЗапрос("Документ.РеализацияТоваровУслуг")
			.Выбрать("Ссылка, Дата, Номер, Партнер"))
		.ВТаблицуЗначений()
	;

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг")
			.Реквизит("Партнер").Пусто())
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг")
			.Реквизит("Партнер").Заполнено())
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Дата").Заполнено()
			.Реквизит("Номер").Заполнено())
	;
	
КонецПроцедуры

Процедура ОбъединитьВсеСВложеннымЗапросом() Экспорт
	
	ВложенныйЗапрос = СЗ_Запрос.НовыйЗапрос("Документ.РеализацияТоваровУслуг")
		.Псевдоним("ВложенныйЗапрос")
		.Выбрать("Ссылка, Дата, Номер, Партнер")
	;
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Документ.ПриобретениеТоваровУслуг")
		.Выбрать("Ссылка, Дата, Номер")
		.ОбъединитьВсе(СЗ_Запрос.НовыйЗапрос(ВложенныйЗапрос)
			.Выбрать("Ссылка, Дата, Номер"))
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.ПриобретениеТоваровУслуг"))
		.ЛюбойЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Ссылка").ИмеетТип("ДокументСсылка.РеализацияТоваровУслуг"))
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Дата").Заполнено()
			.Реквизит("Номер").Заполнено())
	;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

Процедура Порядок() Экспорт
	
	// Выполнение
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, ЭтоГруппа")
		.Упорядочить("ЭтоГруппа, Наименование")
		.ВТаблицуЗначений()
	;

	// Проверки
	СпсисокЭлементов = Новый СписокЗначений;
	Сч = 0;
	Для каждого СтрокаТаблицы Из ТаблицаЗначений Цикл
		Если Не СтрокаТаблицы.ЭтоГруппа Тогда
			СпсисокЭлементов.Добавить(Сч);
		Иначе
			Прервать;
		КонецЕсли;
		Сч = Сч + 1;
	КонецЦикла;
	СпсисокЭлементов.СортироватьПоЗначению(НаправлениеСортировки.Убыв);
	Для каждого СтрокаТаблицыЭлементы Из СпсисокЭлементов Цикл
		ТаблицаЗначений.Удалить(СтрокаТаблицыЭлементы.Значение);
	КонецЦикла;
	
	ЮТест.ОжидаетЧто(СпсисокЭлементов.Количество(), "Количество элементов")
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0, "Количество групп")
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("ЭтоГруппа").Равно(Истина))
	;
	
КонецПроцедуры

Процедура ПорядокУбывания() Экспорт
	
	// Выполнение
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Выбрать("Ссылка, ЭтоГруппа")
		.Упорядочить("ЭтоГруппа УБЫВ, Наименование")
		.ВТаблицуЗначений()
	;

	// Проверки
	СпсисокГрупп = Новый СписокЗначений;
	Сч = 0;
	Для каждого СтрокаТаблицы Из ТаблицаЗначений Цикл
		Если СтрокаТаблицы.ЭтоГруппа Тогда
			СпсисокГрупп.Добавить(Сч);
		Иначе
			Прервать;
		КонецЕсли;
		Сч = Сч + 1;
	КонецЦикла;
	СпсисокГрупп.СортироватьПоЗначению(НаправлениеСортировки.Убыв);
	Для каждого СтрокаТаблицыГруппы Из СпсисокГрупп Цикл
		ТаблицаЗначений.Удалить(СтрокаТаблицыГруппы.Значение);
	КонецЦикла;

	ЮТест.ОжидаетЧто(СпсисокГрупп.Количество(), "Количество групп")
		.Больше(0)
	;
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0, "Количество элементов")
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("ЭтоГруппа").Равно(Ложь))
	;
	
КонецПроцедуры

Процедура Итоги() Экспорт
	
	ТаблицаЗначений = СЗ_Запрос.НовыйЗапрос("Справочник.Номенклатура")
		.Итоги("ЭтоГруппа")
		.ВТаблицуЗначений()
	;
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.ИмеетТип("Массив")
		.ИмеетДлинуБольше(0)
		.ЛюбойЭлементСодержитСвойство("ссылка", Null)
	;
	
КонецПроцедуры

#КонецОбласти

#Область РеальныеЗапросы

Процедура АдресныйКлассификаторСлужебный_ТаблицаАдресныхСокращений() Экспорт
	
	// Подготовка
	НаименованияАдресныхОбъектов = Новый Массив;
	НаименованияАдресныхОбъектов.Добавить("Абонентский Ящик");

	// Выполнение
	Запрос = СЗ_Запрос.НовыйЗапрос("РегистрСведений.УровниСокращенийАдресныхСведений")
		.Выбрать("Значение КАК Наименование, Сокращение")
		.Сгруппировать("Значение, Сокращение")
		.Упорядочить("Наименование");
	
	Если ТипЗнч(НаименованияАдресныхОбъектов) = Тип("Массив") И НаименованияАдресныхОбъектов.Количество() > 0 Тогда
		Запрос = Запрос
			.Где(СЗ_Запрос.Предикат()
				.Реквизит("Значение").ВСписке(НаименованияАдресныхОбъектов));
	КонецЕсли;
	
	Результат = Запрос.ВТаблицуЗначений();
	
	// Проверки
	ЮТест.ОжидаетЧто(Результат)
		.ИмеетТип("Массив")
	;
	ЮТест.ОжидаетЧто(Результат.Количество())
		.Равно(1)
	;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПодготовитьСписокНоменклатуры()

	ВидНоменклатуры = ЮТест.Данные().КонструкторОбъекта("Справочники.ВидыНоменклатуры")
		.Фикция("Наименование")
		.Установить("ТипНоменклатуры", ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар"))
		.Записать()
	;
	
	Массив = Новый Массив;
	
	Для Сч = 1 По 5 Цикл
		
		Номенклатура = ЮТест.Данные().КонструкторОбъекта("Справочники.Номенклатура")
			.Фикция("Наименование")
			.Установить("ВидНоменклатуры", ВидНоменклатуры)
			.Установить("ТипНоменклатуры", ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар"))
			.Установить("ИспользованиеХарактеристик",
				ПредопределенноеЗначение("Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.НеИспользовать"))
			.Записать()
		;
		
		Массив.Добавить(Номенклатура);
		
	КонецЦикла;
	
	Контекст = ЮТест.КонтекстТеста();
	Контекст.Вставить("МассивНоменклатуры", Массив);
	
КонецПроцедуры

#КонецОбласти
