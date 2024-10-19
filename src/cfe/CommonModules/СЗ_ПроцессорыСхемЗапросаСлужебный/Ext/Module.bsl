﻿
#Область ПрограммныйИнтерфейс

// Возвращает результат выплнения запроса
//
// Параметры:
//   СтруктураСхемыЗапроса - Структура - описание запроса
//
// Возвращаемое значение:
//   РезультатЗапроса - результат выполнения запроса
//
Функция ПолучитьРезультатЗапроса(СтруктураСхемыЗапроса) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = ПолучитьТекстЗапроса(СтруктураСхемыЗапроса, Запрос);
	ДобавитьПараметрыЗапроса(СтруктураСхемыЗапроса, Запрос);
	
	Возврат Запрос.Выполнить();
	
КонецФункции

// Возвращает текст запроса по сформированной структуре
//
// Параметры:
//   СтруктураСхемыЗапроса - Структура - описание запроса
//   Запрос                - Запрос    - подготовленный запрос для установки параметров запроса
//
// Возвращаемое значение:
//   Строка - текст сформированного запроса
//
Функция ПолучитьТекстЗапроса(СтруктураСхемыЗапроса, Запрос) Экспорт
	
	Если Не ТипЗнч(СтруктураСхемыЗапроса) = Тип("Структура") Или
		Не СтруктураСхемыЗапроса.Свойство("ИсточникДанных") Или
		ПустаяСтрока(СтруктураСхемыЗапроса.ИсточникДанных) Тогда
		
		ВызватьИсключение "Источник данных запроса не определен";
	КонецЕсли;
	
	СхемаЗапроса = Новый СхемаЗапроса;

	ЗапросПакета = ДобавитьПолучитьПакет(СхемаЗапроса, СтруктураСхемыЗапроса);
	Оператор = ДобавитьПолучитьОператор(ЗапросПакета, СтруктураСхемыЗапроса);
	
	// Соединения добавляются раньше всех чтобы к моменту добавления полей у нас
	// уже были все возможные источники данных
	ДобавитьСоединения(Оператор, СтруктураСхемыЗапроса);
	ДобавитьПоля(ЗапросПакета, Оператор, СтруктураСхемыЗапроса);
	ДобавитьУсловия(Оператор, Запрос, СтруктураСхемыЗапроса);
	ДобавитьГруппировку(Оператор, СтруктураСхемыЗапроса);
	ДобавитьПорядок(ЗапросПакета, СтруктураСхемыЗапроса);
	ДобавитьИтоги(ЗапросПакета, СтруктураСхемыЗапроса);
	
	ТекстЗапроса = СхемаЗапроса.ПолучитьТекстЗапроса();
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьПолучитьПакет(СхемаЗапроса, СтруктураСхемыЗапроса)
	
	ПакетЗапросов = СхемаЗапроса.ПакетЗапросов;
	Если ПакетЗапросов.Количество() = 1 И СхемаЗапроса.ПолучитьТекстЗапроса() = "" Тогда
		ЗапросПакета = ПакетЗапросов[0];
	Иначе
		ЗапросПакета = СхемаЗапроса.ПакетЗапросов.Добавить(Тип("ЗапросВыбораСхемыЗапроса"));
	КонецЕсли;

	Если СтруктураСхемыЗапроса.Свойство("Разрешенные") И СтруктураСхемыЗапроса.Разрешенные Тогда
		ЗапросПакета.ВыбиратьРазрешенные = Истина;
	КонецЕсли;
	
	Возврат ЗапросПакета;
	
КонецФункции

Функция ДобавитьПолучитьОператор(ЗапросПакета, СтруктураСхемыЗапроса)
	
	Если ЗапросПакета.Операторы.Количество() = 1 Тогда
		Оператор = ЗапросПакета.Операторы[0];
		Если НЕ Оператор.Источники.Количество() = 0 ИЛИ НЕ Оператор.ВыбираемыеПоля.Количество() = 0 Тогда
			Оператор = Неопределено;
		КонецЕсли;
	КонецЕсли;
	Если Оператор = Неопределено Тогда
		Оператор = ЗапросПакета.Операторы.Добавить();
	КонецЕсли;
	
	Если СтруктураСхемыЗапроса.Свойство("Первые") И СтруктураСхемыЗапроса.Первые > 0 Тогда
		Оператор.КоличествоПолучаемыхЗаписей = СтруктураСхемыЗапроса.Первые;
	КонецЕсли;
	Если СтруктураСхемыЗапроса.Свойство("Различные") И СтруктураСхемыЗапроса.Различные Тогда
		Оператор.ВыбиратьРазличные = Истина;
	КонецЕсли;
	
	Если  ТипЗнч(СтруктураСхемыЗапроса.ИсточникДанных) = Тип("Строка") Тогда
		Оператор.Источники.Добавить(СтруктураСхемыЗапроса.ИсточникДанных);
	Иначе
		Если ТипЗнч(СтруктураСхемыЗапроса.ИсточникДанных) = Тип("ОбработкаОбъект.СЗ_ПроцессорСхемЗапроса") Тогда
			СтруктураСхемыВложенногоЗапроса = СтруктураСхемыЗапроса.ИсточникДанных.Получить();
		Иначе
			СтруктураСхемыВложенногоЗапроса = СтруктураСхемыЗапроса.ИсточникДанных;
		КонецЕсли;
		
		ВложенныйЗапрос = ПолучитьЗапрос(СтруктураСхемыВложенногоЗапроса);
		Если Не СтруктураСхемыВложенногоЗапроса.Свойство("ПсевдонимИсточника") Или
			ПустаяСтрока(СтруктураСхемыВложенногоЗапроса.ПсевдонимИсточника) Тогда
			
			ВызватьИсключение "У вложенного запроса обязательно должен быть псевдоним";
		КонецЕсли;
		
		ИсточникСхемыЗапроса = Оператор.Источники.Добавить(Тип("ВложенныйЗапросСхемыЗапроса"),
			СтруктураСхемыВложенногоЗапроса.ПсевдонимИсточника);
		ИсточникСхемыЗапроса.Источник.Запрос.УстановитьТекстЗапроса(ВложенныйЗапрос);
	КонецЕсли;
	
	Возврат Оператор;
	
КонецФункции

Процедура ДобавитьПоля(ЗапросПакета, Оператор, СтруктураСхемыЗапроса)
	
	Если СтруктураСхемыЗапроса.Свойство("Поля") И
		ТипЗнч(СтруктураСхемыЗапроса.Поля) = Тип("Массив") И
		СтруктураСхемыЗапроса.Поля.Количество() > 0 Тогда
		
		Для каждого Поле Из СтруктураСхемыЗапроса.Поля Цикл
			Если Не Поле.Источник = Неопределено Тогда
				ИсточникПоля = Оператор.Источники.НайтиПоПсевдониму(Поле.Источник);
			Иначе
				ИсточникПоля = Оператор.Источники[0];
			КонецЕсли;
			
			Если Не ИсточникПоля = Неопределено Тогда
				ДоступноеПоле = ИсточникПоля.Источник.ДоступныеПоля.Найти(Поле.ИмяПоля);
				Если Не ДоступноеПоле = Неопределено Тогда
					НовоеПоле = Оператор.ВыбираемыеПоля.Добавить(ДоступноеПоле);
					Если Не Поле.Псевдоним = Неопределено Тогда
						ЗапросПакета.Колонки[ЗапросПакета.Колонки.Количество() - 1].Псевдоним = Поле.Псевдоним;
					КонецЕсли;
				Иначе
					ВызватьИсключение СтрШаблон("Поле %1 в источнике не определено", Поле.ИмяПоля);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	Иначе
		ЕстьСсылка = Ложь;
		Для каждого Источник Из Оператор.Источники Цикл
			Если Не Источник.Источник.ДоступныеПоля.Найти("Ссылка") = Неопределено Тогда
				ЕстьСсылка = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если Не ЕстьСсылка Или (СтруктураСхемыЗапроса.Свойство("ВсеПоля") И СтруктураСхемыЗапроса.ВсеПоля) Тогда
			Для каждого Источник Из Оператор.Источники Цикл
				Для каждого Поле Из Источник.Источник.ДоступныеПоля Цикл
					Оператор.ВыбираемыеПоля.Добавить(Поле);
				КонецЦикла;
			КонецЦикла;
		Иначе
			Оператор.ВыбираемыеПоля.Добавить(Оператор.Источники[0].Источник.ДоступныеПоля.Найти("Ссылка"));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьУсловия(Оператор, Запрос, СтруктураСхемыЗапроса)
	
	Если СтруктураСхемыЗапроса.Свойство("Условия") И ТипЗнч(СтруктураСхемыЗапроса.Условия) = Тип("Массив") Тогда
		Для каждого Условие Из СтруктураСхемыЗапроса.Условия Цикл
			// Такая ситуация может возникнуть когда передают два параметра для функции МЕЖДУ
			Если Не ПустаяСтрока(Условие.УсловиеСтрокой) Тогда
				Оператор.Отбор.Добавить(Условие.УсловиеСтрокой);
			КонецЕсли;
			Запрос.УстановитьПараметр(Условие.ИмяПараметра, Условие.Значение);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьСоединения(Оператор, СтруктураСхемыЗапроса)
	
	Если СтруктураСхемыЗапроса.Свойство("Соединения") И ТипЗнч(СтруктураСхемыЗапроса.Соединения) = Тип("Массив") Тогда
		Для каждого СтруктураСоединения Из СтруктураСхемыЗапроса.Соединения Цикл
			Если ТипЗнч(СтруктураСоединения.ИсточникДанных) = Тип("Строка") Тогда
				ИсточникСоединения = Оператор.Источники.Добавить(СтруктураСоединения.ИсточникДанных,
					СтруктураСоединения.Псевдоним);
			Иначе
				ВложенныйЗапрос = ПолучитьЗапрос(СтруктураСоединения.ИсточникДанных);
				ИсточникСоединения = Оператор.Источники.Добавить(Тип("ВложенныйЗапросСхемыЗапроса"),
					СтруктураСоединения.Псевдоним);
				ИсточникСоединения.Источник.Запрос.УстановитьТекстЗапроса(ВложенныйЗапрос);
			КонецЕсли;
			Если Оператор.Источники[0].Соединения.Количество() = 0 Тогда
				Оператор.Источники[0].Соединения.Добавить(ИсточникСоединения);
			КонецЕсли;

			Условия = ПроверитьНаНеоднозначностьПолей(СтруктураСоединения.Условие,
				Оператор.Источники[0].Источник, ИсточникСоединения.Источник);
				
			Соединение = Оператор.Источники[0].Соединения[Оператор.Источники[0].Соединения.Количество() - 1];
			Соединение.Условие = Новый ВыражениеСхемыЗапроса(СтрСоединить(Условия, " И "));
			// TODO: Строки заменить на функцию?
			Если СтруктураСоединения.ТипСоединения = "Левое" Тогда
				Соединение.ТипСоединения = ТипСоединенияСхемыЗапроса.ЛевоеВнешнее;
			ИначеЕсли СтруктураСоединения.ТипСоединения = "Правое" Тогда
				Соединение.ТипСоединения = ТипСоединенияСхемыЗапроса.ПравоеВнешнее;
			ИначеЕсли СтруктураСоединения.ТипСоединения = "Внутреннее" Тогда
				Соединение.ТипСоединения = ТипСоединенияСхемыЗапроса.Внутреннее;
			ИначеЕсли СтруктураСоединения.ТипСоединения = "Полное" Тогда
				Соединение.ТипСоединения = ТипСоединенияСхемыЗапроса.ПолноеВнешнее;
			Иначе
				ВызватьИсключение СтрШаблон("ДобавитьСоединения: неподдерживаемый тип соединения %1",
					СтруктураСоединения.ТипСоединения);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьГруппировку(Оператор, СтруктураСхемыЗапроса)
	
	Если СтруктураСхемыЗапроса.Свойство("Группировка") И ТипЗнч(СтруктураСхемыЗапроса.Группировка) = Тип("Массив") Тогда
		Для каждого Группировка Из СтруктураСхемыЗапроса.Группировка Цикл
			Оператор.Группировка.Добавить(Группировка);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ДобавитьПорядок(ЗапросПакета, СтруктураСхемыЗапроса)
	
	Если СтруктураСхемыЗапроса.Свойство("Порядок") И ТипЗнч(СтруктураСхемыЗапроса.Порядок) = Тип("Массив") Тогда
		Для каждого ЭлементПорядка Из СтруктураСхемыЗапроса.Порядок Цикл
			ВыражениеПорядка = ЗапросПакета.Порядок.Добавить(ЭлементПорядка.ИмяПоля);
			Если НРег(ЭлементПорядка.Направление) = "убыв" Тогда
				ВыражениеПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоУбыванию;
				// TODO: возрастание иерархии, убывание иерархии
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ПроверитьНаНеоднозначностьПолей(МассивУсловий, ТаблицаОсновная, ТаблицаСоединения)
	
	// TODO: Пока не учитывается ситуация типа: "Ссылка = Ссылка"
	//       Похоже вообще не имеет смысла преобразовывать условие в строку на предыдущем этапе.
	//       Преобразовывать надо здесь с учетом неоднозначности полей. Рефакторинг!
	НовыйМассивУсловий = Новый Массив;
	
	Для каждого Условие Из МассивУсловий Цикл
		УсловиеСтрокой = Условие.УсловиеСтрокой;
		
		Если Не Условие.ЛеваяЧасть = Неопределено И
			Не ТаблицаОсновная.ДоступныеПоля.Найти(Условие.ЛеваяЧасть) = Неопределено И
			Не ТаблицаСоединения.ДоступныеПоля.Найти(Условие.ЛеваяЧасть) = Неопределено Тогда
			
			УсловиеСтрокой = СтрЗаменить(УсловиеСтрокой, Условие.ЛеваяЧасть,
				ТаблицаОсновная.Псевдоним + "." + Условие.ЛеваяЧасть);
		КонецЕсли;
		Если Не Условие.ПраваяЧасть = Неопределено И
			Не ТаблицаОсновная.ДоступныеПоля.Найти(Условие.ПраваяЧасть) = Неопределено И
			Не ТаблицаСоединения.ДоступныеПоля.Найти(Условие.ПраваяЧасть) = Неопределено Тогда
			
			УсловиеСтрокой = СтрЗаменить(УсловиеСтрокой, Условие.ПраваяЧасть,
				ТаблицаСоединения.Псевдоним + "." + Условие.ПраваяЧасть);
		КонецЕсли;
		
		НовыйМассивУсловий.Добавить(УсловиеСтрокой);
	КонецЦикла;
	
	Возврат НовыйМассивУсловий;
	
КонецФункции

Процедура ДобавитьИтоги(ЗапросПакета, СтруктураСхемыЗапроса)
	
	ТочкаОстанова = 1;
	
КонецПроцедуры

Процедура ДобавитьПараметрыЗапроса(СтруктураСхемыЗапроса, Запрос)
	
	Если СтруктураСхемыЗапроса.Свойство("Параметры") И ТипЗнч(СтруктураСхемыЗапроса.Параметры) = Тип("Массив") Тогда
		Для каждого Параметр Из СтруктураСхемыЗапроса.Параметры Цикл
			Запрос.УстановитьПараметр(Параметр.ИмяПараметра, Параметр.Значение);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьЗапрос(СтруктураСхемыЗапроса)
	
	Запрос = Новый Запрос;
	Возврат ПолучитьТекстЗапроса(СтруктураСхемыЗапроса, Запрос);
	
КонецФункции

#КонецОбласти
