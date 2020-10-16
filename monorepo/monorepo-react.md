# Anotações - Monorepo com React

## Passo 24
Dentro de
packages
rodar no terminal:

```npx create-react-app web --template typescript```

## Passo 70
Dentro de
packages > web > tsconfig.json
alterar todo o conteúdo para:

```
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "lib": ["esnext", "dom"],   
    "allowJs": false,          
    "checkJs": false,         
    "jsx": "react"
  },
  "include": [
    "./src/**/*"
  ]
}
```

## Passo 59
Dentro de
packages > web > package.json
excluir a tag:

```
"eslintConfig": {
  "extends": "react-app"
},
```

## Passo 25
Dentro de
packages > web
excluir arquivo readme

## Passo 26
Excluir arquivos desnecessários de
packages > web > src
deixando somente os arquivos App.tsx e index.tsx

## Passo 27
Trocar conteúdo de
packages > web > src > index.tsx
por: 

```
import React from "react";
import ReactDOM from "react-dom";
import App from "./App";

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
document.getElementById("root")
);
```

## Passo 28
Trocar conteúdo de
packages > web > src > App.tsx
por:

```
import React from 'react';

const App: React.FC = () => <h1>Projeto vazio</h1>

export default App;
```

## Passo 29
Excluir arquivos desnecessários de
packages > web > public
deixando somente os arquivos index.html e robots.txt

## Passo 30
Dentro de 
packages > web > public > index.html
excluir comentários e as linhas:

```
<link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
<link rel="apple-touch-icon" href="%PUBLIC_URL%/logo192.png" />
<link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
```

## Passo 31
Dentro de 
packages > web > package.json
alterar nome do projeto para
@NOME_DO_PROJETO/web

## Passo 32
Dentro de
packages > web
rodar no terminal:

`yarn start`

para testar a aplicação web

## Passo 33
Dentro de
packages > web
rodar no terminal:

`yarn add styled-components polished`
`yarn add @types/styled-components -D`

## Passo 34
Criar pasta
packages > web > src > styled

## ...
Criar arquivo
packages > web > src > global.ts

## ...
Dentro do arquivo
packages > web > src > global.ts
colocar conteúdo:

```
import { createGlobalStyle } from 'styled-components'

export const GlobalStyle = createGlobalStyle`
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    outline: 0;
  }

  :root {
    font-size: 62.5%;
    --primary-color: #00b3b4;
    --secondary-color: #0078b5;
    --contrast-color: #fff;
    --error-color: #c53030;
  }

  body {
    background: var(--primary-color);
    color: var(--font-color);
    -webkit-font-smoothing: antialiased;
  }

  body, input, button {
    font-family: 'Roboto', sans-serif;
    font-size: 1.6rem;
  }

  button {
    cursor: pointer;
  }
`
```

## ...
Dentro de
packages > web > src > App.tsx
trocar conteúdo por:

```
import React from 'react'
import { GlobalStyle } from './styles/global'

const App: React.FC = () => (
  <>
    <p>Projeto vazio</p>
    <GlobalStyle />
  </>
)

export default App
```

## ...
Criar pasta
packages > web > SignIn

## ...
Criar arquivos
packages > web > SignIn > index.tsx
packages > web > SignIn > styles.ts

## ...
Dentro de 
packages > web > SignIn > index.tsx
colocar:

```
import React from 'react'

import { Container, Content } from './styles'

const SignIn: React.FC = () => {
  return (
    <Container>
      <Content>
        <form>
          <h1>Faça seu login</h1>

          <input placeholder="E-mail" />
          <input placeholder="Senha" type="password" />
          <button type="submit">Entrar</button>
        </form>

        <a href="teste">Criar Conta</a>
      </Content>
    </Container>
  )
}

export default SignIn
```

## ...
Dentro de
packages > web > SignIn > styles.ts
colocar:

```
import styled from 'styled-components'
import { shade } from 'polished'

export const Container = styled.div`
  height: 100vh; // Forçar a altura da tela ser a altura total do navegador

  display: flex;
  justify-content: center;
  align-items: stretch; // Força os elementos filhos esticarem para terem 100vh;
`

export const Content = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  width: 100%;
  max-width: 70rem;

  form {
    margin: 8rem 0;
    width: 34rem;
    text-align: center;

    h1 {
      margin-bottom: 2.4rem;
      color: var(--contrast-color);
    }

    input {
      background: var(--contrast-color);
      border-radius: 10px;
      border: 2px solid var(--contrast-color);
      padding: 1.6rem;
      width: 100%;

      & + input {
        margin-top: 0.8rem;
      }
    }

    button {
      background: var(--secondary-color);
      height: 56px;
      border-radius: 10px;
      border: 0;
      padding: 0 1.6rem;
      width: 100%;
      color: var(--contrast-color);
      margin-top: 1.6rem;
      transition: background-color 0.2s;

      &:hover {
        background: ${shade(0.2, '#0078b5')};
      }
    }
  }

  a {
    color: var(--contrast-color);
    display: block;
    margin-top: 2.4rem;
    text-decoration: none;
    transition: color 0.2s;

    &:hover {
      color: ${shade(0.2, '#fff')};
    }
  }
`
```

## ...
Dentro de
packages > web > src > App.tsx
trocar conteúdo por:

```
import React from 'react'
import SignIn from './pages/SignIn'
import { GlobalStyle } from './styles/global'

const App: React.FC = () => (
  <>
    <SignIn />
    <GlobalStyle />
  </>
)

export default App
```

## ...
Dentro de
packages > web

`yarn add react-icons @unform/core @unform/web`

## ...
criar pasta
packages > web > src > components > Input

## ... 
criar arquivo
packages > web > src > components > Input > index.tsx
e dentro colocar:

```
import React, {
  InputHTMLAttributes,
  useEffect,
  useRef,
  useState,
  useCallback
} from 'react'
import { IconBaseProps } from 'react-icons'
import { FiAlertCircle } from 'react-icons/fi'
import { useField } from '@unform/core'

import { Container, Error } from './styles'

interface IInputProps extends InputHTMLAttributes<HTMLInputElement> {
  name: string
  containerStyle?: Object
  icon: React.ComponentType<IconBaseProps>
}

const Input: React.FC<IInputProps> = ({
  name,
  containerStyle = {},
  icon: Icon,
  ...rest
}) => {
  const inputRef = useRef<HTMLInputElement>(null)

  const [isFocused, setIsFocused] = useState(false)
  const [isFilled, setIsFilled] = useState(false)

  const { fieldName, defaultValue, error, registerField } = useField(name)

  const handleInputFocus = useCallback(() => {
    setIsFocused(true)
  }, [])

  const handleInputBlur = useCallback(() => {
    setIsFocused(false)

    setIsFilled(!!inputRef.current?.value)
  }, [])

  useEffect(() => {
    registerField({
      name: fieldName,
      ref: inputRef.current,
      path: 'value'
    })
  }, [fieldName, registerField])

  return (
    <Container
      style={containerStyle}
      isErrored={!!error}
      isFilled={isFilled}
      isFocused={isFocused}
      data-testid="input-container"
    >
      {Icon && <Icon size={20} />}
      <input
        onFocus={handleInputFocus}
        onBlur={handleInputBlur}
        defaultValue={defaultValue}
        ref={inputRef}
        {...rest}
      />
      {error && (
        <Error title={error}>
          <FiAlertCircle color="var(--error-color)" size={20} />
        </Error>
      )}
    </Container>
  )
}

export default Input
```

## ... 
criar arquivo
packages > web > src > components > Input > styles.ts
e dentro colocar:

```
import styled, { css } from 'styled-components'

import Tooltip from '../Tooltip'

interface IContainerProps {
  isFocused: boolean
  isFilled: boolean
  isErrored: boolean
}

export const Container = styled.div<IContainerProps>`
  background: var(--contrast-color);
  border-radius: 10px;
  padding: 1.6rem;
  width: 100%;
  border: 2px solid var(--contrast-color);
  display: flex;
  align-items: center;
  & + div {
    margin-top: 0.8rem;
  }
  ${props =>
    props.isErrored &&
    css`
      border-color: var(--error-color);
    `}
  ${props =>
    props.isFocused &&
    css`
      color: var(--secondary-color);
      border-color: var(--secondary-color);
    `}
  ${props =>
    props.isFilled &&
    css`
      color: var(--secondary-color);
    `}
  input {
    flex: 1;
    background: transparent;
    border: 0;
  }
  svg {
    margin-right: 1.6rem;
  }
`

export const Error = styled(Tooltip)`
  height: 20px;
  margin-left: 1.6rem;
  svg {
    margin: 0;
  }
  span {
    background: var(--error-color);
    color: #fff;
    &::before {
      border-color: var(--error-color) transparent;
    }
  }
`

```

## ... 
criar pasta
packages > web > src > components > Tooltip

## ... 
criar arquivo
packages > web > src > components > Tooltip > index.tsx
colocar:

```
import React from 'react'

import { Container } from './styles'

interface ITooltipProps {
  title: string
  className?: string
}

const Tooltip: React.FC<ITooltipProps> = ({
  title,
  className = '',
  children,
}) => {
  return (
    <Container className={className}>
      {children}
      <span>{title}</span>
    </Container>
  )
}

export default Tooltip
```

## ... 
criar arquivo
packages > web > src > components > Tooltip > styles.ts
e dentro colocar:

```
import styled from 'styled-components'

export const Container = styled.div`
  position: relative;
  span {
    width: 160px;
    background: var(--secondary-color);
    padding: 0.8rem;
    border-radius: 4px;
    font-size: 1.4rem;
    font-weight: 500;
    opacity: 0;
    transition: opacity 0.4s;
    visibility: hidden;
    position: absolute;
    bottom: calc(100% + 12px);
    left: 50%;
    transform: translateX(-50%);
    color: var(--primary-color);
    &::before {
      content: '';
      border-style: solid;
      border-color: var(--secondary-color) transparent;
      border-width: 6px 6px 0 6px;
      top: 100%;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
  }
  &:hover span {
    opacity: 1;
    visibility: visible;
  }
`
```

## ...
Dentro de
packages > web
rodar no terminal

`yarn add yup react-router-dom`

## ... 
Dentro de
packages > web
rodar no terminal

`yarn add @types/yup @types/react-router-dom -D`

## ... 
Criar pasta
packages > web > utils

## ... 
Criar arquivo
packages > web > utils > getValidationErros.ts
e dentro colocar:

```
import { ValidationError } from 'yup'

interface IErrors {
  [key: string]: string
}

export default function getValidationErrors(err: ValidationError): IErrors {
  const validationErrors: IErrors = {}

  err.inner.forEach(error => {
    validationErrors[error.path] = error.message
  })

  return validationErrors
}
```

## ...
Criar pasta 
packages > web > src > components > Button

## ...
Criar arquivo 
packages > web > src > components > Button > index.tsx
e dentro colocar:

```
import React, { ButtonHTMLAttributes } from 'react'

import { Container } from './styles'

type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
  loading?: boolean
}

const Button: React.FC<ButtonProps> = ({ children, loading, ...rest }) => (
  <Container type="button" {...rest}>
    {loading ? 'Carregando...' : children}
  </Container>
)

export default Button

```

## ...
Criar arquivo 
packages > web > src > components > Button > styles.ts
e dentro colocar:

```
import styled from 'styled-components'
import { shade } from 'polished'

export const Container = styled.button`
  background: var(--secondary-color);
  height: 56px;
  border-radius: 10px;
  border: 0;
  padding: 0 1.6rem;
  color: var(--contrast-color);
  width: 100%;
  font-weight: 500;
  margin-top: 1.6rem;
  transition: background-color 0.2s;
  &:hover {
    background: ${shade(0.2, '#0078b5')};
  }
`
```

## ... 
Substituir todo o conteúdo de
packages > web > src > pages > SignIn > index.tsx
por:

```
import React, { useCallback, useRef } from 'react'
import { Form } from '@unform/web'
import { Container, Content } from './styles'
import * as Yup from 'yup'

import Button from '../../components/Button'
import Input from '../../components/input'
import { FormHandles } from '@unform/core'
import { useHistory } from 'react-router-dom'
import { FiLock, FiMail } from 'react-icons/fi'
import getValidationErrors from '../../utils/getValidationErrors'

interface ISignInFormData {
  email: string
  password: string
}

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null)

  // const { signIn } = useAuth()

  const history = useHistory()

  const handleSubmit = useCallback(
    async (data: ISignInFormData) => {
      try {
        formRef.current?.setErrors({})

        const schema = Yup.object().shape({
          email: Yup.string()
            .required('E-mail obrigatório')
            .email('E-mail inválido'),
          password: Yup.string().required('Senha obrigatória')
        })

        await schema.validate(data, {
          abortEarly: false
        })

        // await signIn({
        //   email: data.email,
        //   password: data.password
        // })

        history.push('/dashboard')
      } catch (err) {
        if (err instanceof Yup.ValidationError) {
          const errors = getValidationErrors(err)

          formRef.current?.setErrors(errors)
        }
      }
    },
    [history]
  )

  return (
    <Container>
      <Content>
        <Form ref={formRef} onSubmit={handleSubmit}>
          <h1>Faça seu login</h1>

          <Input icon={FiMail} name="email" placeholder="E-mail" />
          <Input
            icon={FiLock}
            name="password"
            placeholder="Senha"
            type="password"
          />
          <Button type="submit">Entrar</Button>
        </Form>

        <a href="temporário">Criar Conta</a>
      </Content>
    </Container>
  )
}

export default SignIn
```

## ..
Trocar conteúdo de 
packages > web > src > pages > SignIn > styles.ts
por:

```
import styled from 'styled-components'
import { shade } from 'polished'

export const Container = styled.div`
  height: 100vh; // Forçar a altura da tela ser a altura total do navegador

  display: flex;
  justify-content: center;
  align-items: stretch; // Força os elementos filhos esticarem para terem 100vh;
`

export const Content = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  width: 100%;
  max-width: 70rem;

  form {
    margin: 8rem 0;
    width: 34rem;
    text-align: center;

    h1 {
      margin-bottom: 2.4rem;
      color: var(--contrast-color);
    }
  }

  a {
    color: var(--contrast-color);
    display: block;
    margin-top: 2.4rem;
    text-decoration: none;
    transition: color 0.2s;

    &:hover {
      color: ${shade(0.2, '#fff')};
    }
  }
`
```

## ... 
Criar pasta 
src > packages > web > src > routes

## ... 
Criar arquivo 
src > packages > web > src > index.tsx
e dentro colocar:

```
import React from 'react'
import { Switch } from 'react-router-dom'

import Route from './Route'

import SignIn from '../pages/SignIn'
// import SignUp from '../pages/SignUp'

// import Dashboard from '../pages/Dashboard'

const Routes: React.FC = () => (
  <Switch>
    <Route path="/" exact component={SignIn} />
    {/* <Route path="/signup" component={SignUp} /> */}

    {/* <Route path="/dashboard" component={Dashboard} isPrivate /> */}
  </Switch>
)

export default Routes
```

## ... 
Criar arquivo 
src > packages > web > src > Route.tsx
e dentro colocar:

```
import React from 'react'
import {
  Route as ReactDOMRoute,
  RouteProps as ReactDOMRouteProps,
  Redirect,
} from 'react-router-dom'

import { useAuth } from '../hooks/auth'

interface IRouteProps extends ReactDOMRouteProps {
  isPrivate?: boolean
  component: React.ComponentType
}

const Route: React.FC<IRouteProps> = ({
  isPrivate = false,
  component: Component,
  ...rest
}) => {
  const { user } = useAuth()

  return (
    <ReactDOMRoute
      {...rest}
      render={({ location }) => {
        return isPrivate === !!user ? (
          <Component />
        ) : (
          <Redirect
            to={{
              pathname: isPrivate ? '/' : '/dashboard',
              state: { from: location },
            }}
          />
        )
      }}
    />
  )
}

export default Route
```

## ..
Criar pasta
packages > web > src > hooks

## ..
Criar arquivo
packages > web > src > index.tsx
e dentro colocar:

```
import React from 'react'

import { AuthProvider } from './auth'

const AppProvider: React.FC = ({ children }) => (
  <AuthProvider>{children}</AuthProvider>
)

export default AppProvider
```

## ..
Criar arquivo
packages > web > src > auth.tsx
e dentro colocar:

```
import React, { createContext, useCallback, useState, useContext } from 'react'
import api from '@NOME_DO_PROJETO/axios-config'

interface IUser {
  id: string
  name: string
  email: string
  avatar_url: string
}

interface IAuthState {
  token: string
  user: IUser
}

interface ISingInCredentials {
  email: string
  password: string
}

interface IAuthContextData {
  user: IUser
  signIn(credentials: ISingInCredentials): Promise<void>
  signOut(): void
}

const AuthContext = createContext<IAuthContextData>({} as IAuthContextData)

const AuthProvider: React.FC = ({ children }) => {
  const [data, setData] = useState<IAuthState>(() => {
    const token = localStorage.getItem('@NOME_DO_APLICATIVO:token')
    const user = localStorage.getItem('@NOME_DO_APLICATIVO:user')

    if (token && user) {
      api.defaults.headers.authorization = `Bearer ${token}`

      return { token, user: JSON.parse(user) }
    }

    return {} as IAuthState
  })

  const signIn = useCallback(async ({ email, password }) => {
    const response = await api.post('sessions', {
      email,
      password
    })

    const { token, user } = response.data

    localStorage.setItem('@NOME_DO_APLICATIVO:token', token)
    localStorage.setItem('@NOME_DO_APLICATIVO:user', JSON.stringify(user))

    api.defaults.headers.authorization = `Bearer ${token}`

    setData({ token, user })
  }, [])

  const signOut = useCallback(async () => {
    localStorage.removeItem('@NOME_DO_APLICATIVO:token')
    localStorage.removeItem('@NOME_DO_APLICATIVO:user')

    setData({} as IAuthState)
  }, [])

  return (
    <AuthContext.Provider value={{ user: data.user, signIn, signOut }}>
      {children}
    </AuthContext.Provider>
  )
}

const useAuth = (): IAuthContextData => {
  const context = useContext(AuthContext)

  return context
}

export { AuthProvider, useAuth }
```

## ..
Alterar todo o conteúdo de
packages > web > src > App.tsx
por:

```
import React from 'react'
import { BrowserRouter } from 'react-router-dom'

import { GlobalStyle } from './styles/global'

import AppProvider from './hooks'

import Routes from './routes'

const App: React.FC = () => (
  <BrowserRouter>
    <AppProvider>
      <Routes />
    </AppProvider>

    <GlobalStyle />
  </BrowserRouter>
)

export default App
```

## ..
Adicionar pasta
packages > web > src > pages > Dashboard

## ..
Criar arquivo
packages > web > src > pages > Dasboard > index.tsx
e dentro colocar:

```
import React from 'react'
import { useAuth } from '../../hooks/auth'

const Dashboard: React.FC = () => {
  const { signOut } = useAuth()

  return (
    <>
      <p>Bem-vindo ao Dashboard</p>
      <button type="button" onClick={signOut}>
        Sair
      </button>
    </>
  )
}

export default Dashboard
```

## ..
Adicionar pasta
packages > web > src > pages > SignUp

## ..
Criar arquivo
packages > web > src > pages > SignUp > index.tsx
e dentro colocar:

```
import React, { useCallback, useRef } from 'react'
import { Form } from '@unform/web'
import { Container, Content } from './styles'
import * as Yup from 'yup'

import Button from '../../components/Button'
import Input from '../../components/input'
import { FormHandles } from '@unform/core'
import { Link, useHistory } from 'react-router-dom'
import { FiLock, FiMail, FiUser } from 'react-icons/fi'
import getValidationErrors from '../../utils/getValidationErrors'
import api from '@monoreact/axios-config'

interface ISignUpFormData {
  name: string
  email: string
  password: string
}

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null)

  const history = useHistory()

  const handleSubmit = useCallback(
    async (data: ISignUpFormData) => {
      try {
        formRef.current?.setErrors({})

        const schema = Yup.object().shape({
          name: Yup.string().required('Nome obrigatório'),
          email: Yup.string()
            .required('E-mail obrigatório')
            .email('E-mail inválido'),
          password: Yup.string().required('Senha obrigatória')
        })

        await schema.validate(data, {
          abortEarly: false
        })

        await api.post('/users', data)

        history.push('/')
      } catch (err) {
        if (err instanceof Yup.ValidationError) {
          const errors = getValidationErrors(err)

          formRef.current?.setErrors(errors)
        }
      }
    },
    [history]
  )

  return (
    <Container>
      <Content>
        <Form ref={formRef} onSubmit={handleSubmit}>
          <h1>Crie sua conta</h1>

          <Input icon={FiUser} name="name" placeholder="Nome" />
          <Input icon={FiMail} name="email" placeholder="E-mail" />
          <Input
            icon={FiLock}
            name="password"
            placeholder="Senha"
            type="password"
          />
          <Button type="submit">Cadastrar</Button>
        </Form>

        <Link to="/">Voltar para login</Link>
      </Content>
    </Container>
  )
}

export default SignIn
```

## ..
Criar arquivo
packages > web > src > pages > SignUp > styles.ts
e dentro colocar:

```
import styled from 'styled-components'
import { shade } from 'polished'

export const Container = styled.div`
  height: 100vh; // Forçar a altura da tela ser a altura total do navegador

  display: flex;
  justify-content: center;
  align-items: stretch; // Força os elementos filhos esticarem para terem 100vh;
`

export const Content = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  width: 100%;
  max-width: 70rem;

  form {
    margin: 8rem 0;
    width: 34rem;
    text-align: center;

    h1 {
      margin-bottom: 2.4rem;
      color: var(--contrast-color);
    }
  }

  a {
    color: var(--contrast-color);
    display: block;
    margin-top: 2.4rem;
    text-decoration: none;
    transition: color 0.2s;

    &:hover {
      color: ${shade(0.2, '#fff')};
    }
  }
`
```

## ..
Alterar conteúdo de
packages > web > src > pages > SignIn > index.tsx
por:

```
import React, { useCallback, useRef } from 'react'
import { Form } from '@unform/web'
import { Container, Content } from './styles'
import * as Yup from 'yup'

import Button from '../../components/Button'
import Input from '../../components/input'
import { FormHandles } from '@unform/core'
import { Link, useHistory } from 'react-router-dom'
import { FiLock, FiMail, FiUser } from 'react-icons/fi'
import getValidationErrors from '../../utils/getValidationErrors'
import api from '@monoreact/axios-config'

interface ISignUpFormData {
  name: string
  email: string
  password: string
}

const SignIn: React.FC = () => {
  const formRef = useRef<FormHandles>(null)

  const history = useHistory()

  const handleSubmit = useCallback(
    async (data: ISignUpFormData) => {
      try {
        formRef.current?.setErrors({})

        const schema = Yup.object().shape({
          name: Yup.string().required('Nome obrigatório'),
          email: Yup.string()
            .required('E-mail obrigatório')
            .email('E-mail inválido'),
          password: Yup.string().required('Senha obrigatória')
        })

        await schema.validate(data, {
          abortEarly: false
        })

        await api.post('/users', data)

        history.push('/')
      } catch (err) {
        if (err instanceof Yup.ValidationError) {
          const errors = getValidationErrors(err)

          formRef.current?.setErrors(errors)
        }
      }
    },
    [history]
  )

  return (
    <Container>
      <Content>
        <Form ref={formRef} onSubmit={handleSubmit}>
          <h1>Crie sua conta</h1>

          <Input icon={FiUser} name="name" placeholder="Nome" />
          <Input icon={FiMail} name="email" placeholder="E-mail" />
          <Input
            icon={FiLock}
            name="password"
            placeholder="Senha"
            type="password"
          />
          <Button type="submit">Cadastrar</Button>
        </Form>

        <Link to="/">Voltar para login</Link>
      </Content>
    </Container>
  )
}

export default SignIn
```

## ...
Alterar todo o conteúdo de
src > packages > web > src > routes > index.tsx
por:

```
import React from 'react'
import { Switch } from 'react-router-dom'

import Route from './Route'

import SignIn from '../pages/SignIn'
import SignUp from '../pages/SignUp'

import Dashboard from '../pages/Dashboard'

const Routes: React.FC = () => (
  <Switch>
    <Route path="/" exact component={SignIn} />
    <Route path="/signup" component={SignUp} />

    <Route path="/dashboard" component={Dashboard} isPrivate />
  </Switch>
)

export default Routes
```