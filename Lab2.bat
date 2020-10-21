@echo off
Setlocal EnableDelayedExpansion
set /p param=Type letter ^>
rem delims запрещает деление на токены по пробелу (для файлов, в имени которых они могут попасться).
for /f "delims=" %%A in ('dir %param%*.* /b /a:-D-S-H') do (
  rem зануляет поток ошибок StdError и в этот же поток перенаправляет исходящий поток StdOut. (Это чтобы на экран не выводилась лишняя информация от предыдущей команды del)
  del "%%A" 2>nul 1>&2
  if exist "%%A" (
      set /p=Couldn't delete the file "%%A". To remove forcibly? <nul
      choice
      if !errorlevel!==1 (
        del /F "%%A"
        if exist "%%A" echo File "%%A" is lock. Delete not possible.
      )
  )
  if not exist "%%A" echo File "%%A" deleted.
)
pause