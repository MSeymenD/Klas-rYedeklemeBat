@echo off
setlocal enabledelayedexpansion
rem Hedef Klasor yaz buraya
set kaynakKlasor=C:\Data

rem yedek alınacak klasoru oluştur ve yolunu yaz 
set hedefKlasor=C:\yedek

rem Eğer belirli bir süreden (örneğin, 7 gün) eski olan klasörleri silmek istiyorsanız
set silinecekGunSayisi=7

rem Tarih ve saat bilgisini al
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set datetime=%%a
set tarih=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!
set saat=!datetime:~8,2!!datetime:~10,2!!datetime:~12,2!

rem Hedef klasörüne tarih ve saat bilgisiyle yedekle
xcopy "%kaynakKlasor%" "%hedefKlasor%\%tarih%_%saat%" /E /I /Y

rem Hedef klasöründe silinecek gün sayısından eski olanları sil
forfiles /p "%hedefKlasor%" /d -%silinecekGunSayisi% /c "cmd /c if @isdir==TRUE rd /S /Q @path"

endlocal