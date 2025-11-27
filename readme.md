# 🌐 Rubinho Env

This repository contains **all my development environment configurations**, including:

- configuration files (dotfiles)
- Cursor/VS Code presets
- themes and fonts
- automated scripts
- auxiliary tools
- utilities for environment setup, backup and restoration

The goal is to facilitate the installation and standardization of my environment on any Linux machine.

---

## 📦 Installation Scripts

All scripts are organized in numerical order to facilitate sequential installation. **Run the scripts in the correct order (01 → 02 → 03 → ... → 15).**

### 🚀 Quick Installation (From Scratch)

If you just formatted your system or are starting from scratch, you have two options:

#### Option 1: Automatic Script (Recommended)

```bash
# Run the master script (it pauses when necessary)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/00-install-all.sh)

# After closing/opening the terminal, continue with:
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/00-install-all-continue.sh)
```

#### Option 2: Individual Scripts

```bash
# Run the scripts in sequence
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/01-install-zsh.sh)
# ⚠️ Close and reopen the terminal after script 01

bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/02-install-prezto.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/03-install-starship.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/04-configure-git.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/05-install-docker.sh)
# ⚠️ Logout/login after script 05 to use Docker without sudo

bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/06-install-node-nvm.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/07-install-yarn.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/08-install-font-jetbrains.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/09-install-cursor.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/10-configure-keyboard.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/11-configure-terminal.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/12-configure-ssh.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/13-configure-inotify.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/14-install-cursor-extensions.sh)
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/15-configure-cursor.sh)
```

---

## 📋 Complete Script Listing

### **00-install-all.sh** (Master Script)
Runs all installation scripts in sequence.
- Pauses after script 01 for you to close/open the terminal
- Pauses after script 05 for you to logout/login
- Use `00-install-all-continue.sh` to continue after the pauses

---

## Individual Scripts

### **01-install-zsh.sh**
Installs and configures Zsh as the default shell.
- Installs Zsh, Curl and Git
- Sets Zsh as the default shell
- Creates minimal `.zshrc`
- Adds auxiliary configurations

**⚠️ After running:** Close and reopen the terminal.

---

### **02-install-prezto.sh**
Installs Prezto (framework for Zsh).
- Clones the Prezto repository
- Creates symlinks for configuration files
- Configures Prezto modules

---

### **03-install-starship.sh**
Installs and configures the Starship prompt.
- Installs Starship
- Downloads and configures `starship.toml`
- Updates `.zshrc` with Prezto + Starship

**👉 After running:** Run `source ~/.zshrc`

---

### **04-configure-git.sh**
Configures Git with identity and preferences.
- Installs Git (if needed)
- Configures name and email
- Sets default branch to `main`
- Enables colors in Git

---

### **05-install-docker.sh**
Installs Docker and Docker Compose.
- Removes old Docker installations
- Adds official Docker repository
- Installs Docker Engine, Docker Compose and plugins
- Adds user to docker group

**⚠️ After running:** Logout/login to use Docker without sudo.

---

### **06-install-node-nvm.sh**
Installs NVM (Node Version Manager) and Node.js.
- Installs NVM
- Installs Node.js version 22
- Sets Node 22 as default

---

### **07-install-yarn.sh**
Installs Yarn via Corepack.
- Enables Corepack
- Installs and activates Yarn 1

---

### **08-install-font-jetbrains.sh**
Installs JetBrains Mono Nerd Font.
- Downloads the font from the official repository
- Installs in user fonts directory
- Updates font cache

---

### **09-install-cursor.sh**
Installs Cursor Editor.
- Downloads Cursor .deb package
- Installs via dpkg
- Verifies installation

---

### **10-configure-keyboard.sh**
Configures keyboard for US International.
- Sets US International layout
- Enables cedilla (ç) support
- Configures keyboard options

---

### **11-configure-terminal.sh**
Configures GNOME Terminal with Dracula theme.
- Installs dconf-cli
- Creates "rubinho" profile in GNOME Terminal
- Applies Dracula theme
- Configures JetBrains Mono Nerd Font
- Removes old profiles

---

### **12-configure-ssh.sh**
Configures SSH for Git.
- Installs Git and OpenSSH
- Generates ed25519 SSH key
- Configures SSH agent
- Sets correct permissions
- Copies public key to clipboard

**👉 After running:** Add the SSH key to GitHub/GitLab.

---

### **13-configure-inotify.sh**
Configures inotify limits for file watching.
- Increases `max_user_watches` to 524288
- Makes the configuration persistent
- Applies changes

---

### **14-install-cursor-extensions.sh**
Installs essential Cursor extensions.
- Color Highlight
- DotENV
- ESLint
- GitLens
- Markdown Preview Enhanced
- Prisma
- px to rem
- Reload
- Tailwind CSS IntelliSense
- Indent Rainbow
- Symbols (icons)
- Catppuccin (theme)

---

### **15-configure-cursor.sh**
Applies Cursor configurations.
- Copies `settings.json` to Cursor
- Copies `keybindings.json` to Cursor
- Configures theme and preferences

**👉 After running:** Open Cursor again to apply everything.

---

## 📁 Repository Structure

```
rubinho-env/
├── linux/
│   ├── config/              # Configuration files
│   │   ├── starship.toml   # Starship prompt configuration
│   │   ├── user-settings.json  # Cursor settings
│   │   ├── cursor-keyboard.json  # Cursor keyboard shortcuts
│   │   └── zsh-config      # Additional Zsh configurations
│   └── scripts/             # Installation scripts (01-15)
├── mac/                     # macOS configurations (future)
└── readme.md               # This file
```

---

## 🛠 Maintenance

To modify scripts, update tools or version environment adjustments, just edit the corresponding files and push the changes.

---

## 📝 Important Notes

- **Execution order:** Scripts must be run in numerical order (01 → 15)
- **Required restarts:**
  - After script 01: Close and reopen the terminal
  - After script 05: Logout/login to use Docker without sudo
- **Dependencies:** Some scripts depend on others (e.g., Yarn needs Node installed)
- **Custom configurations:** Edit files in `linux/config/` before running the scripts
