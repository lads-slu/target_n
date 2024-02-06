(in Swedish)
Upplägg just nu:
1.	I filen scripts\1_settings.r görs alla ändringar (sökvägar, parametrar etc). Övriga skript ska aldrig behöva öppnas utan körs från detta huvudskript. R-paket som behövs men inte finns installerade kommer att installeras och en mapp kommer skapas under ”working directory” dit utdata exporteras.
2.	Indata Alla indata ska vara i referenssystemet Sweref99TM (epsg: 3006). Om man vill kan man välja att lägga alla indata och utdata i samma mapp och radera allt i denna mapp efter varje körning.
   Rasterdata: Det ska finnas två tif-filer,en med indexet ndre75 och en med skörd. ndre75-rastret ska vara i intervallet [0,1] och vara multiplicerat med 255. ndre75=(b7-b5)/(b7+b5). Till det stretchade rastret med skörd ska det finnas en fil med parametrar för omskalning till skörd i kg per ha.
Vectordata: Shapefil med blockgräns.
3.	Utdata Rasterdata: raster med kvävegiva (vra.tif). Textfiler: tre textfiler (min.txt, median.txt och max.txt) dessa innehåller värden för parametrarna n.min, n.max och n.median, som ska visas för användaren.
Gör så här:
1.	Ändra till egna settings (sökvägar, parametrar et c) i filen scripts\1_settings.r
2.	Kör hela skriptet scripts\1_settings.r.
