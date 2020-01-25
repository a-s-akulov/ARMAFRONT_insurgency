/*
Скрипт ремонта БПА/БПЛА, наземной техники, кораблей 
Данный скрипт создан для сервера ArmaFront

Автор: Пчёлка=Ъ
Версия: 1.0.2
Особая благодарность: ZeroAinz, sldt1ck


Модифицировал: 
Если вы будете вносить глобальные изменения, по желанию сможете указать своё участие тут,
хотя где тут можно сделать что то глобальное? =)
//////////////////////////////////////////////////////////////////////////////////////

Установка:
--------------------------------------------
Подключить скрипт без массива в initFunctions.hpp 

для простоты интеграции можете сделать следующий путь к скрипту и сам вызов
[] execVM "scripts\BeeRepairVehicle.sqf";
--------------------------------------------
В stringtable.xml
<Package name="Bee_RepairScript">
	<Key ID="Bee_Repair_Table">
		<Original>Repair</Original>
		<Russian>Тех. Обслуживание</Russian>
		<Italian>Ripara</Italian>
	</Key>

	<Key ID="Bee_Repair_Start">
		<Original>Start Repair</Original>
		<Russian>Тех. Обслуживание...</Russian>
		<Italian>Riparazione avviata...</Italian>
	</Key>

	<Key ID="Bee_Repair_END">
		<Original>End Repair</Original>
		<Russian>Транспорт Готов</Russian>
		<Italian>Riparazione finita</Italian>
	</Key>
</Package>
для простоты использования советую не удалять Package
--------------------------------------------
В description.ext
	class BeeBlip
	{
		name = "BeeBlip";
		sound[] = {"@a3\sounds_f\sfx\blip1", 1.0, 1.0};
		titles[] = {0,""};
	};
ВНИМАНИЕ!!!!! Хоть этот скрипт и являетсо основоположником, однако
Если у вас уже есть мой скрипт с берушами то данный звук добавлять ненужно, т.к. он универсален для этих скриптов	
--------------------------------------------
Поместить картинку в папку с сервером, для простоты интеграции можете сделать следующий путь
корень сервера\pictures\hint_pic\ 

либо указать свой путь к картинке

--------------------------------------------
В редакторе

На карте создать/взять 2 объекта

Объект для взаимодействия, его назвать BeeRepair
В сам объект добавить

BeeUseRepair = true;
this addAction
[
	format ["<t color='#ff8fb6'>%1</t>",localize "Bee_Repair_Table"],
	{[] call BeeStartRepair;},
	[],
	6,
	true,
	false,
	"",
	"(BeeUseRepair isEqualTo true)",
	5,
	false,
	"",
	""
];

Объект возле которого будет размещаться техника для ремонта назвать BeeRepairZone
<<<<<<<<<<<<<<<<<< Изменения >>>>>>>>>>>>>>>>>>

*1.0.1
-Добавлен звук вначале ремонта
-Добавлен звук по окончанию ремонта
-Изменен hint: добавлена картинка, добавлено форматирование хинта

*1.0.2
-Добавлена возможность локализации через stringtable.xml

<<<<<<<<<<<<<<<<<<<<<<<->>>>>>>>>>>>>>>>>>>>>>>
*/
//////////////////////////////////////////////////////////////////////
//								НАЧАЛО								//
//////////////////////////////////////////////////////////////////////

// Переменные которые используются
// BeeRepair			- Объект с которым нужно взаимодействовать при ремонте
// BeeRepairZone		- Объект который выполняет роль зоны ремонта
// BeeUseRepair			- Переменная блокировки взаимодействия с СТО на время Тех. Обслуживания
// BeeCanUseRepair		- Переключение блокировки на сервере
// BeeStartRepair		- Вызов функции ремонта техники

BeeCanUseRepair = {BeeUseRepair = _this select 0};

BeeStartRepair = 
{
	private _bee = nearestObjects [BeeRepairZone, ["Car","Tank","Helicopter","Ship"], 30] param [0, objNull]; // поиск ближайшей техники возле объекта для ремонта
	// ремонт священых БПА/БПЛА
	if (_bee in allUnitsUAV) then 
	{
		[[false,false],"BeeCanUseRepair",true,false] call BIS_fnc_MP; // блокировка взаимодействия с СТО
		hint parseText format ["<br/><img size='4' color='#595923' image='pictures\hint_pic\vehiclerepair_ca.paa' align='center'/><br/>
		<br/><t size='1.2' color='#99ffffff' align='center'>%1</t><br/><br/>",localize "Bee_Repair_Start"];// хинт с картинкой и текстом из стрингтейбл
		playSound "BeeBlip";	// воспроизводит звук
		_bee setFuel 0;			// опустошение бака(что бы не уехали)
		sleep 20;				// время ремонта в секундах
		_bee setDamage 0;		// ремонт машины
		_bee setFuel 1;			// заправка машины, НИВКОЕМ случае не ставить перед setDamage
		_bee setVehicleAmmo 1;	// перезарядка орудий транспорта
		hint parseText format ["<br/><img size='4' color='#595923' image='pictures\hint_pic\vehiclerepair_ca.paa' align='center'/><br/>
		<br/><t size='1.2' color='#99ffffff' align='center'>%1</t><br/><br/>",localize "Bee_Repair_END"];// хинт с картинкой и текстом из стрингтейбл
		playSound "BeeBlip";	// воспроизводит звук
		[[true,true],"BeeCanUseRepair",true,false] call BIS_fnc_MP; // снятие блокировки взаимодействия с СТО
	} else 
	{
		// ремонт транспорта, кроме БПА/БПЛА
		private _fullBee = fullCrew _bee; //Проверяет есть ли юниты/игроки
		if(count _fullBee < 1) then // Проверяет полученный массив, если юнитов/игроков нету то начинает ремонт
		{
			[[false,false],"BeeCanUseRepair",true,false] call BIS_fnc_MP; // блокировка взаимодействия с СТО
			hint parseText format ["<br/><img size='4' color='#595923' image='pictures\hint_pic\vehiclerepair_ca.paa' align='center'/><br/>
			<br/><t size='1.2' color='#99ffffff' align='center'>%1</t><br/><br/>",localize "Bee_Repair_Start"];// хинт с картинкой и текстом из стрингтейбл
			playSound "BeeBlip";	// воспроизводит звук
			_bee setFuel 0;			// опустошение бака(что бы не уехали)
			sleep 60;				// время ремонта в секундах
			_bee setDamage 0;		// ремонт машины
			_bee setFuel 1;			// заправка машины, НИВКОЕМ случае не ставить перед setDamage
			_bee setVehicleAmmo 1;	// перезарядка орудий транспорта
			hint parseText format ["<br/><img size='4' color='#595923' image='pictures\hint_pic\vehiclerepair_ca.paa' align='center'/><br/>
			<br/><t size='1.2' color='#99ffffff' align='center'>%1</t><br/><br/>",localize "Bee_Repair_END"];// хинт с картинкой и текстом из стрингтейбл
			playSound "BeeBlip";	// воспроизводит звук
			[[true,true],"BeeCanUseRepair",true,false] call BIS_fnc_MP; // снятие блокировки взаимодействия с СТО
		};
	};
};