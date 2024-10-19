﻿#Область ПрограммныйИнтерфейс

Процедура УстановитьИсточникДанных(СхемаЗапроса, ИсточникДанных, Первые, Различные, Разрешенные) Экспорт
	
	Если СхемаЗапроса = Неопределено Тогда
		СхемаЗапроса = Новый Структура;
	КонецЕсли;
	
	СхемаЗапроса.Вставить("ИсточникДанных", ИсточникДанных);
	Если Первые >= 0 Тогда
		СхемаЗапроса.Вставить("Первые", Первые);
	КонецЕсли;
	СхемаЗапроса.Вставить("Различные", Различные);
	СхемаЗапроса.Вставить("Разрешенные", Разрешенные);
	
КонецПроцедуры

Процедура УстановитьПсевдонимИсточника(СхемаЗапроса, Псевдоним) Экспорт
	
	СхемаЗапроса.Вставить("ПсевдонимИсточника", Псевдоним);
	
КонецПроцедуры

Процедура УстановитьПервые(СхемаЗапроса, Количество) Экспорт
	
	СхемаЗапроса.Вставить("Первые", Количество);
	
КонецПроцедуры

Процедура УстановитьРазличные(СхемаЗапроса) Экспорт
	
	СхемаЗапроса.Вставить("Различные", Истина);
	
КонецПроцедуры

Процедура УстановитьРазрешенные(СхемаЗапроса) Экспорт
	
	СхемаЗапроса.Вставить("Разрешенные", Истина);
	
КонецПроцедуры

Процедура УстановитьВыборВсехПолей(СхемаЗапроса) Экспорт
	
	СхемаЗапроса.Вставить("ВсеПоля", Истина);
	
КонецПроцедуры

Процедура УстановитьПоляВыборки(СхемаЗапроса, Поля) Экспорт
	
	Если ТипЗнч(Поля) = Тип("Строка") Тогда
		НовыеПоля = ПолучитьПоляИзСтроки(Поля);
	ИначеЕсли ТипЗнч(Поля) = Тип("Массив") Тогда
		НовыеПоля = Поля;
	ИначеЕсли ТипЗнч(Поля) = Тип("Структура") Тогда
		НовыеПоля = Новый Массив;
		НовыеПоля.Добавить(Поля);
	Иначе
		ВызватьИсключение "УстановитьПоляВыборки: неподдерживаемый тип данных в параметре ""Поля""";
	КонецЕсли;
	
	МассивПолей = Новый Массив;
	Если СхемаЗапроса.Свойство("Поля") И ТипЗнч(СхемаЗапроса.Поля) = Тип("Массив") Тогда
		МассивПолей = СхемаЗапроса.Поля;
	КонецЕсли;
	Для каждого НовоеПоле Из НовыеПоля Цикл
		Поле = ПолучитьПоле(НовоеПоле);
		МассивПолей.Добавить(Поле);
	КонецЦикла;

	СхемаЗапроса.Вставить("Поля", МассивПолей);
	
КонецПроцедуры

Процедура УстановитьИмяВременнойТаблицы(СхемаЗапроса, ИмяВременнойТаблицы) Экспорт
	
	СхемаЗапроса.Вставить("ИмяВременнойТаблицы", ИмяВременнойТаблицы);
	
КонецПроцедуры

Процедура УстановитьУсловие(СхемаЗапроса, Предикат) Экспорт
	
	СхемаЗапроса.Вставить("Условия", ПолучитьУсловияОтбора(Предикат));
	
КонецПроцедуры

Процедура ДобавитьСоединение(СхемаЗапроса, ТипСоединения, ИсточникДанных, Предикат) Экспорт
	
	МассивСоединений = Новый Массив;
	Если СхемаЗапроса.Свойство("Соединения") И ТипЗнч(СхемаЗапроса.Поля) = Тип("Массив") Тогда
		МассивСоединений = СхемаЗапроса.Соединения;
	КонецЕсли;
		
	Если ТипЗнч(ИсточникДанных) = Тип("Строка") Тогда
		Псевдоним = "";
		Если СтрНайти(ИсточникДанных, " КАК ") > 0 Тогда
			ИнформацияОбИсточникеДанных = СтрЗаменить(ИсточникДанных, " КАК ", Символы.ПС);
			ИсточникДанных = СтрПолучитьСтроку(ИнформацияОбИсточникеДанных, 1);
			Псевдоним =  СтрПолучитьСтроку(ИнформацияОбИсточникеДанных, 2);
		КонецЕсли;
	Иначе // Вложенный запрос
		Если Не ИсточникДанных.Свойство("ПсевдонимИсточника") Или
			ПустаяСтрока(ИсточникДанных.ПсевдонимИсточника) Тогда
			
			ВызватьИсключение "ДобавитьСоединение: у вложенного запроса обязательно должен быть псевдоним";
		КонецЕсли;

		Псевдоним = ИсточникДанных.ПсевдонимИсточника;
	КонецЕсли;
		
	МассивСоединений.Добавить(Новый Структура("ТипСоединения, ИсточникДанных, Псевдоним, Условие",
		ТипСоединения, ИсточникДанных, Псевдоним, ПолучитьУсловияСоединения(Предикат)));
	СхемаЗапроса.Вставить("Соединения", МассивСоединений);
	
КонецПроцедуры

Процедура УстановитьГруппировку(СхемаЗапроса, Поля) Экспорт
	
	Если ТипЗнч(Поля) = Тип("Строка") Тогда
		НовыеПоля = ПолучитьПоляИзСтроки(Поля);
	ИначеЕсли ТипЗнч(Поля) = Тип("Массив") Тогда
		НовыеПоля = Поля;
	Иначе
		ВызватьИсключение "УстановитьГруппировку: неподдерживаемый тип данных в параметре ""Поля""";
	КонецЕсли;
	
	МассивПолей = Новый Массив;
	Если СхемаЗапроса.Свойство("Группировка") И ТипЗнч(СхемаЗапроса.Поля) = Тип("Массив") Тогда
		МассивПолей = СхемаЗапроса.Поля;
	КонецЕсли;
	Для каждого НовоеПоле Из НовыеПоля Цикл
		МассивПолей.Добавить(НовоеПоле);
	КонецЦикла;
	
	СхемаЗапроса.Вставить("Группировка", МассивПолей);
	
КонецПроцедуры

Процедура УстановитьПорядок(СхемаЗапроса, Поля) Экспорт
	
	Если ТипЗнч(Поля) = Тип("Строка") Тогда
		НовыеПоля = ПолучитьПоляИзСтроки(Поля);
	ИначеЕсли ТипЗнч(Поля) = Тип("Массив") Тогда
		НовыеПоля = Поля;
	Иначе
		ВызватьИсключение "УстановитьПорядок: неподдерживаемый тип данных в параметре ""Поля""";
	КонецЕсли;
	
	МассивПолей = Новый Массив;
	Если СхемаЗапроса.Свойство("Порядок") И ТипЗнч(СхемаЗапроса.Поля) = Тип("Массив") Тогда
		МассивПолей = СхемаЗапроса.Порядок;
	КонецЕсли;
	Для каждого НовоеПоле Из НовыеПоля Цикл
		МассивПолей.Добавить(ПолучитьЭлементПорядка(НовоеПоле));
	КонецЦикла;
	
	СхемаЗапроса.Вставить("Порядок", МассивПолей);
	
КонецПроцедуры

Процедура УстановитьИтоги(СхемаЗапроса, Поля) Экспорт
	
	Если ТипЗнч(Поля) = Тип("Строка") Тогда
		НовыеПоля = ПолучитьПоляИзСтроки(Поля);
	ИначеЕсли ТипЗнч(Поля) = Тип("Массив") Тогда
		НовыеПоля = Поля;
	Иначе
		ВызватьИсключение "УстановитьИтоги: неподдерживаемый тип данных в параметре ""Поля""";
	КонецЕсли;
	
	МассивПолей = Новый Массив;
	Если СхемаЗапроса.Свойство("Итоги") И ТипЗнч(СхемаЗапроса.Поля) = Тип("Массив") Тогда
		МассивПолей = СхемаЗапроса.Итоги;
	КонецЕсли;
	Для каждого НовоеПоле Из НовыеПоля Цикл
		МассивПолей.Добавить(НовоеПоле);
	КонецЦикла;
	
	СхемаЗапроса.Вставить("Итоги", МассивПолей);
	
КонецПроцедуры

Процедура УстановитьПараметры(СхемаЗапроса, Параметры) Экспорт
	
	СхемаЗапроса.Вставить("Параметры", Параметры);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьПоляИзСтроки(СтрокаИменПолей)
	
	МассивПолей = СтрРазделить(СтрокаИменПолей, ",", Ложь);
	Для Сч = 0 По МассивПолей.Количество() - 1 Цикл
		МассивПолей[Сч] = СокрЛП(МассивПолей[Сч]);
	КонецЦикла;
	
	Возврат МассивПолей;
	
КонецФункции

Функция ПолучитьПоле(Поле)
	
	// TODO: Строки проверять на корректность синтаксиса - отсутствие пробелов и спец.символов
	
	Если ТипЗнч(Поле) = Тип("Строка") Тогда
		
		Если СтрНайти(Поле, " КАК ") > 0 Тогда
			ИнформацияОПоле = СтрЗаменить(Поле, " КАК ", Символы.ПС);
			Возврат Новый Структура("ИмяПоля, Источник, Псевдоним",
				ПолучитьИмяПоляБезИсточника(СтрПолучитьСтроку(ИнформацияОПоле, 1)),
				ПолучитьИсточникИзИмениПоля(Поле),
				СтрПолучитьСтроку(ИнформацияОПоле, 2));
		КонецЕсли;
			
		Возврат Новый Структура("ИмяПоля, Источник, Псевдоним",
			ПолучитьИмяПоляБезИсточника(Поле),
			ПолучитьИсточникИзИмениПоля(Поле),
			Неопределено);
			
	ИначеЕсли ТипЗнч(Поле) = Тип("Структура") Тогда
		
		Если Поле.Свойство("ИмяПоля") Тогда
			Если Поле.Свойство("Источник") И Не Поле.Источник = Неопределено Тогда
				Если Поле.Свойство("Псевдоним") Тогда
					Возврат Поле;
				КонецЕсли;
				
				Возврат Новый Структура("ИмяПоля, Источник, Псевдоним",
					ПолучитьИмяПоляБезИсточника(Поле.ИмяПоля),
					ПолучитьИсточникИзИмениПоля(Поле.ИмяПоля),
					Неопределено);
			КонецЕсли;
			
			Если Поле.Свойство("Псевдоним") Тогда
				Возврат Новый Структура("ИмяПоля, Источник, Псевдоним",
					ПолучитьИмяПоляБезИсточника(Поле.ИмяПоля),
					ПолучитьИсточникИзИмениПоля(Поле.ИмяПоля),
					Поле.Псевдоним);
			КонецЕсли;
			
			Возврат Новый Структура("ИмяПоля, Источник, Псевдоним",
				ПолучитьИмяПоляБезИсточника(Поле.ИмяПоля),
				ПолучитьИсточникИзИмениПоля(Поле.ИмяПоля),
				Неопределено);
		КонецЕсли;
		
		ВызватьИсключение "ПолучитьПоле: некорректная структура передана в параметре ""Поле""";
		
	КонецЕсли;

	ВызватьИсключение "ПолучитьПоле: неподдерживаемый тип данных в параметре ""Поле""";
	
КонецФункции

Функция ПолучитьИмяПоляБезИсточника(ИмяПоля)
	
	Если СтрНайти(ИмяПоля, ".") > 0 Тогда
		МассивЭлементовПоля = СтрРазделить(ИмяПоля, ".");
		МассивЭлементовПоля.Удалить(0);
		Возврат СтрСоединить(МассивЭлементовПоля, ".");
	КонецЕсли;
	
	Возврат ИмяПоля;
	
КонецФункции

Функция ПолучитьИсточникИзИмениПоля(ИмяПоля)
	
	Если СтрНайти(ИмяПоля, ".") > 0 Тогда
		МассивЭлементовПоля = СтрРазделить(ИмяПоля, ".");
		Возврат МассивЭлементовПоля[0];
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция ПолучитьУсловияОтбора(Предикат)
	
	// TODO: Нумерация (Сч) сквозная через все запросы
	
	МассивУсловий = Новый Массив;
	Сч = 0;
	
	Для каждого Условие Из Предикат.Условия Цикл
		ИмяПараметра = СтрШаблон("Параметр_%1", Сч);
		
		Шаблон = ШаблонУсловия(Условие.ВидСравнения);
		Если СтрНайти(Шаблон, "%3") > 0 Тогда
			Сч = Сч + 1;
			ИмяВторогоПараметра = СтрШаблон("Параметр_%1", Сч);
			
			УсловиеСтрокой = СтрШаблон(Шаблон, Условие.ИмяРеквизита, ИмяПараметра, ИмяВторогоПараметра);
			МассивУсловий.Добавить(Новый Структура("ИмяПараметра, УсловиеСтрокой, Значение",
				ИмяПараметра, УсловиеСтрокой, Условие.Значение[0]));
			МассивУсловий.Добавить(Новый Структура("ИмяПараметра, УсловиеСтрокой, Значение",
				ИмяВторогоПараметра, "", Условие.Значение[1]));
		ИначеЕсли СтрНайти(Шаблон, "%4") > 0 Тогда
			УсловиеСтрокой = СтрШаблон(Шаблон, Условие.ИмяРеквизита, """%""",, ИмяПараметра);
			МассивУсловий.Добавить(Новый Структура("ИмяПараметра, УсловиеСтрокой, Значение",
				ИмяПараметра, УсловиеСтрокой, Условие.Значение));
		Иначе
			УсловиеСтрокой = СтрШаблон(Шаблон, Условие.ИмяРеквизита, ИмяПараметра);
			МассивУсловий.Добавить(Новый Структура("ИмяПараметра, УсловиеСтрокой, Значение",
				ИмяПараметра, УсловиеСтрокой, Условие.Значение));
		КонецЕсли;
		
		Сч = Сч + 1;
	КонецЦикла;
	
	Возврат МассивУсловий;
	
КонецФункции

Функция ПолучитьУсловияСоединения(Предикат)
	
	МассивУсловий = Новый Массив;
	Если Предикат = Неопределено Тогда
		МассивУсловий.Добавить(
			Новый Структура("ЛеваяЧасть, ПраваяЧасть, УсловиеСтрокой",,, "ИСТИНА"));
			
		Возврат МассивУсловий;
	КонецЕсли;
	
	Для каждого Условие Из Предикат.Условия Цикл
		Шаблон = ШаблонУсловия(Условие.ВидСравнения, Ложь);
		МассивУсловий.Добавить(Новый Структура("ЛеваяЧасть, ПраваяЧасть, УсловиеСтрокой",
			Условие.ИмяРеквизита, Условие.Значение, СтрШаблон(Шаблон, Условие.ИмяРеквизита, Условие.Значение)));
	КонецЦикла;
	
	Возврат МассивУсловий;
	
КонецФункции

Функция ШаблонУсловия(ВидСравнения, Амперсанд = Истина)
	
	Выражения = СЗ_ПроцессорыПредикатовКлиентСервер.Выражения();
	
	Если ВидСравнения = Выражения.Равно Тогда
		Шаблон = "%1 = " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.НеРавно Тогда
		Шаблон = "НЕ %1 = " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.Больше Тогда
		Шаблон = "%1 > " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.БольшеИлиРавно Тогда
		Шаблон = "%1 >= " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.Меньше Тогда
		Шаблон = "%1 < " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.МеньшеИлиРавно Тогда
		Шаблон = "%1 <= " + ?(Амперсанд, "&", "") + "%2";
	ИначеЕсли ВидСравнения = Выражения.ВСписке Тогда
		Шаблон = "%1 В (" + ?(Амперсанд, "&", "") + "%2)";
	ИначеЕсли ВидСравнения = Выражения.НеВСписке Тогда
		Шаблон = "%1 НЕ В (" + ?(Амперсанд, "&", "") + "%2)";
	ИначеЕсли ВидСравнения = Выражения.Подобно Тогда
		Шаблон = "%1 ПОДОБНО %2 + " + ?(Амперсанд, "&", "") + "%4 + %2";
	ИначеЕсли ВидСравнения = Выражения.НеПодобно Тогда
		Шаблон = "НЕ %1 ПОДОБНО %2 + " + ?(Амперсанд, "&", "") + "%4 + %2";
	ИначеЕсли ВидСравнения = Выражения.Между Тогда
		Шаблон = "%1 МЕЖДУ " + ?(Амперсанд, "&", "") + "%2 И " + ?(Амперсанд, "&", "") + "%3";
	Иначе
		ВызватьИсключение "Неподдерживаемое выражение предиката " + ВидСравнения;
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

Функция ПолучитьЭлементПорядка(Поле)
	
	_Поле = СокрЛП(Поле);
	
	Если СтрНайти(_Поле, " ") > 0 Тогда
		МассивЭлементовПоля = СтрРазделить(_Поле, " ");
		Возврат Новый Структура("ИмяПоля, Направление",
			МассивЭлементовПоля[0], МассивЭлементовПоля[1])
	КонецЕсли;
		
	Возврат Новый Структура("ИмяПоля, Направление",
		_Поле, Неопределено);
	
КонецФункции

#КонецОбласти
