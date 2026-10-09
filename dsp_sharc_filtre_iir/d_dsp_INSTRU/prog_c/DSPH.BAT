rem pour une compilation avec full debug info 
rem fabrication d'un ‚x‚cutable DSP *.21K
rem sauvegarde des fichiers interm‚diaires
rem utilisation du DSPHOST

rem modif pour passage xp
copy %1.c c:\ez-kit\bin /v
c:
cd\
cd ez-kit
cd bin
rem fin de modif passage xp

rem compilation et linkage librairies du DSPHOST
g21k -I c:\ez-kit\ezsharc\include -o %1.21k %1.c c:\ez-kit\ezsharc\libdh.a -g -save-temps 
pause

rem modif pour passage xp
copy %1.21K c:\ez-kit\ezsharc\ /v
rem fin de modif passage xp

rem telechargement sur l'EZKIT 
c:\ez-kit\ezsharc\dh21k -b0 %1.21k 

rem modif pour passage xp
copy %1.* e: /v
del %1.*
del c:\ez-kit\ezsharc\%1.21k
e:
rem fin de modif passage xp

          
