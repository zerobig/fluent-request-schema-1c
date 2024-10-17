﻿#Область ОписаниеПеременных

Перем СхемаЗапроса;

#КонецОбласти

#Область ПрограммныйИнтерфейс

Процедура УстановитьИсточникДанных(ИсточникДанных, Первые = -1, Различные = Ложь, Разрешенные = Ложь) Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер.УстановитьИсточникДанных(СхемаЗапроса,
		ИсточникДанных, Первые, Различные, Разрешенные);
КонецПроцедуры

Функция ВТаблицуЗначений() Экспорт
	ТаблицаЗначений = СЗ_ПроцессорыСхемЗапросаСлужебный
		.ПолучитьРезультатЗапроса(СхемаЗапроса).Выгрузить();
	Возврат ТаблицаЗначений;
КонецФункции

Функция ВМассив(ИмяКолонки) Экспорт
	ТаблицаЗначений = СЗ_ПроцессорыСхемЗапросаСлужебный
		.ПолучитьРезультатЗапроса(СхемаЗапроса).Выгрузить();
	Возврат ТаблицаЗначений.ВыгрузитьКолонку(ИмяКолонки);
КонецФункции

Функция Первые(Количество) Экспорт
	// TODO:
	Возврат ЭтотОбъект;
КонецФункции

Функция Различные() Экспорт
	// TODO:
	Возврат ЭтотОбъект;
КонецФункции

Функция Разрешенные() Экспорт
	// TODO:
	Возврат ЭтотОбъект;
КонецФункции

Функция Выбрать(Поля) Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер
		.УстановитьПоляВыборки(СхемаЗапроса, Поля);
	Возврат ЭтотОбъект;
КонецФункции

Функция ВыбратьВсе() Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер
		.УстановитьВыборВсехПолей(СхемаЗапроса);
	Возврат ЭтотОбъект;
КонецФункции

Функция Где(Предикат) Экспорт
	
	Если ТипЗнч(Предикат) = Тип("Структура") Тогда
		_Предикат = Предикат;
	ИначеЕсли ТипЗнч(Предикат) = Тип("ОбработкаОбъект.СЗ_ПроцессорПредикатов") Тогда
		_Предикат = Предикат.Получить();
	Иначе
		ВызватьИсключение "Неверный тип предиката в методе ""Где""";
	КонецЕсли;
	
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер.УстановитьУсловие(СхемаЗапроса, _Предикат);
	Возврат ЭтотОбъект;
КонецФункции

Функция ЛевоеСоединение(ИсточникДанных, Предикат = Неопределено) Экспорт

	// TODO: ИсточникДанных может быть структурой? Что делать в этом случае?
	Если ТипЗнч(ИсточникДанных) = Тип("Строка") Тогда
		_ИсточникДанных = ИсточникДанных;
	ИначеЕсли ТипЗнч(ИсточникДанных) = Тип("ОбработкаОбъект.СЗ_ПроцессорСхемЗапроса") Тогда
		_ИсточникДанных = ИсточникДанных.Получить();
	Иначе
		ВызватьИсключение "ЛевоеСоединение: неверный тип источника данных";
	КонецЕсли;
	
	Если ТипЗнч(Предикат) = Тип("Структура") Или Предикат = Неопределено Тогда
		_Предикат = Предикат;
	ИначеЕсли ТипЗнч(Предикат) = Тип("ОбработкаОбъект.СЗ_ПроцессорПредикатов") Тогда
		_Предикат = Предикат.Получить();
	Иначе
		ВызватьИсключение "ЛевоеСоединение: неверный тип предиката";
	КонецЕсли;

	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер.ДобавитьСоединение(
		СхемаЗапроса, "Левое", ИсточникДанных, _Предикат);
	Возврат ЭтотОбъект;
КонецФункции

Функция Сгруппировать(Поля) Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер
		.УстановитьГруппировку(СхемаЗапроса, Поля);
	Возврат ЭтотОбъект;
КонецФункции

Функция Упорядочить(Поля) Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер
		.УстановитьПорядок(СхемаЗапроса, Поля);
	Возврат ЭтотОбъект;
КонецФункции

Функция Итоги() Экспорт
	// TODO:
	Возврат ЭтотОбъект;
КонецФункции

Функция Параметры(Параметры) Экспорт
	СЗ_ПроцессорыСхемЗапросаСлужебныйКлиентСервер.УстановитьПараметры(СхемаЗапроса, Параметры);
	Возврат ЭтотОбъект;
КонецФункции

Функция Получить() Экспорт
	
	Возврат СхемаЗапроса;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции



#КонецОбласти
