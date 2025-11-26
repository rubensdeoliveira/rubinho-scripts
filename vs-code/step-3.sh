#!/usr/bin/env bash

set -e

echo "======================================="
echo "===== INSTALAÇÃO DO AMBIENTE DEV ====="
echo "======================================="

###########################################################################
# 1. DOCKER
###########################################################################

echo "===== [DOCKER] Atualizando sistema ====="
sudo apt update -y && sudo apt upgrade -y

echo "===== [DOCKER] Removendo instalações antigas ====="
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "===== [DOCKER] Instalando dependências ====="
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "===== [DOCKER] Adicionando chave GPG ====="
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "===== [DOCKER] Adicionando repositório ====="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

echo "===== [DOCKER] Instalando Docker ====="
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "===== [DOCKER] Testando Docker ====="
sudo docker run --rm hello-world || true

echo "===== [DOCKER] Adicionando usuário ao grupo docker ====="
sudo usermod -aG docker $USER
echo "⚠ Deslogue e logue novamente para usar Docker sem sudo!"

###########################################################################
# 2. NODE + NVM + YARN
###########################################################################

echo "===== [NODE] Instalando NVM ====="
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "NVM já instalado"
fi

# Carregar NVM
source "$NVM_DIR/nvm.sh"

echo "===== [NODE] Instalando Node 22 ====="
nvm install 22
nvm alias default 22

echo "Node -> $(node -v)"
echo "NPM  -> $(npm -v)"

echo "===== [YARN] Habilitando Corepack ====="
corepack enable
corepack prepare yarn@1 --activate

echo "Yarn -> $(yarn -v)"

###########################################################################
# 3. JETBRAINS MONO NERD FONT
###########################################################################

echo "===== [FONTS] Instalando JetBrainsMono Nerd Font ====="

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$FONT_DIR"

wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d "$FONT_DIR" > /dev/null
rm JetBrainsMono.zip

fc-cache -fv

echo "===== [FONTS] JetBrainsMono Nerd Font instalada ====="

###########################################################################
# 4. CURSOR 
###########################################################################

echo "===== [CURSOR] Instalando Cursor Editor ====="

curl -L "https://downloads.cursor.com/linux/appImage/x64" -o cursor.AppImage
chmod +x cursor.AppImage
sudo mv cursor.AppImage /usr/local/bin/cursor

echo "Cursor -> instalado com sucesso!"
cursor --version || echo "Cursor instalado, mas versão não pôde ser exibida."

###########################################################################
# 5. TECLADO EUA INTERNACIONAL + cedilha
###########################################################################

echo "===== [KEYBOARD] Configurando teclado EUA internacional ====="
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl')]"

echo "===== [KEYBOARD] Fix cedilha (ç) ====="
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"

###########################################################################
# 6. TEMA DRÁCULA + CRIAÇÃO DE PROFILE NOVO
###########################################################################

echo "===== [DRACULA] Criando novo profile no GNOME Terminal ====="

NEW_PROFILE=$(uuidgen)

# Pega lista atual
LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)

# Insere o novo UUID
NEW_LIST=$(echo "$LIST" | sed "s/]$/, '$NEW_PROFILE']/")

# Aplica nova lista
gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"

# Define como padrão
gsettings set org.gnome.Terminal.ProfilesList default "$NEW_PROFILE"

echo "Novo profile criado: $NEW_PROFILE"

BASE="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$NEW_PROFILE/"

echo "===== [DRACULA] Aplicando fonte ====="
gsettings set "$BASE" font "'JetBrainsMono Nerd Font 13'"

echo "===== [DRACULA] Baixando tema Dracula ====="
TMP_DRACULA="/tmp/dracula-term"
rm -rf "$TMP_DRACULA"
git clone --depth=1 https://github.com/dracula/gnome-terminal.git "$TMP_DRACULA"

echo "===== [DRACULA] Aplicando tema ====="
"$TMP_DRACULA"/install.sh --scheme Dracula --profile "$NEW_PROFILE" --force || true

echo "===== [DRACULA] Tema aplicado no novo profile ====="

###########################################################################
# 7. FINAL
###########################################################################

echo ""
echo "======================================="
echo " AMBIENTE DEV CONFIGURADO COM SUCESSO! "
echo "======================================="
echo "Reabra o terminal para aplicar temas e fonte."
