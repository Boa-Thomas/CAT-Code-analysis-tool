@echo
:start
perl moss.perl -l c -d test/brasilia/exec.asm test/thomas/exec.asm test/vini/exec.asm test/alek/exec.asm test/henrique/exec.asm test/jorge/exec.asm
SET /p environment="Rodar novamente? (1) Fechar? (0)"
IF /i "%environment%" == "1" GOTO start
IF /i "%environment%" == "0" GOTO end
:end
pause