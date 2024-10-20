﻿#Область ОписаниеПеременных

Перем Предикат;

#КонецОбласти

#Область ПрограммныйИнтерфейс

Функция Реквизит(ИмяРеквизита) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьИмяРеквизита(Предикат, ИмяРеквизита);
	Возврат ЭтотОбъект;
КонецФункции

Функция Равно(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().Равно, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция НеРавно(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().НеРавно, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция Больше(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().Больше, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция Меньше(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().Меньше, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция ВСписке(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().ВСписке, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция НеВСписке(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().НеВСписке, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция Подобно(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().Подобно, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция НеПодобно(Значение) Экспорт
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().НеПодобно, Значение);
	Возврат ЭтотОбъект;
КонецФункции

Функция Между(НачалоИнтервала, ОкончаниеИнтервала) Экспорт
	
	Значения = Новый Массив;
	Значения.Добавить(НачалоИнтервала);
	Значения.Добавить(ОкончаниеИнтервала);
	
	СЗ_ПроцессорыПредикатовСлужебныйКлиентСервер.УстановитьПредикат(Предикат,
		СЗ_ПроцессорыПредикатовКлиентСервер.Выражения().Между, Значения);
		
	Возврат ЭтотОбъект;
	
КонецФункции

Функция Получить() Экспорт
	
	Возврат Предикат;
	
КонецФункции

#КонецОбласти
