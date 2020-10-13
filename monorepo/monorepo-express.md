# Anotações - Monorepo com Express (Arquitetura Simples)

## Passo 1
criar pasta 
packages > server
e dentro de
packages > server
rodar no terminal:

`yarn init -y`

## Passo 16
Dentro de 
packages > server > package.json
alterar o nome do projeto para 
@NOME_DO_PROJETO/server

## Passo 2
Dentro de
packages > server
criar arquivo 
.gitignore

## Passo 3
Procurar um gitignore para node na internet e colar no arquivo criado acima

## Passo 4
Dentro de
packages > server
rodar no terminal:

`yarn add express`

## Passo 6
Dentro de
packages > server
rodar no terminal:

`yarn tsc --init`

## Passo 71
Dentro de
packages > server > tsconfig.json
alterar todo o conteúdo para:

```
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist",                        
    "rootDir": "./src",  
  },
  "include": ["./src/**/*"]
}
```

## Passo 7
Criar pasta
packages > server > src

## Passo 8
Criar arquivo
packages > server > src > server.ts

## Passo 9
Dentro de
packages > server > src > server.ts
colocar:

```
import express from 'express'
import cors from 'cors'

const app = express();

app.use(cors())

app.get("/", (request, response) => {
  return response.json({ message: "Hello World" });
});

app.listen(3333, () => {
  console.log("Server stated on port 3333");
});
```

## Passo 11
Dentro de 
packages > server
rodar no terminal: 

`yarn add @types/express ts-node-dev -D`

## Passo 12
Dentro de 
packages > server
rodar: 

`yarn add cors`

## Passo 13
Dentro de 
packages > server
rodar: 

`yarn add @types/cors -D`

## Passo 14
Dentro de 
packages > server > package.json
adicionar tag:

```
"scripts": {
  "build": "tsc",
  "dev:server": "ts-node-dev --inspect --transpile-only --ignore-watch node_modules src/server.ts"
}, 
```

Obs: é bom digitar manualmente porque copiando dá problema.

## Passo 15
Rode a aplicação com

`yarn dev:server`

dentro de 
packages > server
para testar se tudo está ok

## Passo 16
Criar arquivo
packages > server > src > routes > index.ts

## Passo 17
Dentro de
packages > server > src > routes > index.ts
colocar:

```
import { Router } from 'express'

const routes = Router()

routes.get('/', (request, response) =>
  response.json({ message: 'Hello World' })
)

export default routes
```

## Passo 18
Substituir conteúdo de
packages > server > src > server.ts
por:

```
import express from 'express'
import cors from 'cors'
import routes from './routes'

const app = express()

app.use(cors())
app.use(express.json())

app.use(routes)

app.listen(3333, () => {
  console.log('Server stated on port 3333')
})
```

## Passo 19
Criar arquivo
packages > server > ormconfig.json

## Passo 20
Dentro de
packages > server
rodar no terminal

`yarn add typeorm pg`

## Passo 21
Dentro de
packages > server > ormconfig.json
colocar:

```
{
  "type": "postgres",
  "host": "localhost",
  "port": 5432,
  "username": "postgres",
  "password": "docker",
  "database": "dbname"
}
```

## Passo 22:
criar arquivo
packages > server > src > database > index.ts

## Passo 23:
Dentro de
packages > server > src > database > index.ts
colocar:

```
import { createConnection } from 'typeorm'

createConnection()
```

## Passo 24:
Dentro de
packages > server > src > server.ts
adicionar

`import './database'`

após a importação de routes

## Passo 25:
Dentro de
package.json
adicionar dentro do array de nohoist os dois elementos abaixo:

```
"**/typeorm/**",
"**/typeorm"
```

## Passo 25:
Rode o servidor para ver se está tudo ok agora que foi adicionado o banco