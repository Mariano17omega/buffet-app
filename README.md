# Projeto Crash Course - Cadê Buffet?

Projeto desenvolvido para o Crash Course do TreinaDev 12 da Campus Code.

A aplicação **Cadê Buffet?** visa oferecer uma solução abrangente para a busca e contratação de serviços de buffet, proporcionando uma experiência simplificada e eficiente para os usuários.

Este projeto é uma plataforma onde donos de buffets podem cadastrar suas empresas e serviços, enquanto os usuários regulares podem encontrar e solicitar os serviços de buffet de acordo com suas preferências.

## Tecnologias Utilizadas

A aplicação é construida usando TDD com Ruby on Rails

- Ruby: 3.3.0
 
- Rails: 7.1.3 


## Principais Funcionalidades da Aplicação

- **Cadastro de Buffets:** Donos de buffets podem: 
  - Cadastrar suas empresas
  - Listar os serviços oferecidos
  - Cadastrar eventos e seus respectivos valores
  - Receber pedidos de clientes interessadas em realizar uma festa
  - Listar os pedidos dos clientes
  
- **Busca de Buffets:** Visitantes podem:
  - Buscar buffets de acordo com: 
    - o nome de evento
    - o nome de buffet
    - a cidade
  - Visualizar detalhes de eventos
- **Fazer um pedido:** Clientes podem:
  - Fazer um pedido
  - Listar os pedidos

## Executando o Projeto

Para iniciar o projeto usando dados fake, siga as etapas abaixo:


- Instale as gemas necessárias usando `bundle install`.

- Crie o banco de dados executando `rails db:setup`.

- Execute o projeto `rails s`.

 
O banco de dados é populado usando a `gem Faker`.

Para fazer login como dono de um Buffet, use o email de um dos Buffets. Esses emails podem ser obtidos visualizando os detalhes de um Buffet como Visitante. A senha padrão é `senha123`.

Para obter os emails dos clientes e fazer login como cliente, execute o comando `UserClient.all` no console do Rails para listar os clientes. A senha padrão para clientes também é `senha123`.

## Documentação da API da aplicação

 Esta API foi desenvolvida para integrar o sistema da aplicação Cadê Buffet com outras outras aplicações.
 
 A API está disponível via requisições HTTP e retorna respostas em formato JSON.

### Endpoints
Após execute o projeto com `rails s`, temos os seguintes Endpoints disponíveis:

#### 1. Listagem e busca de Buffets

**URL:** `/api/v1/buffets`

**Método HTTP:** `GET`

**Descrição:** Fornece uma listagem completa de buffets cadastrados na plataforma em ordem alfabética, com a opção de buscar por nome.


**Parâmetros:**
- `search?query` (opcional): Parâmetro de query para filtrar a listagem pelo nome do buffet.

**Exemplo de Requisição:**
```
GET /api/v1/buffets/search?query=orange
```


**Resposta de Sucesso (200):** Retorna um array, com cada elemento sendo um JSON com todos os detalhes de um Buffet exceto CNPJ e razão social.. Se não tiver buffes no banco de dados, o array retornado será vazio.

#### 2. Listagem de Tipos de Eventos de um Buffet

**URL:** `/api/v1/buffets/:buffet_id/events`

**Método HTTP:** `GET`

**Descrição:** A partir do ID de um buffet, fornece uma lista com informações sobre os tipos de eventos disponíveis no buffet.

**Parâmetros:**
- `buffet_id` (obrigatório): ID do buffet.

**Exemplo de Requisição:**

```
GET /api/v1/buffets/1/events
```

**Resposta de Sucesso (200):** Retorna um array, com cada elemento sendo um JSON com todos os detalhes de um tipo de evento. 


#### 3. Detalhes de um Buffet

**URL:** `/api/v1/buffets/:buffet_id`

**Método HTTP:** `GET`

**Descrição:** A partir do ID de um buffet, fornece todos os detalhes do buffet exceto CNPJ e razão social.

**Parâmetros:**
- `buffet_id` (obrigatório): ID do buffet.

**Exemplo de Requisição:**
```
GET /api/v1/buffets/1
```

**Resposta de Sucesso (200):** Retorna um JSON com os detalhes do Buffet.

**Resposta de falha (404):**  Se não encontra o buffet.


#### 4. Consulta de Disponibilidade

**URL:** `get "/api/v1/events/availability?event_id=:event_id&date_event=:date_event&num_guests=:num_guests"`
 
**Método HTTP:** `GET`

**Descrição:** Informando um ID de um tipo de evento, a data do evento e a quantidade de convidados, verifica a disponibilidade para realizar um evento. Em caso positivo, retorna o valor prévio do pedido, em caso negativo, uma mensagem de erro.

**Parâmetros:** 

- `event_id` (obrigatório): ID do tipo de evento.
- `date_event` (obrigatório): Data do evento no formato dd-mm-aaaa.
- `num_guests` (obrigatório): Quantidade de convidados.

**Exemplo de Requisição:**
``` GET /api/v1/events/availability?event_id=1&date_event=11-11-2025&num_guests=11```

**Resposta de Sucesso (200):** Retorna apenas o valor prévio do pedido.

**Resposta de Erro (404):** Retorna uma mensagem de erro se o evento não existir.

``` { errors: { event: 'Evento não encontrado' }  ```

**Resposta de Erro (422):** Retorna uma mensagem de erro se o parametro não for valido.

``` { errors: { date_event: 'A data do evento deve ser no futuro' } } ```

``` { errors: { num_guests: 'O número de convidados deve ser maior que zero' } } ```


## Banco de dados

Os models da aplicação estão organizados com as seguintes associações:

<img src='/UML.png'>

## Tarefas para a construção projeto

Para organizar a construção da aplicação, as tarefas de cada sprint foram reformuladas como uma lista de **Objetivos da Tarefa**. Com base nessa lista de objetivos, são construídos os testes de TDD. Os testes são detalhados na subseção **Solução**.

### 1 - Tarefa 1: Criar conta como dono de buffet

Um usuário pode criar sua conta como dono de um buffet informando seu e-mail e uma senha. No futuro, teremos também usuários do tipo cliente que vão precisar criar sua conta para contratar um buffet. Esta sprint é focada no usuário dono de buffet, mas estamos antecipando esta informação para seu planejamento.

#### Objetivos da Tarefa

- [x]  Criar uma tela incial com dois botões para o usuário dizer se ele é um dono de buffet ou um cliente.

- [x] Se o usuário for um dono de buffet, ele deve ser direcionado para uma tela de login com um formulario com e-mail e senha. 

- [x] Depois criamos uma tela para o caso do usuário for um usuário cliente.

  
##### Solução 
```
describe 'Usuario visita tela inicial' do
  context 'como dono de buffet' do
    it 'e vê as opções de login de usuários' do
    end
    it 'e vê a página de inscrição para um dono de bufê' do
    end
    it 'e faz a inscrição com sucesso como um dono de bufê' do 
    end
    it 'e faz o login e depois o logout' do 
    end
  end
end
```

### 2 - Tarefa 2: Cadastrar buffet

Com sua conta criada, o usuário deve, obrigatoriamente, cadastrar seu buffet informando: nome fantasia, razão social, CNPJ, telefone para contato, e-mail para contato e endereço completo com endereço, bairro, estado, cidade e CEP. Além destes dados, o dono do buffet deve poder adicionar uma descrição de seu buffet e os meios de pagamentos aceitos.

O usuário dono de buffet deve ser o único capaz de editar os dados de seu próprio buffet. Não deve ser possível excluir um buffet.

Cada usuário deve possuir somente um buffet cadastrado e o buffet deve estar diretamente vinculado ao usuário.

Um usuário dono de buffet deve, obrigatoriamente, cadastrar seu buffet logo após criar sua conta. Assim que a conta for criada com sucesso, a aplicação deve redirecionar para a tela de cadastro do buffet. Mesmo que o usuário tente acessar outras rotas, a aplicação deve sempre validar se é um login de dono de buffet que ainda não cadastrou seu buffet. Em caso afirmativo, a aplicação deve levar o usuário de volta para a tela de cadastro. A única rota que deve ser habilitada é a função de sair (sign out).


#### Objetivos da Tarefa

- [x] Após fazer o cadastrado de usuário dono de buffet com sucesso, a aplicação deve redirecionar para a tela de cadastro do buffet.

- [x] Criar tela para cadastrar seu buffet informando: 
  - nome fantasia
  - razão social
  - CNPJ
  - telefone para contato
  - e-mail para contato
  - endereço
  - bairro
  - estado
  - cidade
  - CEP
  - descrição de seu buffet 
  - meios de pagamentos aceitos

- Criar as validações:

  - [X] O usuário dono de buffet deve ser o único capaz de editar os dados de seu próprio buffet.

  - [x] O usuário não deve ser possível excluir um buffet.
  
  - [x] Cada usuário deve possuir somente um buffet cadastrado e o buffet deve estar diretamente vinculado ao usuário.

  - [x] Mesmo que o usuário tente acessar outras rotas, a aplicação deve sempre validar se é um login de dono de buffet que ainda não cadastrou seu buffet.

  - [x] Um usuário dono de buffet deve, obrigatoriamente, cadastrar seu buffet logo após criar sua conta. Mesmo que o usuário tente acessar outras rotas, a aplicação deve sempre validar se é um login de dono de buffet que ainda não cadastrou seu buffet.
  
  - [x] Em caso afirmativo, a aplicação deve levar o usuário de volta para a tela de cadastro. 
  
  - [x] A única rota que deve ser habilitada é a função de sair (sign out).



#### Solução


```
describe 'Usuario visita tela inicial' do
  context 'como dono de buffet' do
    it 'e faz a inscrição e depois vê o cadastro de bufet' do 
    end
    it 'e faz a inscrição e depois faz o cadastro de bufet com sucesso' do 
    end
    it 'e faz a inscrição e depois faz o cadastro de bufet faltando dados' do 
    end
    it 'e faz o login com sucesso' do 
    end
    it 'e faz o login sem cadastra o bufet e depois faz o login novamente e vê a tela de cadastro' do 
    end
    it 'e faz o login e editar seu buffet' do 
    end
    it 'e faz o login e editar outro buffet' do 
    end
  end
end

```

### 3 - Tarefa 3: Adicionar tipos de eventos

Um buffet pode oferecer diferentes tipos de eventos: festas de 15 anos, festas de casamento, serviço de buffet para conferências e congressos, festas corporativas etc. Cada dono de buffet deverá cadastrar os tipos de evento que realiza. Para cada tipo de evento deve informar: nome, descrição, quantidade mínima e máxima de pessoas que podem ser atendidas e a duração padrão do evento em minutos. Cada tipo de evento deve possuir também um texto que indica o cardápio para o evento. Deve ser informado se o evento possui opção de: bebidas alcoólicas, decoração e serviço de estacionamento ou valet.

Para cada tipo de evento, o dono do buffet precisa indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou se pode ser feito em um endereço indicado pelo contratante.

Ao cadastrar os tipos de evento de seu buffet, não faz sentido que o usuário atual precise indicar que o tipo de evento pertence ao seu buffet através do formulário. Faça com que este vínculo seja feito automaticamente dentro de seu código. Garanta que um tipo de evento não pode ser vinculado a qualquer buffet de usuário diferente do autenticado no momento do cadastro.


#### Objetivos da Tarefa

- [X] Um buffet pode oferecer diferentes tipos de eventos: 
  - festas de 15 anos
  - festas de casamento
  - serviço de buffet para conferências e congressos
  - festas corporativas
  - etc.

- [X] Cada dono de buffet deverá cadastrar os tipos de evento que realiza.

- [X] Para cada tipo de evento deve informar: 
  - nome
  - descrição
  - quantidade mínima de pessoas que podem ser atendidas 
  - quantidade máxima de pessoas que podem ser atendidas
  - duração padrão do evento em minutos

- [X] Cada tipo de evento deve possuir também um texto que indica o cardápio para o evento. 

- [X] Deve ser informado se o evento possui opção de: 
  - bebidas alcoólicas
  - decoração
  - serviço de estacionamento ou  valet

- [X] Para cada tipo de evento, o dono do buffet precisa indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou se pode ser feito em um endereço indicado pelo contratante.

- [X] Ao cadastrar os tipos de evento de seu buffet, não faz sentido que o usuário atual precise indicar que o tipo de evento pertence ao seu buffet através do formulário. 

- [X] Faça com que este vínculo seja feito automaticamente dentro de seu código. Garanta que um tipo de evento não pode ser vinculado a qualquer buffet de usuário diferente do autenticado no momento do cadastro.


#### Solução


```
describe 'Usuario dono de buffet' do
  context 'acessar seu buffet' do
    it 'e acessar a tela para cadastra um evento' do
    end
    it 'e cadastra um evento com sucesso' do
    end
    it 'e tenta cadastra um evento faltando dados'  do
    end
    it 'e tenta cadastra um evento que já existe'  do
    end
    it 'e vê a sua lista de eventos' do
    end
    it 'e acessar os detalhes de um evento' do
    end
    it 'e editar um evento' do
    end
  end
end


```

### 4 - Tarefa 4: Preços por evento

Um usuário autenticado como dono de um buffet pode, para cada tipo de evento, definir os preços-base daquele tipo de evento. Cada preço-base deve conter o valor mínimo (que está ligado com a quantidade mínima de pessoas) e deve haver um valor adicional por pessoa. Lembre-se que os valores aqui não são necessariamente lineares. Por exemplo: uma festa infantil com mínimo de 20 pessoas pode ter o preço-base de R\$ 2.000,00, mas o valor adicional por pessoa pode ser de R\$ 70,00.

Pode ser cadastrado também o valor por hora extra do evento, caso o evento extrapole a duração-padrão.

Os preços por tipo de evento podem ser diferenciados caso a festa seja realizada durante os dias da semana ou durante o fim de semana, então deve ser possível cadastrar, para cada tipo de evento, duas configurações diferentes de preço. 

Por exemplo:

De segunda a sexta-feira, uma festa de casamento pode ter preço-base de R\$ 10.000,00 (para 30 convidados), a taxa adicional por pessoa é de R\$ 250,00 e a hora extra do evento é de R$ 1.000,00. Mas, aos fins de semana, a mesma festa tem o preço-base de R\$ 14.000,00, taxa adicional por pessoa de R\$ 300,00 e a hora extra de evento custa R\$ 1.500,00.


#### Objetivos da Tarefa

- [X] O usuário definir os preços-base daquele tipo de evento.

- [X] Cada preço-base deve conter o valor mínimo (que está ligado com a quantidade mínima de pessoas) e deve haver um valor adicional por pessoa.

- [X] Pode ser cadastrado também o valor por hora extra do evento, caso o evento extrapole a duração-padrão.

- [X] Deve ser possível cadastrar, para cada tipo de evento, duas configurações diferentes de preço. 
  - Um preço caso a festa seja realizada durante os dias da semana 
  - Outro preço durante o fim de semana



#### Solução


```
describe 'Usuario dono de buffet' do
  context 'acessar um evento' do
    it 'e vê a tela para cadastra o preço de um evento' do
    end
    it  'e cadastra o preço para evento com sucesso'  do
    end
    it  'e vê o preço de um evento'  do
    end
    it  'e vê a tela para editar o preço para evento'  do
    end
    it  'e editar o preço do evento com sucesso'  do
    end
  end
end

```


#### Objetivos da Tarefa

### 5 - Tarefa 5: Listagem de buffets

Um visitante, não autenticado, deve ser capaz de abrir a tela inicial da aplicação e ver todos os buffets cadastrados. Para cada buffet, deve ser exibido o nome, sua cidade e estado. Ao clicar no nome do buffet, o visitante é levado para uma página de detalhes contendo todas as informações cadastradas para o estabelecimento, exceto a razão social.

#### Objetivos da Tarefa

- [X] Um visitante, não autenticado, deve ser capaz de abrir a tela inicial da aplicação e ver todos os buffets cadastrados.

- [X] Na tela inicial, para cada buffet, deve ser exibido o nome, sua cidade e estado. 

- [X] Ao clicar no nome do buffet, o visitante é levado para uma página de detalhes contendo todas as informações cadastradas para o estabelecimento, exceto a razão social.


#### Solução

Complementavamos os testes da Tarefa 3 para os novos campos.


### 6 - Tarefa 6: Busca de buffets

Um visitante, não autenticado, deve ter acesso, a partir de qualquer tela da aplicação, a um campo de busca de buffets. O usuário deve poder buscar um buffet pelo seu nome fantasia, pela cidade ou pelos tipos de festas realizadas. A busca deve ser feita por um único campo de texto, cujo valor informado será utilizado para consultar o banco de dados.

A lista resultante da busca deve trazer os resultados sempre em ordem alfabética, considerando o nome fantasia. Ao clicar no nome do buffet, o visitante deve ser direcionado para a tela de detalhes de um buffet descrita na tarefa anterior.

#### Objetivos da Tarefa

- [X] Um visitante, não autenticado, deve ter acesso, a partir de qualquer tela da aplicação, a um campo de busca de buffets. 

- [X] A busca deve ser feita por um único campo de texto, cujo valor informado será utilizado para consultar o banco de dados.

- [X] O usuário deve poder buscar um buffet pelo seu nome fantasia, pela cidade ou pelos tipos de festas realizadas. 

- [X] A lista resultante da busca deve trazer os resultados sempre em ordem alfabética, considerando o nome fantasia.

- [X] Ao clicar no nome do buffet, o visitante deve ser direcionado para a tela de detalhes de um buffet descrita na tarefa anterior.


#### Solução


```
describe 'Usuario visitante' do
  context 'visita tela inicial' do
    it 'e vê o campo de busca' do
    end
    it 'e faz uma busca por evento' do
    end
    it 'e faz uma busca por Buffet' do
    end
    it 'e faz uma busca por cidade' do
    end
  end
end

```



### 7 - Tarefa 7: Visitante vê tipos de eventos

Um visitante, não autenticado, deve ser capaz de ver todos os tipos de festas disponíveis para um buffet. Dentro da tela de detalhes de um buffet devem ser listados todos os tipos de eventos que o buffet oferece. Para cada tipo de evento devem ser exibidas todas as informações cadastradas, inclusive os preços.

#### Objetivos da Tarefa

- [X] Dentro da tela de detalhes de um buffet devem ser listados todos os tipos de eventos que o buffet oferece.

- [X] Um visitante, não autenticado, deve ser capaz de ver todos os tipos de festas disponíveis para um buffet.

- [X] Para cada tipo de evento devem ser exibidas todas as informações cadastradas,

- [X] inclusive os preços.


#### Solução


```
describe 'Usuario visitante' do
  context 'visita tela detalhes de um buffet' do
    it 'e vê a lista de todos os tipos de eventos que o buffet oferece' do 
    end

    it 'e vê os detalhes de um evento de um Buffet' do 
    end
  end
end

```

### 8 - Tarefa 8: Visitante cria uma conta

Um visitante deve ser capaz de criar uma conta informando seu nome, CPF, e-mail e senha. O CPF deve ser único e válido. A conta de um visitante não deve ser capaz de administrar nenhuma informação referente aos buffets. A partir de agora, vamos nos referir aos visitantes cadastrados como clientes.

#### Objetivos da Tarefa

- [X] Um visitante deve ser capaz de criar uma conta informando seu nome, CPF, e-mail e senha. 

- [x] O CPF deve ser único e válido.

- [X] A conta de um visitante não deve ser capaz de administrar nenhuma informação referente aos buffets.

- [X] A partir de agora, vamos nos referir aos visitantes cadastrados como clientes.

#### Solução

Para a validação é do cpf do cliente e o CNPJ do dono do Buffet é feita usando a [gem 'cpf_cnpj'](https://github.com/fnando/cpf_cnpj)

```

describe 'Usuario visita tela inicial' do
  context 'como visitante' do
    it 'e vê a página de inscrição para um Cliente'  do
    end
    it 'e faz a inscrição com sucesso como um Cliente' do
    end
    it 'e após fazer a inscrição, o Cliente faz o cadastro do perfil com sucesso' do
    end
    it 'e após fazer a inscrição, o Cliente faz o cadastro do perfil com Nome e CPF invalidos' do
    end
  end

  context 'e faz login como cliente' do
    it 'e depois sai' do
    end
    it 'sem ter um perfil cadastrado e vê o formulario do perfil' do
    end
    it 'e não vê links para edição para de buffet e de criação de eventos' do
    end
    it 'e não vê links para edição para de buffet e de criação de eventos' do
    end
  end
end
```

### 9 - Tarefa 9: Cliente faz um pedido

Um cliente pode fazer um pedido para um buffet. Todos os pedidos serão avaliados pelo dono do buffet antes de se confirmar a execução do evento.

Um novo pedido deve conter: o buffet, o tipo de evento escolhido, a data desejada, a quantidade estimada de convidados e um campo para informar mais detalhes sobre o evento. Cada pedido deve possuir também um código alfanumérico de 8 caracteres gerado automaticamente. Caso o tipo de evento escolhido tenha a opção de realizar em um endereço diferente do endereço do buffet, o cliente deve informar também o endereço desejado para o evento.

Pedidos recém-cadastrados são criados com o status "Aguardando avaliação do buffet". Os outros status possíveis são: pedido confirmado e pedido cancelado.

O cliente deve ter acesso a uma tela "Meus Pedidos" onde é possível acompanhar todos os seus pedidos realizados. Esta tela deve ser uma listagem com a data do evento e seu código. Ao clicar no código, é exibida uma tela com todos os detalhes do pedido.


#### Objetivos da Tarefa

- [X] Um cliente pode fazer um pedido para um buffet.
- [X] Todos os pedidos serão avaliados pelo dono do buffet antes de se confirmar a execução do evento.
- [X] Um novo pedido deve conter: 
  - o buffet
  - o tipo de evento escolhido
  - a data desejada
  - a quantidade estimada de convidados
  - um campo para informar mais detalhes sobre o evento
  - um código alfanumérico de 8 caracteres gerado automaticamente
  - endereço desejado para o evento

- [X] Caso o tipo de evento escolhido tenha a opção de realizar em um endereço diferente do endereço do buffet, o cliente deve informar também o endereço desejado para o evento.

- [X] Pedidos recém-cadastrados são criados com o status "Aguardando avaliação do buffet". 

- [X] Os outros status possíveis são: "Pedido confirmado" e "Pedido cancelado."

- [X] O cliente deve ter acesso a uma tela "Meus Pedidos" onde é possível acompanhar todos os seus pedidos realizados. 
  - [X] Esta tela deve ser uma listagem com a data do evento e seu código. 
  - [X] Ao clicar no código, é exibida uma tela com todos os detalhes do pedido.


#### Solução

```
describe 'Um cliente visita tela inicial' do
  context 'acessar um evento de um Buffet' do
    it 'e vê o botão para fazer um pedido' do 
    end
    it 'e vê um formulario para fazer o pedido' do 
    end
    it 'e faz um pedido com sucesso' do 
    end
    it 'e faz um pedido com a data no passado' do
    end
  end

  context 'acessar seus eventos' do
    it 'e vê a lista de todos os seus pedidos' do
    end
    it 'e vê os detalhes de um pedido' do
    end
  end
```


### 10 - Tarefa 10: Dono de buffet avalia pedido

Um dono de buffet, autenticado na app, deve ter acesso a uma tela chamada "Pedidos" onde são exibidos todos os pedidos realizados para seu buffet. Os pedidos "Aguardando avaliação" devem ser exibidos de forma separada dentro desta tela, antes dos demais pedidos. 

O dono de buffet pode acessar estes pedidos e avaliar as informações cadastradas pelo cliente antes de decidir se vai aceitar o pedido ou não.

Ao visualizar a tela de detalhes de um pedido, o sistema deve notificar o dono de um buffet caso exista outro pedido para o mesmo dia.

#### Objetivos da Tarefa

- [X] Um dono de buffet, autenticado na app, deve ter acesso a uma tela chamada "Pedidos" onde são exibidos todos os pedidos realizados para seu buffet. 

- [X] Os pedidos "Aguardando avaliação" devem ser exibidos de forma separada dentro desta tela, antes dos demais pedidos.

- [X] O dono de buffet pode acessar estes pedidos e avaliar as informações cadastradas pelo cliente antes de decidir se vai aceitar o pedido ou não.

- [X] Ao visualizar a tela de detalhes de um pedido, o sistema deve notificar o dono de um buffet caso exista outro pedido para o mesmo dia.


#### Solução

 
```
describe 'Um cliente visita tela inicial' do
  context 'acessar um evento de um Buffet' do
    it 'e vê o botão para fazer um pedido' do
    end
    it 'e vê um formulario para fazer o pedido' do
    end
    it 'e faz um pedido com sucesso' do
    end
    it 'e faz um pedido com a data no passado' do
    end 
  end

  context 'acessar seus eventos' do
    it 'e vê a lista de todos os seus pedidos' do
    end
    it 'e vê os detalhes de um pedido' do
    end
  end
end
```
### 11 - Tarefa 11: Dono de buffet aprova pedido

Caso o dono do buffet considere estar tudo ok, ele deve aprovar o pedido. Para aprovar o pedido, o dono do buffet deve registrar na app o valor final do pedido e data de validade daquele valor. Para calcular o valor final, a aplicação deve calcular automaticamente o valor-padrão a partir da data solicitada para o evento, da quantidade de convidados e do tipo de evento.

Além do valor calculado automaticamente, o dono do buffet poderá acrescentar uma taxa extra ou conceder um desconto. Deve ser cadastrada uma descrição que explique o valor extra ou o desconto.

O dono do buffet deve registrar também o meio de pagamento que será utilizado.

#### Objetivos da Tarefa

- [X] Caso o dono do buffet considere estar tudo ok, ele deve aprovar o pedido. Para aprovar o pedido, o dono do buffet deve registrar na app o valor final do pedido e data de validade daquele valor. 

- [X] Para calcular o valor final, a aplicação deve calcular automaticamente o valor-padrão a partir da data solicitada para o evento, da quantidade de convidados e do tipo de evento.

- [X] Além do valor calculado automaticamente, o dono do buffet poderá acrescentar uma taxa extra ou conceder um desconto.

- [X] Deve ser cadastrada uma descrição que explique o valor extra ou o desconto.

- [X] O dono do buffet deve registrar também o meio de pagamento que será utilizado.

#### Solução

 
```

describe 'Um Dono de Buffet visita a tela inicial' do
  it 'e vê o botão de Pedidos' do
  end
  it 'e acessar a pagina de Pedidos' do
  end
  it 'e vê notificação de mais de um Pedido no mesmo dia na pagina de detalhes do pedido' do
  end
end

describe 'Um Dono de Buffet visita a tela inicial' do
  context  'acessar os detalhes de um pedido a partir pagina de Pedidos' do
    it 'e vê os campos de de desconto/taxa e descrição' do
    end
    it 'e e confirma o pedido com sucesso' do
    end
    it 'e e confirma o pedido faltando informações' do
    end
  end
end
```

### 12 - Tarefa 12: Cliente confirma pedido

Pedidos aprovados pelo buffet devem ser confirmados pelo cliente em seguida. O cliente autenticado deve acessar o pedido através do menu "Meus Pedidos" e ver que o pedido está aguardando sua confirmação. Deve ser exibida também a data-limite para confirmação do pedido.

Caso a data atual ainda seja anterior à data-limite, o cliente pode confirmar o pedido. Pedidos confirmados indicam que o evento será realizado. 

#### Objetivos da Tarefa

- [X] Pedidos aprovados pelo buffet devem ser confirmados pelo cliente em seguida.

- [X] O cliente autenticado deve acessar o pedido através do menu "Meus Pedidos" e ver que o pedido está aguardando sua confirmação. 
  - [X] Deve ser exibida também a data-limite para confirmação do pedido.

- [X] Caso a data atual ainda seja anterior à data-limite, o cliente pode confirmar o pedido. Pedidos confirmados indicam que o evento será realizado. 


#### Solução


```
describe 'Um cliente visita tela inicial' do
  context 'acessar Seus Pedidos' do
    it 'e vê os detalhes de um pedido que aguardar sua Confirmação' do
    end
    it 'e Confirma seu pedido com sucesso' do
    end
    it 'e tenta Confirma um pedido fora da data limite' do
    end
    it 'e cancelar um pedido que aguardar sua Confirmação' do
    end
  end
end

describe 'Um Visitante visita a tela inicial' do
  it 'e tenta vê os pedidos dos clientes' do
  end
end
```


### 13 - Tarefa 13: API de buffets

A Cadê Buffet? está avaliando a criação de outras aplicações integradas ao sistema de gestão de buffets e reservas, para isto, precisamos começar a construir uma API acessível via requisições HTTP e com retornos em formato JSON. Toda API deve ser documentada e, abaixo, segue uma relação dos endpoints esperados neste momento:

- Listagem de buffets: fornece uma listagem completa de buffets cadastrados na plataforma. Deve haver uma opção de informar um texto e usar como filtro de busca pelo nome do buffet.

- Listagem de tipos de eventos de um buffet: a partir do ID de um buffet, fornece uma lista com informações sobre os tipos de eventos disponíveis no buffet.
  
- Detalhes de um buffet: a partir do ID de um buffet, fornece todos os detalhes do buffet exceto CNPJ e razão social.
  
- Consulta de disponibilidade: informando um ID de um tipo de evento, a data do evento e a quantidade de convidados, deve ser possível verificar a disponibilidade para realizar um evento. Em caso positivo, deve ser retornado o valor prévio do pedido, em caso negativo, deve haver uma mensagem de erro no corpo da resposta.


#### Objetivos da Tarefa

- Criar os endpoints para:
  - [X] Fornece uma listagem completa de buffets cadastrados na plataforma. 
    - [X] Deve haver uma opção de informar um texto e usar como filtro de busca pelo nome do buffet.

  - [X] A partir do ID de um buffet, fornece uma lista com informações sobre os tipos de eventos disponíveis no buffet.
  - [X] A partir do ID de um buffet, fornece todos os detalhes do buffet exceto CNPJ e razão social.
  - [X] Informando um ID de um evento, a data do evento e a quantidade de convidados, deve ser possível verificar a disponibilidade para realizar um evento. 
    - [X] Em caso positivo, deve ser retornado o valor prévio do pedido
    - [X] Em caso negativo, deve haver uma mensagem de erro no corpo da resposta.

- [X] Documenta a API 


#### Solução


```
describe 'Cadê o Buffet API' do
  context 'GET /api/v1/buffets/:id -  A partir do ID de um buffet, 
           fornece todos os detalhes do buffet exceto CNPJ e razão social' do
    it 'fornece todos os detalhes do buffet com sucesso' do
    end
    it 'falha se não encontra o buffet' do
    end
  end

  context 'GET /api/v1/buffets/ -  Fornece uma 
           listagem completa de buffets cadastrados na plataforma. ' do
    it 'lista os buffets em ordem alfabetica' do 
    end
    it 'retornar vazio se não houver buffet' do 
    end
    it 'GET /api/v1/buffets/search?query=:brand_name - 
        retornar a busca pelo nome de um buffet' do
    end
  end

  context 'GET /api/v1/buffets/:id/events - A partir do ID de um buffet, 
            fornece uma lista com informações sobre os tipos de eventos disponíveis no buffet.' do
    it 'lista dos eventos de um buffet' do
    end
  end

  context 'POST /api/v1/events/availability - Informando um ID de um evento, 
           a data do evento e a quantidade de convidados, deve ser possível 
           verificar a disponibilidade para realizar um evento. ' do
    it 'em caso de sucesso, deve ser retornado o valor prévio do pedido' do
    end
    it 'falha, se quantidade de convidados estiver faltando' do
    end
    it 'falha, se a quantidade de convidados for negativa' do
    end
    it 'falha, se quantidade de convidados for zero' do
    end
    it 'falha, se a data for no passado' do
    end
    it 'falha, data estiver faltando' do
    end
  end
end

```

## Autoanálise e Melhorias Futuras

Todas as Tarefas obrigadoras do Projeto Crash Course foram concluídas, mas no futuro, quanto tiver mais tempo, vou melhorar o projeto com:

 - Os recursos das Tarefas Bonus:
   - Fotos para tipos de eventos
   - Troca de mensagens
   - Desativar buffets e tipos de eventos 
   - Avaliar buffets
   - Promoções
   -  Multa por cancelamento
  - Melhorar a semântica do html das views
  - Fazer a estilização com Tailwind CSS
  - Completar o I18N nos textos views. Porque vários textos que não estão associados diretamente aos model ficaram sem a tradução.
  - Corrigir o bug do salvamento da forma de pagamento do pedido. Porque quando um pedido é salvo, a forma de pagamento fica registrada com o nome traduzido em português com I18N, mas o correto seria está em inglês, conforme os nomes dos atributos do model referente a forma de pagamento.
  - Criar testes unitários. (Nota: Foquei muito nos testes de sistema e esqueci de fazer os unitários, então alguns testes que poderiam melhor escritos como unitários, foram feitos como testes de sistema.)


## Agradecimentos

Gostaria de agradecer a Campus Code pelos ensinamentos no TreinaDev 12.
