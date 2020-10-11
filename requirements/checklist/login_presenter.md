# Login Presenter

> ## Regras
01. ✅ Chamar Validation ao alterar o email
02. ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
03. ✅ Notificar o emailErrorStream com null, caso o Validation não retorne erro
04. ✅ Não notificar o emailErrorStream se o valor for igual ao último
05. ✅ Notificar o isFormValidStream após alterar o email
06. ✅ Chamar Validation ao alterar a senha
07. ✅ Notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
08. ✅ Notificar o passwordErrorStream com null, caso o Validation não retorne erro
09. ✅ Não notificar o passwordErrorStream se o valor for igual ao último
10. ✅ Notificar o isFormValidStream após alterar a senha
11. ✅ Para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
12. ✅ Não notificar o isFormValidStream se o valor for igual ao último
13. ✅ Chamar o Authentication com email e senha corretos
14. ✅ Notificar o isLoadingStream como true antes de chamar o Authentication
15. ✅ Notificar o isLoadingStream como false no fim do Authentication
16. ✅ Notificar o mainErrorStream caso o Authentication retorne um DomainError
17. ✅ Fechar todos os Streams no dispose
18. ⛔️ Gravar o Account no cache em caso de sucesso
19. ⛔️ Levar o usuário pra tela de Enquetes em caso de sucesso