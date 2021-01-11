# Anotações de Git

## Adicionar usuário e e-mail na config global

`git config --global user.name "Fulano de Tal"`

`git config --global user.email fulanodetal@exemplo.br`

## Salvar dados do usuário github definitivamente

`git config --global credential.helper cache`
>Esse comando permite que o usuário github fique salvo e, assim, não fique solicitando sempre o usuário e senha para fazer commits.

## Remover arquivo do controle de versão

`git rm --cached NOME_DO_ARQUIVO`
>Alterar **NOME_DO_ARQUIVO** por arquivo desejado.

## Criar branch

`git checkout -b NOME_DO_BRANCH`
>Alterar **NOME_DO_BRANCH** por nome do branch desejado.

## Alterar branch

`git checkout NOME_DO_BRANCH`
>Exemplo: git checkout master volta para o master

## Desfazer um commit errado em uma branch errada

> Muda para a branch errada (onde o commit foi feito) e mostra o log, assim você identifica o commit e pega o id do commit 

`git checkout branch-errada`

`git log`

> Muda para a branch certa ( onde o commit deveria estar) e copia o commit para a branch atual

`git checkout branch-certa`

`git cherry-pick <id-do-commit>`

> Muda para a branch errada e aplica o revert no commit indesejado, assim a branch segue sem essas alterações

`git checkout branch-errada`

`git revert <id-do-commit>`
