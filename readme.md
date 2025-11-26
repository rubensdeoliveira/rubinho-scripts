# 🌐 Rubinho Env

Este repositório contém **todas as configurações do meu ambiente de desenvolvimento**, incluindo:

- arquivos de configuração (dotfiles)
- presets de VS Code
- temas e fontes
- scripts automatizados
- ferramentas auxiliares
- utilidades para setup, backup e restauração do ambiente

O objetivo é facilitar a instalação e padronização do meu ambiente em qualquer máquina Linux.

---

# 📦 Scripts de Instalação

Abaixo estão os scripts principais usados para configurar rapidamente o ambiente base, shell, ferramentas, terminal e demais dependências.

⚠ **Execute os scripts na ordem correta (1 → 2 → 3).**

---

## ▶️ Step 1 — Bootstrap Inicial

Instala:

- Zsh  
- Git  
- Curl  
- Define o Zsh como shell padrão  
- Cria `.zshrc` mínimo  
- Prepara sua máquina para rodar o Step 2

### **Rodar:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/step-1.sh)
```

📌 *Após rodar, feche e abra o terminal.*

---

## ▶️ Step 2 — Shell Power Up

Configura:

- Prezto  
- Starship  
- `.zshrc` avançado  
- Aliases, funções e melhorias do terminal  

### **Rodar:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/step-2.sh)
```

---

## ▶️ Step 3 — Ambiente Dev Completo

Instala e configura:

- Docker + Docker Compose  
- Node + NVM + Yarn  
- JetBrainsMono Nerd Font  
- Cursor Editor  
- Teclado US-Intl + suporte ao cedilha  
- Criação do perfil “rubinho” no GNOME Terminal  
- Aplicação automática da fonte + tema Dracula  

### **Rodar:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/vs-code/step-3.sh)
```

---

# 📚 Outras Seções do Repositório

Este repositório ainda pode conter:

- `/dotfiles` — Configurações pessoais (zsh, git, nvim, etc.)
- `/vs-code` — Configurações, extensões e presets
- `/themes` — Temas (Dracula, icons, GTK, terminal)
- `/scripts` — Automação de setup, backup e utilidades
- `/bin` — Ferramentas auxiliares
- `/fonts` — Fontes usadas nos terminais/editores

---

# 🛠 Manutenção

Para modificar scripts, atualizar ferramentas ou versionar ajustes do ambiente, basta editar os arquivos correspondentes e subir as alterações.
