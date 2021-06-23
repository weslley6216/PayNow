# Paynow
***
## Sobre o projeto

Uma escola de programação, a CodePlay, decidiu lançar uma plataforma de cursos online de programação. Você já está trabalhando nesse projeto e agora vamos começar uma nova etapa: uma ferramenta de pagamentos capaz de configurar os meios de pagamentos e registrar as cobranças referentes a cada venda de curso na CodePlay. O objetivo deste projeto é construir o mínimo produto viável (MVP) dessa plataforma de pagamentos. Na plataforma de pagamentos temos dois perfis de usuários: os administradores da plataforma e os donos de negócios que querem vender seus produtos por meio da plataforma, como as pessoas da CodePlay, por exemplo. Os administradores devem cadastrar os meios de pagamento disponíveis, como boletos bancários, cartões de crédito, PIX etc, especificando detalhes de cada formato. Administradores também podem consultar os clientes da plataforma, consultar e avaliar solicitações de reembolso, bloquear compras por suspeita de fraudes etc. Já os donos de negócios devem ser capazes de cadastrar suas empresas e ativar uma conta escolhendo quais meios de pagamento serão utilizados. Devem ser cadastrados também os planos disponíveis para venda, incluindo seus valores e condições de desconto de acordo com o meio de pagamento. E a cada nova venda realizada, devem ser armazenados dados do cliente, do produto selecionado e do meio de pagamento escolhido. Um recibo deve ser emitido para cada pagamento e esse recibo deve ser acessível para os clientes finais, alunos da CodePlay no nosso contexto.

## Requisitos Necessários:

* Ruby 3.0.0
* Rails 6.1.3.2

### Gems adcionais
<ul>
  <li>Testes</li>
  <ul>
    <li>Rspec</li>
    <li>Capybara</li>
    <li>Shouda Matchers</li>
  </ul>
</ul>
<ul>
  <li>Autenticação/Autorização</li>
  <ul>
    <li>Devise</li>
  </ul>
</ul>

## Funcionalidades
### Usuários administradores
* Gerenciam meios de pagamentos
* Gerenciam empresas cadastradas na plataforma

### Clientes Paynow
* Cadastram empresas na plataforma
* Contratam meios de pagamentos disponíveis
* Cadastram e gerenciam produtos na plataforma

## Para executar o projeto:
* Clone em sua máquina

```shell
git clone https://github.com/weslley6216/PayNow.git
```

### Instale as dependências
```shell
cd PayNow
bin/setup
```

### Configure o Banco de Dados
Realize a criação de dados preexistentes no banco de dados com o comando
```shell
rails db:seed
```

### Execute a aplicação
```shell
rails s
```
### Acesse
```shell
http://localhost:3000
```

### Demais observações
* Usuários administradores só podem ser cadastrados via console e tem como **obrigatoriedade** a utilização do domínio **@paynow.com.br** no momento do cadastro.
Para logar com um usuário administrador pré-cadastrado acesse ```http://localhost:3000/admins/sign_in``` e faça login na aplicação com o email e senha abaixo:
```
email: admin@paynow.com.br, senha: 123456
```
* Usuários clientes podem ser cadastrados normalmente via homepage **exceto** com os domínios de públicos como **gmail.com, hotmail.com, yahoo.com.br** ou **paynow.com.br**.

* Também é possível logar como usuário pré-cadastrado com o seguinte email abaixo:
```
email: user@codeplay.com.br, senha: 123456
```


