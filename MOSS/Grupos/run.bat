@echo
IF EXIST //C:Perl64/ GOTO :start
ELSE
msiexec /i bin/ActivePerl-5.28.msi

:start
perl moss.perl -l c -d brasiliaalex/exec.asm thomashenrique/exec.asm
SET /p environment="Rodar novamente? (1) Fechar? (0)"
IF /i "%environment%" == "1" GOTO start
IF /i "%environment%" == "0" GOTO end
:end
pause