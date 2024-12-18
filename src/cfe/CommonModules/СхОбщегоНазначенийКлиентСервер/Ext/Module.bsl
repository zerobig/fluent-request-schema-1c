﻿
#Область ПрограммныйИнтерфейс

Функция ПодготовиьРеквизитСУчетомФункции(Предикат) Экспорт
	
	Если ПустаяСтрока(Предикат.ИмяФункции) Тогда
		Возврат Предикат.ИмяРеквизита;
	КонецЕсли;
	
	Если Предикат.ИмяФункции = "Выразить" Тогда
		Возврат СтрШаблон("ВЫРАЗИТЬ(%1 КАК %2)",
			Предикат.ИмяРеквизита,
			ПолучитьТипИзОписания(Предикат.ПараметрыФункции[0]));
	ИначеЕсли Предикат.ИмяФункции = "ВыборКогда" Тогда
		ВызватьИсключение "ПодготовиьРеквизитСУчетомФункции: не реализовано";
		
		Возврат СтрШаблон("ВЫБОР
		|	КОГДА %1
		|		ТОГДА %2
		|	ИНАЧЕ %3
		|КОНЕЦ", , , );
	КонецЕсли;
	
	ТекстИсключения = СтрШаблон("ПодготовиьРеквизитСУчетомФункции: неизвестная функция %1",
		Предикат.ИмяФункции);
	ВызватьИсключение ТекстИсключения;
	
КонецФункции

Функция ПолучитьТипИзОписания(ОписаниеТипа) Экспорт
	
	Если ОписаниеТипа.СодержитТип(Тип("Строка")) Тогда
		Возврат СтрШаблон("СТРОКА(%1)",
			Формат(ОписаниеТипа.КвалификаторыСтроки.Длина, "ЧГ=0"))
	ИначеЕсли ОписаниеТипа.СодержитТип(Тип("Число")) Тогда
		Возврат СтрШаблон("ЧИСЛО(%1.%2)",
			Формат(ОписаниеТипа.КвалификаторыЧисла.Разрядность, "ЧГ=0"),
			Формат(ОписаниеТипа.КвалификаторыЧисла.Разрядность.ДробнойЧасти, "ЧГ=0"))
	ИначеЕсли ОписаниеТипа.СодержитТип(Тип("Дата")) Тогда
		Возврат "ДАТА";
	Иначе
		// TODO: Ссылочные типы данных
	КонецЕсли;
	
	ВызватьИсключение "ПолучитьТипИзОписания: неизвестный тип данных для выражения";
	
КонецФункции

#КонецОбласти
