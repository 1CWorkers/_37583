﻿
#Область ПрограммныйИнтерфейс_Алгоритмы

Процедура ВыполнитьПроцедуру(ПредставлениеАлгоритма,ВходящиеПараметры=Неопределено,ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "")Экспорт
  	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
		this = Новый Соответствие;
	КонецЕсли;
    ВыполнитьКодАлгоритмаНаКлиенте(this,ПредставлениеАлгоритма,ВходящиеПараметры);
    Отказ = ВходящиеПараметры.Отказ;
    СообщениеОбОшибке = ВходящиеПараметры.СообщениеОбОшибке;
КонецПроцедуры 

Функция ВыполнитьФункцию(ПредставлениеАлгоритма,ВходящиеПараметры=Неопределено, ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "") Экспорт
  	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
		this = Новый Соответствие;
	КонецЕсли;
    ВыполнитьКодАлгоритмаНаКлиенте(this,ПредставлениеАлгоритма,ВходящиеПараметры);
    Отказ = ВходящиеПараметры.Отказ;
    СообщениеОбОшибке = ВходящиеПараметры.СообщениеОбОшибке;
    Возврат this;
КонецФункции

#КонецОбласти

#Область ПрограммныйИнтерфейс_СообщенияДляПользователя

Процедура PopUp(ТекстСообщения ,Заголовок = Неопределено, СтатусВажное = Истина) Экспорт
    Если Не Заголовок = Неопределено Тогда
        ПоказатьОповещениеПользователя(Заголовок,,ТекстСообщения,БиблиотекаКартинок._37583_Робот,?(СтатусВажное,СтатусОповещенияПользователя.Важное,СтатусОповещенияПользователя.Информация));
    Иначе
        // чтобы не было скучно )
        мСообщений = Новый Массив;
        мСообщений.Добавить(" Есть ошибки ...");
        мСообщений.Добавить(" Ошибочка  ...");
        мСообщений.Добавить(" Ты ошибся бро ...");
        мСообщений.Добавить(" WTF ...");
        мСообщений.Добавить(" Не ошибается тот , кто не делает ...");
        мСообщений.Добавить(" Опять ошибка ...");
        мСообщений.Добавить(" Никогда не было и вот опять ...");
        мСообщений.Добавить(" Спокойно ща разберемся ...");
        мСообщений.Добавить(" Zzzzzzzzzz ...");
        мСообщений.Добавить(" Эммм ...");
        мСообщений.Добавить(" bla bla bla ...");
        мСообщений.Добавить(" Что за ...");
        
        гсч = Новый ГенераторСлучайныхЧисел();
        ранд = гсч.СлучайноеЧисло(0,мСообщений.Количество()-1);
        ПоказатьОповещениеПользователя(мСообщений[ранд],,">>> " + ТекстСообщения,БиблиотекаКартинок._37583_Робот,?(СтатусВажное,СтатусОповещенияПользователя.Важное,СтатусОповещенияПользователя.Информация));
    КонецЕсли;
КонецПроцедуры

Процедура ПоказатьОповещениеСДействием(Заголовок,ТекстОповещения,ДополнительныеПараметры) Экспорт
    Если ДополнительныеПараметры.Свойство("Объект") И  ДополнительныеПараметры.Свойство("Код") Тогда
        ОписаниеОповещения = Новый ОписаниеОповещения("ВыполнитьОперациюЗавершение", ЭтотОбъект, ДополнительныеПараметры);
        ПоказатьОповещениеПользователя(Заголовок,ОписаниеОповещения,ТекстОповещения,БиблиотекаКартинок._37583_Робот,СтатусОповещенияПользователя.Информация);
    КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// завершение асинхронных процедур
Процедура ВыполнитьЗавершение(Результат, ДополнительныеПараметры) Экспорт
    Если Не ДополнительныеПараметры.Свойство("АлгоритмЗавершение") Тогда 
        Возврат;
    Иначе
        ДополнительныеПараметры.Вставить("РезультатЗавершение",Результат);
        ВыполнитьПроцедуру(ДополнительныеПараметры.АлгоритмЗавершение, ДополнительныеПараметры);
    КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВыполнитьКодАлгоритмаНаКлиенте(this,ПредставлениеАлгоритма,Параметры)
    
    Если Не Параметры.Свойство("СообщениеОбОшибке") Тогда
        Параметры.Вставить("СообщениеОбОшибке",""); 
    КонецЕсли;
    
    Если Не Параметры.Свойство("Отказ") Тогда
        Параметры.Вставить("Отказ",Ложь); 
    КонецЕсли;
    
    СвойстваАлгоритма = _37583_ОбщегоНазначенияКлиентСервер.СвойстваДоступныеНаКлиентеИНаСервере();
   
   _37583_АлгоритмыСервер.ПолучитьСвойстваАлгоритма(ПредставлениеАлгоритма,СвойстваАлгоритма);
   
   Если  Не  СвойстваАлгоритма.Отказ Тогда
      
       Если СвойстваАлгоритма.ТолькоТекст Тогда
           ХранимыеПараметры = Новый Структура;
       Иначе
           Адрес = _37583_АлгоритмыСервер.ПолучитьПараметры(СвойстваАлгоритма.Ссылка,Истина);
           ХранимыеПараметры = ПолучитьИзВременногоХранилища(Адрес);
       КонецЕсли;	
       
       Для Каждого ХранимыйПараметр Из ХранимыеПараметры Цикл
           Если Не Параметры.Свойство(ХранимыйПараметр.Ключ) Тогда 
               Параметры.Вставить(ХранимыйПараметр.Ключ,ХранимыйПараметр.Значение);
           КонецЕсли;
       КонецЦикла;
       
       
       Попытка
           Выполнить(?(Параметры.Свойство("КодАлгоритма"),Параметры.КодАлгоритма,СвойстваАлгоритма.КодАлгоритма));
           Если СвойстваАлгоритма.ЗаписыватьСобытиияВЖР  Тогда 
               _37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации("_37583_ALG "," (&НаКлиенте) "+ СвойстваАлгоритма.Наименование,СвойстваАлгоритма.Ссылка, "Информация");
           КонецЕсли;
       Исключение
           Параметры.СообщениеОбОшибке = Параметры.СообщениеОбОшибке + " Ошибка: "+ОписаниеОшибки() + ";";
           Параметры.Отказ = Истина;
           _37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации(,Параметры.СообщениеОбОшибке);
           Если СвойстваАлгоритма.ВыбрасыватьИсключение Тогда
               ВызватьИсключение ОписаниеОшибки(); 
           КонецЕсли;
       КонецПопытки;
   Иначе 
       PopUp(СвойстваАлгоритма.СообщениеОбОшибке);
   КонецЕсли;
КонецПроцедуры

#КонецОбласти

