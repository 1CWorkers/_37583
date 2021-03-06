﻿
#Область ПрограммныйИнтерфейс_РисованиеВТабличномДокументе

#Область Фигуры
// СтильРисунка- Структура
Процедура  УстановитьПараметрыРисунка(Рисунок,СтильРисунка=Неопределено)Экспорт
    Если ТипЗнч(СтильРисунка)= Тип("Структура") Тогда
        Для Каждого ЭлС Из СтильРисунка Цикл
            Попытка
                Рисунок[ЭлС.Ключ]=ЭлС.Значение;
            Исключение
            КонецПопытки;
        КонецЦикла; 
    КонецЕсли;
КонецПроцедуры

Функция Рисовать(ТабДок,Вид, Верх=Неопределено, Лево=Неопределено, Высота=Неопределено, Ширина=Неопределено) Экспорт
    НовыйРисунок = ТабДок.Рисунки.Добавить(ТипРисункаТабличногоДокумента[Вид]);
    Если Верх <> Неопределено 		Тогда 	НовыйРисунок.Верх=Верх;				КонецЕсли;
    Если Лево <> Неопределено 		Тогда 	НовыйРисунок.Лево=Лево;				КонецЕсли;
    Если Высота <> Неопределено 	Тогда 	НовыйРисунок.Высота=Высота; 	    КонецЕсли;
    Если Ширина <> Неопределено		Тогда 	НовыйРисунок.Ширина=Ширина;			КонецЕсли;
    Возврат НовыйРисунок;
КонецФункции

Функция Прямоугольник(ТабДок,Верх,Лево,Высота,Ширина) Экспорт
    Рисунок=Рисовать(ТабДок,"Прямоугольник",Верх,Лево,Высота,Ширина);
    Возврат  Рисунок;
КонецФункции

Функция Эллипс(ТабДок,Верх,Лево,Высота,Ширина) Экспорт
    Рисунок=Рисовать(ТабДок,"Эллипс",Верх,Лево,Высота,Ширина);
    Возврат  Рисунок;
КонецФункции

//ТочкаА,ТочкаБ - Структура (Верх,Лево)
Функция ЛинияАБ(ТабДок,ТочкаА,ТочкаБ,СтильРисунка=Неопределено)Экспорт 
    Рисунок=Рисовать(ТабДок,"Прямая",ТочкаА.Верх,ТочкаА.Лево,?(ТочкаА.Верх>ТочкаБ.Верх,(ТочкаА.Верх-ТочкаБ.Верх)*-1,ТочкаБ.Верх-ТочкаА.Верх),?(ТочкаА.Лево>ТочкаБ.Лево,(ТочкаА.Лево-ТочкаБ.Лево)*-1,ТочкаБ.Лево-ТочкаА.Лево));
    УстановитьПараметрыРисунка(Рисунок,СтильРисунка);
    Возврат  Рисунок;
КонецФункции

Функция  СтрелкаАБ(ТабДок,ТочкаА,ТочкаБ,ШиринаСтрелки,ВысотаСтрелки,СтильРисунка=Неопределено,Диаметр=0) Экспорт 
    ШиринаСтрелки =?(ШиринаСтрелки=0,4,ШиринаСтрелки); 	
    ВысотаСтрелки =?(ВысотаСтрелки=0,4,ВысотаСтрелки);
    ВысотаПр=МАКС(ТочкаА.Верх-ТочкаБ.Верх,ТочкаБ.Верх-ТочкаА.Верх);
    ШиринаПр=МАКС(ТочкаА.Лево-ТочкаБ.Лево,ТочкаБ.Лево-ТочкаА.Лево);
    Гипотенуза=Sqrt(Pow(ВысотаПр,2)+Pow(ШиринаПр,2));
    Pi = 3.1415926535897932;
    УголА= ?(Гипотенуза=0,0,ASin(ШиринаПр*sin(Pi/2)/Гипотенуза));
    УголБ= ?(Гипотенуза=0,0,ASin(ВысотаПр*sin(Pi/2)/Гипотенуза));
    ГптБ1=ВысотаСтрелки;
    ГптА2=ШиринаСтрелки/2;
    ВысБ1=ГптБ1*sin(УголБ)/sin(Pi/2);
    ШирБ1=ГптБ1*sin(УголА)/sin(Pi/2);
    ВысА2=ГптА2*sin(УголА)/sin(Pi/2);
    ШирА2=ГптА2*sin(УголБ)/sin(Pi/2);
    НаправлениеЛП=""; НаправлениеВН="";
    Если ТочкаБ.Лево>ТочкаА.Лево Тогда
        НаправлениеЛП="П";
    ИначеЕсли ТочкаБ.Лево<ТочкаА.Лево Тогда 
        НаправлениеЛП="Л";
    КонецЕсли;
    Если ТочкаБ.Верх>ТочкаА.Верх Тогда
        НаправлениеВН="Н";
    ИначеЕсли ТочкаБ.Верх<ТочкаА.Верх Тогда 
        НаправлениеВН="В";
    КонецЕсли;
    Направление=НаправлениеЛП+НаправлениеВН;
    
    Если Направление="П" Тогда
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх,ТочкаБ.Лево-ВысотаСтрелки);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаА.Верх-ШиринаСтрелки/2,ТочкаБ1.Лево);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаА.Верх+ШиринаСтрелки/2,ТочкаБ1.Лево);
    ИначеЕсли Направление="Л" Тогда
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх,ТочкаБ.Лево+ВысотаСтрелки);
        Тело=ЛинияАБ(ТабДок,ТочкаА,ТочкаБ1);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаА.Верх-ШиринаСтрелки/2,ТочкаБ1.Лево);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаА.Верх+ШиринаСтрелки/2,ТочкаБ1.Лево);
    ИначеЕсли Направление="В" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх+ВысотаСтрелки,ТочкаБ.Лево);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх,ТочкаБ1.Лево-ШиринаСтрелки/2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх,ТочкаБ1.Лево+ШиринаСтрелки/2);
    ИначеЕсли Направление="Н" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх-ВысотаСтрелки,ТочкаБ.Лево);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх,ТочкаБ1.Лево-ШиринаСтрелки/2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх,ТочкаБ1.Лево+ШиринаСтрелки/2);
    ИначеЕсли  Направление="ЛВ" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх+ВысБ1,ТочкаБ.Лево+ШирБ1);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх+ВысА2,ТочкаБ1.Лево-ШирА2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх-ВысА2,ТочкаБ1.Лево+ШирА2);
    ИначеЕсли Направление="ЛН" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх-ВысБ1,ТочкаБ.Лево+ШирБ1);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх-ВысА2,ТочкаБ1.Лево-ШирА2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх+ВысА2,ТочкаБ1.Лево+ШирА2);
    ИначеЕсли Направление="ПВ" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх+ВысБ1,ТочкаБ.Лево-ШирБ1);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх+ВысА2,ТочкаБ1.Лево+ШирА2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх-ВысА2,ТочкаБ1.Лево-ШирА2);
    ИначеЕсли Направление="ПН" Тогда 
        ТочкаБ1=Новый Структура("Верх,Лево",ТочкаБ.Верх-ВысБ1,ТочкаБ.Лево-ШирБ1);
        ТочкаА2=Новый Структура("Верх,Лево",ТочкаБ1.Верх-ВысА2,ТочкаБ1.Лево+ШирА2);
        ТочкаБ2=Новый Структура("Верх,Лево",ТочкаБ1.Верх+ВысА2,ТочкаБ1.Лево-ШирА2);
        
    КонецЕсли;
    мСтрелка=Новый Массив;
    р1=ЛинияАБ(ТабДок,ТочкаА,ТочкаБ1,СтильРисунка); мСтрелка.Добавить(р1);
    р2=ЛинияАБ(ТабДок,ТочкаА2,ТочкаБ2,СтильРисунка);мСтрелка.Добавить(р2);
    р3=ЛинияАБ(ТабДок,ТочкаА2,ТочкаБ,СтильРисунка); мСтрелка.Добавить(р3);
    р4=ЛинияАБ(ТабДок,ТочкаБ2,ТочкаБ,СтильРисунка); мСтрелка.Добавить(р4);
    Если Диаметр>0 Тогда 
        р5=Рисовать(ТабДок,"Эллипс", ТочкаА.Верх-Диаметр/2, ТочкаА.Лево-Диаметр/2,Диаметр,Диаметр);
        мСтрелка.Добавить(р5);
    КонецЕсли;
    Возврат  мСтрелка;
КонецФункции

// Примеры
Процедура РисуемЗмейку(ТабДок,X,Y,Лучей=6,ВысотаСтрелки=20,Основание=4)Экспорт
    А =  новый  Структура ("Верх,Лево", Y ,X  );
    гсч = Новый ГенераторСлучайныхЧисел;
    Для ё=1  по Лучей Цикл 
        в = гсч.СлучайноеЧисло(20,100);
        л = гсч.СлучайноеЧисло(20,120);
        Б = новый  Структура ("Верх,Лево", в ,л);
        Цвет=Новый Цвет(гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200));
        СтрелкаАБ(ТабДок,А ,Б,Основание,ВысотаСтрелки,Новый Структура ("ЦветЛинии", Цвет));
        А = Б;
    КонецЦикла;
КонецПроцедуры

Процедура РисуемКвадрат(ТабДок,X,Y,Сторона=40,ВысотаСтрелки=20,Основание=4)Экспорт
    А =  новый  Структура ("Верх,Лево", Y ,X  );
    гсч = Новый ГенераторСлучайныхЧисел;
    Для ё=1  по 4 Цикл 
        множ = ?(ё>2,-1,1); чет = ё%2; нечет=(ё+1)%2;
        в = А.Верх + Сторона*множ*нечет;
        л = А.Лево + Сторона*множ*чет;
        Б = новый  Структура ("Верх,Лево", в ,л);
        Цвет=Новый Цвет(гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200));
        СтрелкаАБ(ТабДок,А,Б,Основание,ВысотаСтрелки,Новый Структура ("ЦветЛинии", Цвет));
        А = Б;
    КонецЦикла;
КонецПроцедуры

Процедура РисуемЗвезду(ТабДок,X,Y,Лучей=12,ДлинаЛуча = 30,ВысотаСтрелки=20,Основание=4) Экспорт
    А =  новый  Структура ("Верх,Лево", Y , X );
    гсч = Новый ГенераторСлучайныхЧисел;
    Угол = 0;  
    Pi = 3.1415926535897932;
    Для Н=0 По Лучей Цикл
        л=X+sin(Угол)*ДлинаЛуча;
        в=Y-cos(Угол)*ДлинаЛуча;
        Угол = Угол + Pi*2/Лучей;
        Б = новый  Структура ("Верх,Лево", в ,л);
        Цвет=Новый Цвет(гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200),гсч.СлучайноеЧисло(1,200));
        СтрелкаАБ(ТабДок,А,Б,Основание,ВысотаСтрелки,Новый Структура ("ЦветЛинии", Цвет),4);
    КонецЦикла;
КонецПроцедуры

Процедура ЛоманаяЛиния(ТабДок,X,Y, Амплитуда= 30, Размер = 10) Экспорт
    ТочкаА = Новый Структура("Верх,Лево",Y ,X );
    Для ё = 1 по 10 Цикл 
        Знак = ?(ё%2=0,-1,1);
        Угол = 90+Знак*Амплитуда;
        Гипотенуза(ТабДок,Размер,Угол,ТочкаА);
    КонецЦикла;
КонецПроцедуры

Процедура Гипотенуза(ТабДок,Знач Размер,Знач УголГрад,ТочкаА)
    Pi = 3.1415926535897932;
    УлолРад = УголГрад*Pi/180;
    Л=ТочкаА.Лево+sin(УлолРад)*Размер;
    В=ТочкаА.Верх-cos(УлолРад)*Размер;
    ТочкаБ =Новый Структура("Верх,Лево",В,Л);
    ЛинияАБ(ТабДок,ТочкаА,ТочкаБ);
    ТочкаА = ТочкаБ;
КонецПроцедуры

#КонецОбласти 

#Область Текст

// СтильШрифта- Структура
Функция УстановитьПараметрыШрифта(СтильШрифта=Неопределено) Экспорт 
    Параметры=Новый Структура("Вид,Размер,Жирный,Наклонный,Подчеркнутый,Зачеркнутый");	
    Параметры.Вид="Calibri";
    Параметры.Размер=10;
    Если ТипЗнч(СтильШрифта)= Тип("Структура") Тогда 
        ЗаполнитьЗначенияСвойств(Параметры,СтильШрифта);
    КонецЕсли;
    Возврат Новый Шрифт(Параметры.Вид,Параметры.Размер,Параметры.Жирный,Параметры.Наклонный,Параметры.Подчеркнутый,Параметры.Зачеркнутый);
КонецФункции

// СтильТекста- Структура
Процедура УстановитьПараметрыТекста(Рисунок,СтильТекста=Неопределено)Экспорт
    Рисунок.АвтоРазмер=Истина;
    Рисунок.ГраницаСверху=Ложь;
    Рисунок.ГраницаСнизу=Ложь;
    Рисунок.ГраницаСлева=Ложь;
    Рисунок.ГраницаСправа=Ложь;
    Рисунок.Шрифт=УстановитьПараметрыШрифта(); 
    Если ТипЗнч(СтильТекста)= Тип("Структура") Тогда
        ЗаполнитьЗначенияСвойств(Рисунок,СтильТекста); 
    КонецЕсли;
КонецПроцедуры

Функция Текст(ТабДок,Текст,Верх,Лево,СтильТекста=Неопределено) Экспорт
    Рисунок=Рисовать(ТабДок,"Текст",Верх,Лево);
    Рисунок.Текст=Текст;
    УстановитьПараметрыТекста(Рисунок);
    Возврат Рисунок ;
КонецФункции

// П1 - В-Верх ,Л-Лево ,П-Право ,Н-Низ,  Х=Внутри  // расположение относительно рисунка
// П2 - В-Верх ,Л-Лево ,П-Право ,Н-Низ,  Ц-Центр  //  положение в П1 
// П3 - Г-Горизонтально ,В-Вертикально // 
Функция ТекстРисунка(ТабДок,Текст,Рисунок,Расположение,СтильТекста=Неопределено) Экспорт
    РВерх=Рисунок.Верх;РЛево=Рисунок.Лево;РШирина=Рисунок.Ширина;РВысота=Рисунок.Высота;
    Т=Текст(ТабДок,Текст,РВерх,РЛево,СтильТекста);
    ТШирина=?(Т.Ширина=0,РасчитатьДлинуТекста(Т),Т.Ширина);
    ТВысота=?(Т.Высота=0,РасчитатьВысотуТекста(Т),Т.Высота);
    П1=Сред(Расположение,1,1); П2=Сред(Расположение,2,1);  П3=Сред(Расположение,3);
    Если П3="В" Тогда
        Т.ОриентацияТекста=90;
        Если П1="Л" Тогда
            Т.Лево=РЛево-1;
            Если П2="В" Тогда
                Т.Верх=РВерх;
            ИначеЕсли П2="Н" Тогда
                Т.Верх=РВерх+РВысота ;
            Иначе
                Т.Верх=РВерх+РВысота/2-ТШирина/2;
            КонецЕсли;
        ИначеЕсли П1="П" Тогда // справа
            Т.Лево=РЛево+РШирина+1;
            Если П2="В" Тогда
                Т.Верх=РВерх;
            ИначеЕсли П2="Н" Тогда
                Т.Верх=РВерх+РВысота-ТВысота ;
            Иначе
                Т.Верх=РВерх+РВысота/2-ТВысота/2;
            КонецЕсли;
        ИначеЕсли П1="В" Тогда
            Т.Верх=РВерх-(ТВысота+1);
            Если П2="П" Тогда
                Т.Лево=РЛево+РШирина-ТШирина;
            ИначеЕсли П2="Л" Тогда
                Т.Лево=РЛево ;
            Иначе
                Т.Лево=РЛево+РШирина/2-ТШирина/2;
            КонецЕсли;
        ИначеЕсли П1="Н" Тогда
            Т.Верх=РВерх+РВысота+1;
            Если П2="П" Тогда
                Т.Лево=РЛево+РШирина-ТШирина;
            ИначеЕсли П2="Л" Тогда
                Т.Лево=РЛево ;
            Иначе
                Т.Лево=РЛево+РШирина/2-ТШирина/2;
            КонецЕсли;
        Иначе // 
            Т.Верх=РВерх+РВысота/2-ТВысота/2;
            Т.Лево=РЛево+РШирина/2-ТШирина/2;
        КонецЕсли;
    ИначеЕсли П3="Г" Тогда // гориз текст
        Если П1="Л" Тогда
            Т.Лево=РЛево-(ТШирина+1);
            Если П2="В" Тогда
                Т.Верх=РВерх;
            ИначеЕсли П2="Н" Тогда
                Т.Верх=РВерх+РВысота-ТВысота ;
            Иначе
                Т.Верх=РВерх+РВысота/2-ТВысота/2;
            КонецЕсли;
        ИначеЕсли П1="П" Тогда // справа
            Т.Лево=РЛево+РШирина+1;
            Если П2="В" Тогда
                Т.Верх=РВерх;
            ИначеЕсли П2="Н" Тогда
                Т.Верх=РВерх+РВысота-ТВысота ;
            Иначе
                Т.Верх=РВерх+РВысота/2-ТВысота/2;
            КонецЕсли;
        ИначеЕсли П1="В" Тогда
            Т.Верх=РВерх-(ТВысота+1);
            Если П2="П" Тогда
                Т.Лево=РЛево+РШирина-ТШирина;
            ИначеЕсли П2="Л" Тогда
                Т.Лево=РЛево ;
            Иначе
                Т.Лево=РЛево+РШирина/2-ТШирина/2;
            КонецЕсли;
        ИначеЕсли П1="Н" Тогда
            Т.Верх=РВерх+РВысота+1;
            Если П2="П" Тогда
                Т.Лево=РЛево+РШирина-ТШирина;
            ИначеЕсли П2="Л" Тогда
                Т.Лево=РЛево ;
            Иначе
                Т.Лево=РЛево+РШирина/2-ТШирина/2;
            КонецЕсли;
        Иначе // 
            Т.Верх=РВерх+РВысота/2-ТВысота/2;
            Т.Лево=РЛево+РШирина/2-ТШирина/2;
        КонецЕсли;
    ИначеЕсли СтрНайти(П3,"У")>0 Тогда  // Угол
        Угол=Число(Сред(П3,2));
        Т.ОриентацияТекста=Угол;
    Иначе 
    КонецЕсли;
    Возврат Т;
КонецФункции

Функция РасчитатьДлинуТекста(Т)
    // быстрый  приблизительный расчет длины  подобран эмпирически для Arial,Calibri 10
    д=СтрДлина(Т.Текст);
    Если д < 4 Тогда д=8; 
    ИначеЕсли д > 15 Тогда д=(д*2)-Окр(д/3);
    Иначе	д=д*2;
    КонецЕсли;
    Возврат д;
КонецФункции

Функция РасчитатьВысотуТекста(Т)
    // быстрый  приблизительный расчет высоты  подобран эмпирически для Arial,Calibri 10
    Возврат Т.Шрифт.Размер/2;
КонецФункции

#КонецОбласти 

#Область Блоки

//Блок - группа состыкованных между собой прямоугольников
// Верх,Лево,Высота,Ширина -  общие размеры блока 
// мЭлементов - массив элементов - имен , если эл-т - массив то деление по горизонтали
Функция Блок(ТабДок,Тип,Параметры) Экспорт
    мБлок=Новый Массив; // :РисунокТД
    Возврат  мБлок; 
КонецФункции

// Фильтр- Массив  имен рисунков которые нужно удалить
Процедура УдалитьРисункиПоФильтру(ТабДок,Фильтр=Неопределено) Экспорт
    Если Фильтр = Неопределено Тогда
        ТабДок.Рисунки.Очистить();
    КонецЕсли;
    Для Индекс = -ТабДок.Рисунки.Количество() По -1 Цикл
        Рисунок=ТабДок.Рисунки.Получить(-Индекс);
        Если Фильтр.Найти(Рисунок.Имя) > 0 Тогда
            ТабДок.Рисунки.Удалить(Рисунок);
        КонецЕсли;
    КонецЦикла;
КонецПроцедуры

Процедура НазначитьИмяРисунка(ТабДок,Рисунок,Префикс="") Экспорт
    Если ТипЗнч(Рисунок) =Тип("Массив") Тогда
        Для Каждого Р Из Рисунок Цикл
            //НазначитьИмя(ТабДок,Рисунок,Префикс);
        КонецЦикла; 	
    КонецЕсли;
    СоответствиеИмен=Новый Соответствие;
    СоответствиеИмен.Вставить("Линия","LN_");
    СоответствиеИмен.Вставить("Эллипс","EL_");
    СоответствиеИмен.Вставить("Прямоугольник","RC_");
    МаксЭлемент1=0;      МаксЭлемент2=0;
    //Для Индекс = -ТабДок.Рисунки.Количество() По -1 Цикл
    //	Рисунок=ТабДок.Рисунки.Получить(-Индекс);
    //	Если Не ПустаяСтрока(Префикс) Тогда
    //		Если  СтрНачинаетсяС(Рисунок.Имя,Префикс) Тогда
    //		 МаксЭлемент1=Макс(МаксЭлемент1,Число(Сред(Рисунок.Имя,4,1)));
    //		КонецЕсли;	
    //		Если СтрНачинаетсяС(Рисунок.ИмяСоответствиеИмен[Рисунок.Тип]) Тогда
    //			
    //		КонецЕсли;	
    //	Иначе 
    //		
    //	КонецЕсли;
    //КонецЦикла;
КонецПроцедуры

#КонецОбласти 

#КонецОбласти

#Область ПрограммныйИнтерфейс_ГрафСхемаXDTO

Функция НоваяТочкаXDTO(x, y) Экспорт 	
    Точка = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.2/data/graphscheme", "Point"));
    Точка.x = x;
    Точка.y = y;	
    Возврат Точка;
КонецФункции

Функция НовыйОбъектXDTO(Тип, ИмяЭлемента, Верх, Лево, Высота, Ширина, Содержание, Фигура, Цвет = Неопределено, Шрифт = Неопределено, itemId=0, LastID=0 )Экспорт
    мШрифт = Новый Шрифт("Arial Narrow", 9);
    мЦвет = Новый Массив; 
    мЦвет.Вставить(0, 246); мЦвет.Вставить(1, 255); мЦвет.Вставить(2, 205); //246, 255, 205
    Шрифт = ?(Шрифт=Неопределено ,мШрифт, Шрифт);
    Цвет = ?(Цвет=Неопределено , мЦвет, Цвет);
    
    НО = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.2/data/graphscheme", "GraphSchemeItem"));
    НО.itemType = Тип;
    НО.itemCode = ИмяЭлемента;
    НО.itemId = itemId;
    НО.zOrder = itemId;
    LastID = itemId;
    НО.itemTabOrder = 1;
    НО.rectLeft = Лево;
    НО.rectRight = Лево+Ширина;
    НО.rectTop = Верх;
    НО.rectBottom = Верх+Высота;
    НО.Border = СериализаторXDTO.ЗаписатьXDTO(Новый Линия(ТипСоединительнойЛинии.Сплошная, 1));
    НО.Point.Добавить(НоваяТочкаXDTO(НО.rectLeft, НО.rectTop));
    НО.Point.Добавить(НоваяТочкаXDTO(НО.rectRight-1, НО.rectTop));
    НО.Point.Добавить(НоваяТочкаXDTO(НО.rectRight-1, НО.rectBottom-1));
    НО.Point.Добавить(НоваяТочкаXDTO(НО.rectLeft, НО.rectBottom-1));
    Заголовки = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringType"));
    ЗаголовокЭлемента = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringItemType"));
    ЗаголовокЭлемента.lang = "#";
    ЗаголовокЭлемента.content = Содержание;
    Заголовки.Item.Добавить(ЗаголовокЭлемента);
    НО.itemTitle = Заголовки;
    Примечания = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringType"));
    Примечание = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringItemType"));
    Примечание.lang = "#";
    Примечание.content = Содержание;
    Примечания.Item.Добавить(Примечание);
    НО.tipText = Примечания;
    НО.currentLanguage = "#";
    НО.shape = Фигура;
    НО.backColor = Новый Цвет(Цвет[0], Цвет[1], Цвет[2]);
    НО.textFont = СериализаторXDTO.ЗаписатьXDTO(Шрифт);
    Возврат НО;
КонецФункции

Функция НоваяЛинияXDTO(ГрафСхемаXDTO, ПервыйЭлементID, ВторойЭлементID, Содержание, Подсказка, ПортВыхода = Неопределено, ПортВхода = Неопределено, itemId = 0,  offsetY = 0, offsetX = 0 ,Цвет = Неопределено, Шрифт = Неопределено) Экспорт
    Шрифт = ?(Шрифт=Неопределено , Новый Шрифт("Arial Narrow", 9), Шрифт);
    Цвет = ?(Цвет=Неопределено , Новый Цвет , Цвет);
    НО = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.2/data/graphscheme", "GraphSchemeItem"));
    НО.itemType = 1;
    НО.itemId = itemId;
    LastID = itemId;
    НО.itemTabOrder = 2;
    НО.itemCode = Подсказка;
    Заголовки = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringType"));
    ЗаголовокЭлемента = СериализаторXDTO.Фабрика.Создать(СериализаторXDTO.Фабрика.Тип("http://v8.1c.ru/8.1/data/core", "LocalStringItemType"));
    ЗаголовокЭлемента.lang = "#";
    ЗаголовокЭлемента.content = Содержание;
    Заголовки.Item.Добавить(ЗаголовокЭлемента);
    НО.itemTitle = Заголовки;
    НО.currentLanguage = "#";
    НО.textPos = "Middle";
    НО.beginArrowStyle = СтильСтрелки.Нет;
    НО.endArrowStyle = СтильСтрелки.Незаполненная;
    НО.lineColor = Цвет;
    
    ДанныеПервый = ПортыЭлементаXDTO(ГрафСхемаXDTO, ПервыйЭлементID);
    ДанныеВторой = ПортыЭлементаXDTO(ГрафСхемаXDTO, ВторойЭлементID);
    
    НО.connectFromItemId = ДанныеПервый.itemId;
    НО.connectToItemId = ДанныеВторой.itemId;
    НО.connectFromPortIndex = 0;
    
    Если ПортВыхода = Неопределено Или ПортВхода = Неопределено Тогда
        Если ДанныеПервый.itemId<ДанныеВторой.itemId Тогда
            ПортВыхода = 2;ПортВхода = 2;
        ИначеЕсли ДанныеПервый.itemId>ДанныеВторой.itemId Тогда 
            ПортВыхода = 4; ПортВхода = 4;
        Иначе 
            ПортВыхода = 2; ПортВхода = 4;
        КонецЕсли;
    КонецЕсли;	
    НО.portIndexFrom = ПортВыхода;
    НО.portIndexTo = ПортВхода;
    НО.backColor = новый Цвет;
    НО.decorativeLine = Истина;
    НО.textFont = СериализаторXDTO.ЗаписатьXDTO(Шрифт);
    НО.textColor = Цвет;
    НО.Border = СериализаторXDTO.ЗаписатьXDTO(новый Линия(ТипСоединительнойЛинии.Сплошная, 1));
    // Координаты исходящего порта
    Точка_x1  =  ДанныеПервый["port"+ПортВыхода+"x"]; Точка_y1 = ДанныеПервый["port"+ПортВыхода+"y"];
    Точка_x4  =  ДанныеВторой["port"+ПортВхода+"x"]; Точка_y4 = ДанныеВторой["port"+ПортВхода+"y"];
    Точка_x2  =  Точка_x1; Точка_y2  =  Точка_y1 + offsetY ;
    Точка_x3  =  Точка_x4; Точка_y3  =  Точка_y1 + offsetY ;
    НО.Point.Добавить(НоваяТочкаXDTO(Точка_x1, Точка_y1));
    НО.Point.Добавить(НоваяТочкаXDTO(Точка_x2, Точка_y2));
    НО.Point.Добавить(НоваяТочкаXDTO(Точка_x3, Точка_y3));	
    НО.Point.Добавить(НоваяТочкаXDTO(Точка_x4, Точка_y4));	
    Возврат НО;
КонецФункции

Функция ПортыЭлементаXDTO(ГрафСхемаXDTO, itemID)Экспорт
    Данные = Новый Структура;
    Данные.Вставить("itemId", itemID);
    Данные.Вставить("port1x", 0);
    Данные.Вставить("port1y", 0);
    Данные.Вставить("port2x", 0);
    Данные.Вставить("port2y", 0);
    Данные.Вставить("port3x", 0);
    Данные.Вставить("port3y", 0);
    Данные.Вставить("port4x", 0);
    Данные.Вставить("port4y", 0);
    Для Каждого Элемент Из ГрафСхемаXDTO.item Цикл
        Если Элемент.itemId = itemID Тогда
            Данные.Вставить("itemId", itemID);
            Данные.Вставить("port1x", Элемент.rectLeft);
            Данные.Вставить("port1y", Элемент.rectTop+(Элемент.rectBottom-Элемент.rectTop)/2);
            Данные.Вставить("port2x", Элемент.rectLeft+(Элемент.rectRight-Элемент.rectLeft)/2);
            Данные.Вставить("port2y", Элемент.rectTop);
            Данные.Вставить("port3x", Элемент.rectRight);
            Данные.Вставить("port3y", Элемент.rectTop+(Элемент.rectBottom-Элемент.rectTop)/2);
            Данные.Вставить("port4x", Элемент.rectLeft+(Элемент.rectRight-Элемент.rectLeft)/2);
            Данные.Вставить("port4y", Элемент.rectBottom);
            Прервать;
        КонецЕсли;	 
    КонецЦикла;
    Возврат Данные;
КонецФункции

Функция ИндексЭлементаXDTO(ГрафСхемаXDTO, itemCode)Экспорт
    Для Й = 0 По ГрафСхемаXDTO.item.Количество()-1 Цикл
        Если СокрЛП(НРег(ГрафСхемаXDTO.item[Й].itemCode)) = СокрЛП(НРег(itemCode)) Тогда
            Возврат Й;
        КонецЕсли;	 
    КонецЦикла;
    Возврат -1;
КонецФункции

Функция НайтиЭлементXDTO(ГрафСхемаXDTO, itemCode = "", itemId = 0)Экспорт
    Для Каждого Элемент Из ГрафСхемаXDTO.item Цикл
        Если НЕ ПустаяСтрока(itemCode) И СокрЛП(НРег(Элемент.itemCode)) = СокрЛП(НРег(itemCode)) Тогда
            Возврат Элемент;
        ИначеЕсли itemId > 0 И Элемент.itemId = itemId Тогда
            Возврат Элемент;
        КонецЕсли;	 
    КонецЦикла;
    Возврат Неопределено;
КонецФункции

Процедура УдалитьЭлементXDTO(ГрафСхемаXDTO, itemCode)Экспорт
    ГрафСхемаXDTO.item.Удалить(ИндексЭлементаXDTO(ГрафСхемаXDTO, itemCode));
КонецПроцедуры

Функция ПолучитьТекстЭлементаXDTO(ГрафСхемаXDTO, itemCode)Экспорт
    Элемент = НайтиЭлементXDTO(ГрафСхемаXDTO, itemCode);
    Возврат Элемент.itemTitle.item[0].content;
КонецФункции

Процедура ИзменитьТекстЭлементаXDTO(ГрафСхемаXDTO, itemCode="",itemId=0, НовыйТекст) Экспорт
    Элемент = НайтиЭлементXDTO(ГрафСхемаXDTO, itemCode,itemId);
    Элемент.itemTitle.item[0].content = НовыйТекст;
КонецПроцедуры
#КонецОбласти

#Область ПрограммныйИнтерфейс_ОбщегоИспользования

Функция СтрокаПробелов(Число) Экспорт
    Возврат СтрЗаменить(Лев(СтрЗаменить(Формат(1, "ЧВН=; ЧГ=0; ЧЦ=" + Число), "1", "0"), Число), "0",Символ(32));
КонецФункции

Функция ШтампВремени() Экспорт
    Возврат СтрЗаменить(СтрЗаменить(СтрЗаменить(Строка(ТекущаяДата()),".",""),":",""),Символ(32),"");
КонецФункции 

Функция НормализоватьТекст(Текст,МеткаEndOfText = Истина,СтрокаСлов ="")  Экспорт
    КодАлгоритма = СтрЗаменить(Текст,Символы.Таб," ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,Символы.ПС," ^ ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"="," = ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"+"," + ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"<"," < ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,">"," > ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,";"," ; ");

    Для А = 0 по Окр(Sqrt(СтрЧислоВхождений(КодАлгоритма,"  ")),0) Цикл
        КодАлгоритма = СтрЗаменить(КодАлгоритма,"  "," ");
    КонецЦикла;
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"< =","<=");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"> =",">=");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"< >","<>");
    МассивСлов =  СтрРазделить(КодАлгоритма," ");
    СтрокаСловПоумолчанию ="Возврат,И,Или,Не,Если,Тогда,КонецЕсли,Для,Каждого,Из,Пока,Цикл,КонецЦикла";
    МассивСлужебныхСлов = СтрРазделить(?(ПустаяСтрока(СтрокаСлов),СтрокаСловПоумолчанию,СтрокаСлов), ",") ;
    Для  Слово = 0  По МассивСлов.ВГраница() Цикл
        Для  Каждого СлужебноеСлово Из МассивСлужебныхСлов Цикл
            Если НРег(СокрЛП(МассивСлов[Слово])) = НРег(СлужебноеСлово) Тогда 
               МассивСлов[Слово]  = СлужебноеСлово;   
            КонецЕсли;
        КонецЦикла;
    КонецЦикла;
    КодАлгоритма = СтрСоединить(МассивСлов," ");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"^", Символы.ПС);
    Если МеткаEndOfText  И Найти(КодАлгоритма,"~EndOfText:") = 0 Тогда
        КодАлгоритма = КодАлгоритма+Символы.ПС+"~EndOfText:";	
    КонецЕсли;
    Возврат КодАлгоритма;
КонецФункции

Функция МассивИсключаемыхСимволов() Экспорт
    мИсключая = СтрРазделить(";,+, = ,-,),(,.,[,],{,},|,/,\,>,<,$,@,#",",");
    мИсключая.Добавить(Символы.ПС);
    мИсключая.Добавить(Символы.Таб);
    мИсключая.Добавить(Символ(32));
    мИсключая.Добавить(",");
    мИсключая.Добавить("""");
    Возврат мИсключая;
КонецФункции

Процедура пЗаменаВставка(КодАлг,Префикс,До="",После="",Исключая="",Включая ="") Экспорт
    Пока Найти(КодАлг,Префикс)>0 Цикл
        Слово = ПолучитьПервоеВхождениеСловоБезПрефикса(КодАлг,Префикс,Исключая,Включая);
        КодАлг = СтрЗаменить(КодАлг,Префикс+Слово,До+Слово+После);
    КонецЦикла;
КонецПроцедуры

Функция фЗаменаВставка(Знач КодАлг,Префикс,До="",После="",Исключая="",Включая ="") Экспорт
    Пока Найти(КодАлг,Префикс)>0 Цикл
        Слово = ПолучитьПервоеВхождениеСловоБезПрефикса(КодАлг,Префикс,Исключая,Включая);
        КодАлг = СтрЗаменить(КодАлг,Префикс+Слово,До+Слово+После);
    КонецЦикла;
    Возврат КодАлг;
КонецФункции

Функция ПолучитьПервоеВхождениеСловоБезПрефикса(Строка,Преф,Исключая = ";,+, = ,-,),(,.,[,],{,},|,/,\,>,<",Включая ="") Экспорт
    ДлинаПреф = СтрДлина(Преф);
    ПозПрефикс = СтрНайти(Строка,Преф)+ДлинаПреф;
    
    Если ТипЗнч(Включая) =Тип("Массив") Тогда
        мВключая = Включая;
    Иначе
        мВключая = СтрРазделить(Включая,",");
    КонецЕсли;
    
    Если ТипЗнч(Исключая) =Тип("Массив") Тогда
        мИсключая = Исключая;
    Иначе
        мИсключая = СтрРазделить(Исключая,",");
    КонецЕсли;

    мТерм = Новый Массив;
    Для Каждого СимволИсключая Из мИсключая Цикл
        Если мВключая.Найти(СимволИсключая) = Неопределено Тогда 
            мТерм.Добавить(СтрНайти(Сред(Строка, ПозПрефикс),СимволИсключая));
        КонецЕсли;
    КонецЦикла;
    
    Терм = 1000000 ;
    Для каждого Элемент Из мТерм Цикл
        Если Элемент > 0 И Элемент < Терм Тогда 
            Терм = Элемент;
        КонецЕсли;
    КонецЦикла;
    
    Слово = ?(Терм < 1000000, Сред(Строка, Найти(Строка,Преф) + ДлинаПреф, Терм - 1),Сред(Строка, Найти(Строка,Преф) + ДлинаПреф));
    Возврат Слово;
КонецФункции

Функция СтрокаВМассив(Строка,Разделитель) Экспорт
    Возврат СтрРазделить(Строка,Разделитель);
КонецФункции 

Функция ПолучитьСиноним(Знач Строка) Экспорт 
    СтрокаСокрЛП = СокрЛП(Строка);
    Синоним = ""; 
    Заглавные = "АБВГДЕЁЖЗИКЛМНОПРСТФХЦЧЩЭЮЯABCDIFGHIJKLMNOPQRSTUVWXYZ";
    До = Истина;
    Для Ё = 1 По СтрДлина(СтрокаСокрЛП) Цикл 
        Символ = Сред(СтрокаСокрЛП,Ё,1); 
        После = Ё < СтрДлина(СтрокаСокрЛП) И СтрНайти(Заглавные, Сред(СтрокаСокрЛП,Ё + 1, 1))> 0; 
        Если СтрНайти(Заглавные,Символ) > 0 Тогда 
            Синоним = Синоним + ?(До, "", Символ(32)) + ?(До ИЛИ После, Символ, НРег(Символ));
            До = Истина ;
        Иначе 
            Синоним = Синоним + Символ;
            До = Ложь;
        КонецЕсли; 
    КонецЦикла;
    Возврат Синоним; 
КонецФункции // ПолучитьСиноним()

Функция СклеитьСтроку(Знач Строка) Экспорт
    
    // получить верное имя переменной из строки
    Строка = СтрЗаменить(СтрЗаменить(СтрЗаменить(СокрЛП(Строка),Символы.Таб,""),Символы.ПС,""),Символ(32),""); 
    СтрИсключая = "0123456789,+=-)(.:[]{}|/\><$@#`""~*^%№?"; 
    Курсор = СтрДлина(Строка);
    СтрокаВ = "";
    
    Пока Курсор > 0 Цикл
        
        Если СтрНайти(СтрИсключая,Сред(Строка,Курсор,1)) = 0 Тогда
            
            СтрокаВ = Сред(Строка,Курсор,1) + СтрокаВ;
        КонецЕсли; 
        
        Курсор = Курсор -1; 
    КонецЦикла;
    
    Возврат СтрокаВ; 
КонецФункции // ПолучитьСиноним()

Функция ЭтоLinux()   Экспорт
	СистемнаяИнформация = Новый СистемнаяИнформация;
	Возврат  СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Linux_x86_64 ИЛИ СистемнаяИнформация.ТипПлатформы =ТипПлатформы.Linux_x86;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс_Алгоритмы

Функция ПреобразоватьТекстВКодАлгоритма(Текст) Экспорт 
    КодАлгоритма = НормализоватьТекст(Текст);
    мИсключая = МассивИсключаемыхСимволов();
    пЗаменаВставка(КодАлгоритма,"@ВычислитьФункцию","_37583_АлгоритмыСервер.ВыполнитьФункцию","[""""Результат""""]",мИсключая);
    пЗаменаВставка(КодАлгоритма,"@РезультатФункции","_37583_АлгоритмыСервер.ВыполнитьФункцию","[""Результат""]",мИсключая);
    пЗаменаВставка(КодАлгоритма,"@РезультатФункцииКлиент","_37583_АлгоритмыКлиент.ВыполнитьФункцию","[""Результат""]",мИсключая);
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@ПроцедураКлиент","_37583_АлгоритмыКлиент.ВыполнитьПроцедуру");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@ПроцедураКлиентАсинхронно","_37583_АлгоритмыКлиент.ВыполнитьПроцедуру"); 
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@ФункцияКлиент","_37583_АлгоритмыКлиент.ВыполнитьФункцию");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@Процедура","_37583_АлгоритмыСервер.ВыполнитьПроцедуру"); 
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@Функция","_37583_АлгоритмыСервер.ВыполнитьФункцию");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@ПеременныеСреды","_37583_АлгоритмыКэш.ПолучитьПараметры_37583()");
    пЗаменаВставка(КодАлгоритма,"#","[""","""]",мИсключая);
    пЗаменаВставка(КодАлгоритма,"$$","this[","]",мИсключая);
    пЗаменаВставка(КодАлгоритма,"$'","this[""""","""""]",мИсключая);
    пЗаменаВставка(КодАлгоритма,"$","this[""","""]",мИсключая);
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"@","Параметры.");
    КодАлгоритма = СтрЗаменить(КодАлгоритма,"Возврат ;","Перейти ~EndOfText;");
    //КодАлгоритма = СтрЗаменить(КодАлгоритма,"Возврат ","this[""Результат""] = ");
     пЗаменаВставка(КодАлгоритма,"Возврат ","this[""Результат""] = ","; Перейти ~EndOfText",";"," ");

    Возврат КодАлгоритма;
КонецФункции

Функция СвойстваДоступныеНаКлиентеИНаСервере () Экспорт
	СвойстваДоступныеНаКлиентеИНаСервере =  Новый Структура();
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("Ссылка",Неопределено);
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("Наименование","-");
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("КодАлгоритма","");
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("КодЗавершения","");
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("ТолькоТекст",Ложь);
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("ВыбрасыватьИсключение",Истина);
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("ЗаписыватьОшибкиВЖР",Истина);
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("ЗаписыватьСобытиияВЖР",Ложь);
	СвойстваДоступныеНаКлиентеИНаСервере.Вставить("Отказ",Ложь);
	
	Возврат СвойстваДоступныеНаКлиентеИНаСервере;
КонецФункции

#КонецОбласти

