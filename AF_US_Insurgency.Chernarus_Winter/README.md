# NRE Earplugs
*Arma 3 - Earplugs script*

####Description:
Adds action to insert/remove Earplugs (toggles).
Inspired by A3Wasteland132DSOv14.Altis kopfh script

####License:
```
Copyright (C) 2015 Steven "NemesisRE" Köberich

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```

####Manual:
* Create a "scripts" folder in your mission and put the main script in there (or update init.sqf and NreEarplugsPath variable in the main script)
* Add following to your stringtable.xml:
```XML
<?xml version="1.0" encoding="UTF-8"?>
<Project name="NRE Earplugs">
	<Package name="NREEarplugs">
		<Key ID="STR_NREEP_IN_HINT">
			<Original>You have insert the earplugs!</Original>
			<English>You have insert the earplugs!</English>
			<Russian>Беруши вставлены!</Russian>
			<German>Du hast die Ohrstoepsel eingesteckt!</German>
			<Spanish>¡Te has puesto los tapones!</Spanish>
		</Key>
		<Key ID="STR_NREEP_OUT_HINT">
			<Original>You have removed the earplugs!</Original>
			<English>You have removed the earplugs!</English>
			<Russian>Беруши вытащены!</Russian>
			<German>Du hast die Ohrstoepsel rausgenommen!</German>
			<Spanish>¡Te has quitado los tapones!</Spanish>
		</Key>
		<Key ID="STR_NREEP_IN_ACTION">
			<Original>Insert earplugs</Original>
			<English>Insert earplugs</English>
			<Russian>Вставить беруши</Russian>
			<German>Ohrstoepsel einstecken</German>
			<Spanish>Ponerte los tapones</Spanish>
		</Key>
		<Key ID="STR_NREEP_OUT_ACTION">
			<Original>Remove earplugs</Original>
			<English>Remove earplugs</English>
			<Russian>Вытащить беруши!</Russian>
			<German>Ohrstoepsel rausnehmen</German>
			<Spanish>Quitarte los tapones</Spanish>
		</Key>
	</Package>
</Project>
```
* Call from init.sqf via:
```SQF
execVM "scripts\NRE_earplugs.sqf";


<?xml version="1.0" encoding="utf-8"?>
<Project name="CH View Distance">
    <Package name="Main">
        <Key ID="STR_chvd_title">
            <Original>View Distance Settings</Original>
            <Russian>Настройки Дальности Обзора</Russian>
            <German>Sichtweiten Einstellung</German>
            <French>Conf. de la distance de vue</French>
        </Key>
        <Key ID="STR_chvd_foot">
            <Original>ON FOOT</Original>
            <Russian>ПЕШКОМ</Russian>
            <German>ZU FUß</German>
			<French>A PIED</French>
        </Key>
        <Key ID="STR_chvd_car">
            <Original>IN CAR</Original>
            <Russian>В МАШИНЕ</Russian>
            <German>IM FAHRZEUG</German>
			<French>EN VOITURE</French>
        </Key>
        <Key ID="STR_chvd_air">
            <Original>IN AIR</Original>
            <Russian>В ВОЗДУХЕ</Russian>
            <German>IM FLUGZEUG</German>
			<French>DANS LES AIRS</French>
        </Key>
        <Key ID="STR_chvd_view">
            <Original>VIEW:</Original>
            <Russian>ОБЩЕЕ:</Russian>
            <German>SICHTWEITE:</German>
			<French>VUE :</French>
        </Key>
        <Key ID="STR_chvd_object">
            <Original>OBJECT:</Original>
            <Russian>ОБЪЕКТЫ:</Russian>
            <German>OBJEKT:</German>
			<French>OBJET :</French>
        </Key>
        <Key ID="STR_chvd_terrain">
            <Original>TERRAIN:</Original>
            <Russian>ЛАНДШАФТ:</Russian>
            <German>GELÄNDE:</German>
			<French>TERRAIN :</French>
        </Key>
        <Key ID="STR_chvd_sync">
            <Original>SYNC MODE:</Original>
            <Russian>СИНХРОН.:</Russian>
            <German>SYNC MODE:</German>
			<French>SYNC. :</French>
        </Key>
        <Key ID="STR_chvd_close">
            <Original>Close</Original>
            <Russian>Закрыть</Russian>
            <German>Schließen</German>
			<French>Fermer</French>
        </Key>        
        <Key ID="STR_chvd_disabled">
            <Original>Disabled</Original>
            <Russian>Отключена</Russian>
            <German>Disabled</German>
			<French>Désactivé</French>
        </Key>
		<Key ID="STR_chvd_dynamic">
            <Original>Dynamic</Original>
            <Russian>Динамическая</Russian>
            <German>Dynamic</German>
			<French>Dynamique</French>
        </Key>
		<Key ID="STR_chvd_fov">
            <Original>FOV</Original>
            <Russian>FOV</Russian>
            <German>FOV</German>
			<French>FOV</French>
        </Key>
        <Key ID="STR_chvd_low">
            <Original>Low</Original>
            <Russian>Низкое</Russian>
            <German>Niedrig</German>
			<French>Bas</French>
        </Key>
        <Key ID="STR_chvd_standard">
            <Original>Standard</Original>
            <Russian>Стандартное</Russian>
            <German>Standart</German>
			<French>Standart</French>
        </Key>
        <Key ID="STR_chvd_high">
            <Original>High</Original>
            <Russian>Высокое</Russian>
            <German>Hoch</German>
			<French>Elevé</French>
        </Key>
        <Key ID="STR_chvd_veryHigh">
            <Original>Very High</Original>
            <Russian>Очень высокое</Russian>
            <German>Sehr Hoch</German>
			<French>Très élevé</French>
        </Key>
        <Key ID="STR_chvd_ultra">
            <Original>Ultra</Original>
            <Russian>Ультра</Russian>
            <German>Ultra</German>
			<French>Ultra</French>
        </Key>		
        <Key ID="STR_chvd_openSettings">
            <Original>Open view distance settings</Original>
            <Russian>Открыть настройки дальности обзора</Russian>
            <German>Open view distance settings</German>
			<French>Ouvrir la configuration de la distance de vue</French>
        </Key>
        <Key ID="STR_chvd_decreaseVD">
            <Original>Decrease view distance</Original>
            <Russian>Уменьшить дальность обзора</Russian>
            <German>Decrease view distance</German>
			<French>Diminuer la distance de vue</French>
        </Key>
        <Key ID="STR_chvd_increaseVD">
            <Original>Increase view distance</Original>
            <Russian>Увеличить дальность обзора</Russian>
            <German>Increase view distance</German>
			<French>Augmenter la distance de vue</French>
        </Key>
        <Key ID="STR_chvd_viewDistance">
            <Original>View Distance</Original>
            <Russian>Дальность Обзора</Russian>
            <German>View Distance</German>
			<French>Distance de vue</French>
        </Key>
        <Key ID="STR_chvd_objViewDistance">
            <Original>Object View Distance</Original>
            <Russian>Дальность Обзора Объектов</Russian>
            <German>Object View Distance</German>
			<French>Distance de vue des objets</French>
        </Key>
        <Key ID="STR_chvd_terrainQuality">
            <Original>Terrain Quality</Original>
            <Russian>Качество Рельефа</Russian>
            <German>Terrain Quality</German>
			<French>Terrain Quality</French>
        </Key>		
        <Key ID="STR_chvd_terrainGrid">
            <Original>Terrain Grid</Original>
            <Russian>Сетка Рельефа</Russian>
            <German>Terrain Grid</German>
			<French>Terrain Grid</French>
        </Key>		
    </package>
</Project>
```
