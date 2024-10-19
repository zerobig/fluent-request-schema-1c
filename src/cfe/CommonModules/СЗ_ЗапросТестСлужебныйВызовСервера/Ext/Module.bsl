﻿
Функция ПолучитьГруппуНоменклатуры() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	Номенклатура.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.ЭтоГруппа";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Ссылка;
	
КонецФункции

Функция ПолучитьНоменклатуруНеСписке(МассивНоменклатуры) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Номенклатура.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.Ссылка НЕ В (&МассивНоменклатуры)";
	
	Запрос.УстановитьПараметр("МассивНоменклатуры", МассивНоменклатуры);
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");

КонецФункции

Процедура ПроверитьПодобноПоРегулярномуВыражению(ТаблицаЗначений) Экспорт
	
	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Наименование").СодержитСтрокуПоШаблону("(Х|х)леб"))
	
КонецПроцедуры

Процедура ПроверитьНеПодобноПоРегулярномуВыражению(ТаблицаЗначений) Экспорт

	ЮТест.ОжидаетЧто(ТаблицаЗначений)
		.КаждыйЭлементСоответствуетПредикату(ЮТест.Предикат()
			.Реквизит("Наименование").НеСодержитСтрокуПоШаблону("(Х|х)леб"))
	
КонецПроцедуры
