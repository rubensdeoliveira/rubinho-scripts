# Anotações - Monorepo com React Native

## Criar projeto mobile dentro da pasta packages
```bash
  # Abrir pasta packages
  $ cd packages
  # Rodar no terminal
  $ npx react-native init mobile --template react-native-template-typescript
```

## Usar buscador do VS Code para achar ../node_modules
```bash
  # No buscador do VS Code procurar por
  ../node_modules
  # Quando encontrar adicionar:
  ../../ 

   OBS:antes das importações para as importações refletirem para o node_modules da raiz do projeto.

   OBS: só alterar arquivos que tá dentro da pasta mobile e verificar  somente onde tiver ../node_modules, ficando assim após a alteração:

  ../../../node_modules
 ```

## Adicionar path dentro do arquivo metro.config.js
```bash
  # Abrir pastas packages/mobile/metro.config.js para acessar arquivo metro.config.js
  $  cd packages/mobile/metro.config.js

  # No arquivo metro.config.js fora do modules.exports adicionar:
   const path = require('path');
   
  # Dentro de modules.exports, antes de transformer.
  projectRoot: path.resolve(__dirname, '.'),
  watchFolders: [path.resolve(__dirname, '../../node_modules')],

  Dica: ver anexo 4 se ficar com dúvidas
```

## Alterar linha na pasta Podfile
```bash
  # Abrir pastas packages/mobile/ios/Podfile
  $ cd packages/mobile/ios/Podfile
  # Dentro de Podfile alterar linha que tem use_react_native para:
  use_react_native!(:path => '../../../node_modules/react-native')

  Obs: basta mudar após path => 
```

## Alterar nome do projeto em package.json
```bash
  # Abrir pastas packages/mobile/package.json  para acessar arquivo package.json
  $ cd packages/mobile/package.json
  # Alterar nome do projeto para:
  @NOME_DO_PROJETO/mobile em
```

## Criar pastas src dentro da pasta mobile
```bash
  # Abrir pastas packages/mobile
  $ cd packages/mobile
  # Criar pasta src dentro da pasta mobile
  $ mkdir src
  # Caminho das pastas packages/mobile/src
```

## Criar arquivo mobile/src/App.tsx
```bash
 # Abrir pastas
 $ cd packages/mobile/src
 # Criar o arquivo App.tsx dentro da pasta src
 # Caminho das pastas até o arquivo packages/mobile/src/App.tsx
```

## Adicionar conteúdo no arquivo App.tsx 
```bash
  # Abrir pastas packages/mobile/src/App.tsx até o arquivo App.tsx
  $ cd packages/mobile/src/App.tsx
  # Dentro do arquivo App.tsx adicionar:

  import React from 'react';

  import {View} from 'react-native';

  const App: React.FC = () => <View style={{flex: 1, backgroundColor: '#000'}} />;

  export default App;

```

## Excluir arquivo App.tsx da pasta mobile
```bash
 # Abrir pastas packages/mobile
 $ cd packages/mobile
 # Excluir o arquivo App.tsx
```

## Trocar importação do arquivo index
```bash
 # Dentro de index trocar a importação de App para:

 import App from './src/App'; 
```
## Testar se o projeto mobile está funcionando
```bash
 # Abrir pastas packages/mobile
 $ cd packages/mobile
 # Rodar no terminal:
 $ yarn android
 $ yarn start
```

## Excluir arquivos da pasta mobile 
```bash
 # Abrir pastas packages/mobile
 $ cd packages/mobile
 # Excluir os arquivos:
 .eslintrc.js e prettier.config.js
```
## Excluir linhas do arquivo mobile/packages.json
```bash
 # Abrir pastas packages/mobile/packages.json para acessar aquivo package.json
 $ cd packages/mobile/packages.json 

 # Excluir as seguintes linhas do arquivo package.json:
  "lint": "eslint . --ext .js,.jsx,.ts,.tsx"
  "eslint": "^6.5.1",
  "typescript": "^3.8.3"
  "prettier": "^2.0.4",
  "@typescript-eslint/parser": "^2.27.0",
  "@typescript-eslint/eslint-plugin": "^2.27.0",
  "@react-native-community/eslint-config": "^1.1.0",
```
## Rodar yarn no terminal
```bash
 # Abrir pastas packages/mobile
 $ cd packages/mobile
 # Rodar no terminal:
 $ yarn
```
## Remover pasta __tests__
```bash
 # Abrir pastas packages/mobile
 $ cd packages/mobile
 # Remover a pasta __tests__ pois por enquanto não configuramos os testes ainda no mobile
```
## Alterar conteúdo do arquivo mobile/tsconfig.json
```bash
 # Abrir pastas packages/mobile/tsconfig.json para acessar o arquivo tsconfig.json
 $ cd packages/mobile/tsconfig.json
 
 # Dentro do arquivo tsconfig.json alterar todo o conteúdo para:
  {
    "extends": "../../tsconfig.json",
    "compilerOptions": {
      "lib": ["esnext", "dom"],   
      "allowJs": false,          
      "checkJs": false,         
      "jsx": "react-native"
    },
    "include": [
      "./src/**/*"
    ]
  }
```