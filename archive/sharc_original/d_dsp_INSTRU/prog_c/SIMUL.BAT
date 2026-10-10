rem pour une compilation avec full debug info 
rem fabrication d'un ‚x‚cutable DSP *.exe pour le simulateur
rem sauvegarde des fichiers interm‚diaires

rem modif pour passage xp
copy %1.c c:\ez-kit\bin /v
c:
cd\
cd ez-kit
cd bin
rem fin de modif passage xp

g21k %1.c -o %1.exe -g  -save-temps 

rem modif pour passage xp
pause
copy %1.* e: /v
del %1.*
e:
rem fin de modif passage xp