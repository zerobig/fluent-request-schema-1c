﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КонструкторЗапроса(Команда)

	ТекстаЗапросаСтрокой = ТекстЗапроса.ПолучитьТекст();
	Если Не ПустаяСтрока(ТекстаЗапросаСтрокой) Тогда
		КонструкторЗапроса = ПолучитьКонструкторЗапроса(ТекстаЗапросаСтрокой);
		Если КонструкторЗапроса = Неопределено Тогда
			Возврат;
		КонецЕсли;
	Иначе
		КонструкторЗапроса = Новый КонструкторЗапроса;
	КонецЕсли;

	ОписаниеОповещения = Новый ОписаниеОповещения("КонструкторЗапроса_ОповещениеЗакрытияКонструктора", ЭтаФорма);
	КонструкторЗапроса.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура КонструкторЗапроса_ОповещениеЗакрытияКонструктора(Результат, ДополнительныеПараметры) Экспорт
	
	ТекстЗапроса.УстановитьТекст(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура Преобразовать(Команда)
	
	ПреобразоватьНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПолучитьКонструкторЗапроса(ТекстЗапроса)
	
	Попытка
		КонструкторЗапроса = Новый КонструкторЗапроса(ТекстЗапроса);
	Исключение
		
		// TODO:
		
		Возврат Неопределено;
		
	КонецПопытки;
	
	Возврат КонструкторЗапроса;
	
	
КонецФункции

&НаСервере
Процедура ПреобразоватьНаСервере()
	
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапроса.ПолучитьТекст());
	
	ТекстФункциональногоЗапроса = ПолучитьРезультатПреобразования(СхемаЗапроса);
	Результат.УстановитьТекст(ТекстФункциональногоЗапроса);
	
КонецПроцедуры

Функция ПолучитьРезультатПреобразования(СхемаЗапроса)
	
	// TODO: Пакетные запросы пока не поддерживаются
	ПакетЗапроса = СхемаЗапроса.ПакетЗапросов[0];
	Оператор = ПакетЗапроса.Операторы[0];
	
	МассивСтрокЗапроса = Новый Массив;
	МассивСтрокЗапроса.Добавить(СтрШаблон("СЗ_Запрос.НовыйЗапрос(""%1"")",
		Оператор.Источники[0].Источник.ИмяТаблицы));
		
	СтрокаПолей = ПолучитьПоля(ПакетЗапроса);
	Если Не ПустаяСтрока(СтрокаПолей) Тогда
		МассивСтрокЗапроса.Добавить(СтрШаблон(Символы.Таб + ".Выбрать(""%1"")", СтрокаПолей));
	КонецЕсли;
	
	СтрокаОтборов = ПолучитьОтборы();
	Если Не ПустаяСтрока(СтрокаОтборов) Тогда
		МассивСтрокЗапроса.Добавить(СтрШаблон(Символы.Таб + ".Где(СЗ_Запрос.Предикат()
		|		%1)", СтрокаОтборов));
	КонецЕсли;

	СтрокаГруппировок = ПолучитьГруппировки(Оператор);
	Если Не ПустаяСтрока(СтрокаГруппировок) Тогда
		МассивСтрокЗапроса.Добавить(СтрШаблон(Символы.Таб + ".Сгруппировать(""%1"")", СтрокаГруппировок));
	КонецЕсли;
	
	СтрокаПорядка = ПолучитьПорядок(ПакетЗапроса);
	Если Не ПустаяСтрока(СтрокаПорядка) Тогда
		МассивСтрокЗапроса.Добавить(СтрШаблон(Символы.Таб + ".Упорядочить(""%1"")", СтрокаПорядка));
	КонецЕсли;

	СтрокаИтогов = ПолучитьИтоги(ПакетЗапроса);
	Если Не ПустаяСтрока(СтрокаИтогов) Тогда
		МассивСтрокЗапроса.Добавить(СтрШаблон(Символы.Таб + ".Итоги(""%1"")", СтрокаИтогов));
	КонецЕсли;
	
	МассивСтрокЗапроса.Добавить(Символы.Таб + ".ВТаблицуЗначений()");
	МассивСтрокЗапроса.Добавить(";");
	Возврат СтрСоединить(МассивСтрокЗапроса, Символы.ПС);
	
КонецФункции

Функция ПолучитьПоля(ПакетЗапроса)

	СтрокаПолей = "";
	Для каждого Колонка Из ПакетЗапроса.Колонки Цикл
		Если ПакетЗапроса.Колонки.Количество() = 1 И СтрНайти(Колонка.Поля[0], "Ссылка") > 0 Тогда
			Прервать;
		КонецЕсли;
		Если Не ПустаяСтрока(СтрокаПолей) Тогда
			СтрокаПолей = СтрокаПолей + ", ";
		КонецЕсли;
		
		ПолеБезИсточника = УбратьИсточник(ПакетЗапроса.Операторы[0].Источники[0].Источник.Псевдоним, Колонка.Поля[0]);
		СтрокаПолей = СтрокаПолей + ПолеБезИсточника + ДобавитьПсевдоним(Колонка.Псевдоним, ПолеБезИсточника);
	КонецЦикла;

	Возврат СтрокаПолей;
	
КонецФункции

Функция ПолучитьОтборы()
	
	СтрокаОтборов = "";
	
	// TODO:
	
	Возврат СтрокаОтборов;
	
КонецФункции

Функция ПолучитьГруппировки(Оператор)
	
	СтрокаГруппировок = "";
	Для каждого ЭлементГруппировки Из Оператор.Группировка Цикл
		Если Не ПустаяСтрока(СтрокаГруппировок) Тогда
			СтрокаГруппировок = СтрокаГруппировок + ", ";
		КонецЕсли;

		Поле = УбратьИсточник(Оператор.Источники[0].Источник.Псевдоним, ЭлементГруппировки);
		СтрокаГруппировок = СтрокаГруппировок + Поле;
	КонецЦикла;
	
	Возврат СтрокаГруппировок;
	
КонецФункции

Функция ПолучитьПорядок(ПакетЗапроса)
	
	СтрокаПорядка = "";
	Для каждого ЭлементПорядка Из ПакетЗапроса.Порядок Цикл
		Если Не ПустаяСтрока(СтрокаПорядка) Тогда
			СтрокаПорядка = СтрокаПорядка + ", ";
		КонецЕсли;
		
		Если ТипЗнч(ЭлементПорядка.Элемент) = Тип("КолонкаСхемыЗапроса") Тогда
			Поле = УбратьИсточник(ПакетЗапроса.Операторы[0].Источники[0].Источник.Псевдоним, ЭлементПорядка.Элемент.Поля[0]);
		Иначе
			Поле = УбратьИсточник(ПакетЗапроса.Операторы[0].Источники[0].Источник.Псевдоним, ЭлементПорядка.Элемент);
		КонецЕсли;
		Если ЭлементПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоУбыванию Тогда
			Поле = Поле + " УБЫВ";
		ИначеЕсли ЭлементПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоВозрастаниюИерархии Тогда
			Поле = Поле + " ИЕРАРХИЯ";
		ИначеЕсли ЭлементПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоУбываниюИерархии Тогда
			Поле = Поле + " ИЕРАРХИЯ УБЫВ";
		КонецЕсли;
		
		СтрокаПорядка = СтрокаПорядка + Поле;
	КонецЦикла;
	
	Возврат СтрокаПорядка;
	
КонецФункции

Функция УбратьИсточник(ПсевдонимИсточника, Поле)
	
	Если СтрНачинаетсяС(Поле, ПсевдонимИсточника + ".") Тогда
		Возврат Сред(Поле, СтрДлина(ПсевдонимИсточника + ".") + 1);
	КонецЕсли;
	
	Возврат Поле;
	
КонецФункции

Функция ДобавитьПсевдоним(Псевдоним, ПолеБезИсточника)
	
	Если ПолеБезИсточника = Псевдоним Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат СтрШаблон(" КАК %1", Псевдоним);
	
КонецФункции

Функция ПолучитьИтоги(ПакетЗапроса)
	
	СтрокаИтогов = "";
	Для каждого ЭлементИтогов Из ПакетЗапроса.КонтрольныеТочкиИтогов Цикл
		Если Не ПустаяСтрока(СтрокаИтогов) Тогда
			СтрокаИтогов = СтрокаИтогов + ", ";
		КонецЕсли;
		
		СтрокаИтогов = СтрокаИтогов + ЭлементИтогов.ИмяКолонки;
	КонецЦикла;
	
	Возврат СтрокаИтогов;
	
КонецФункции

#КонецОбласти
