# Projeto Crash Course - Cadê Buffet?

O projeto **Cadê Buffet?** visa oferecer uma solução abrangente para a busca e contratação de serviços de buffet, proporcionando uma experiência simplificada e eficiente para os usuários.

Este projeto é uma plataforma onde donos de buffets podem cadastrar suas empresas e serviços, enquanto os usuários regulares podem encontrar e solicitar os serviços de buffet de acordo com suas preferências.

## Principais Funcionalidades:

- **Cadastro de Buffets:** Donos de buffets podem: 
  - cadastrar suas empresas
  - listar os serviços oferecidos
  - cadastrar cardápios e seus respectivos valores
  - receber contatos de pessoas interessadas em realizar uma festa
  
- **Busca de Buffets:** Usuários regulares podem:
  - buscar buffets de acordo com: 
    - o tipo de evento
    - quantidade de convidados
    - localização
  - fazer um pedido
  - fazer avaliações (caso a festa seja realizada)
 
## Criação do Projeto

### 0 - Setup da aplicação

Criando o projeto Rails


```rails new buffet-app --minimal --skip-test```
  
Configurando o Bundle 

Adicionamos as gens "rspec-rails" e "capybara"  em group :development no Gemfile, e adicionamos a "devise" fora dos groups e executamos:

```
bundle install
rails generate rspec:install
```

Configurando o rspec para testes do tipo system e o navegado (rack_test) usado para os testes. No arquivo rails_helper.rb adicionamos em RSpec.configure:

``` 
config.before(type: :system) do
  driven_by(:rack_test)
end
```

Para o devise, executamos `rails generate devise:install`

E em config/environments/development.rb adicionamos ```config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }```

E em config/application.rb removemos o comentario de ```require "action_mailer/railtie"```

Adicionamos a rota `root to 'home#index'` em routes com uma view em app/views/home/index.html.erb com "Ola mundo". Também criamos o controller home_controller.rb com a action index.


Em app/views/layouts/application.html.erb, adicionamos as flash mensagens

```
<div>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
</div>
```


Git do Setup

Criando o Projeto no GitHub


```
git init
git add .
git commit -m "Criação e Setup do projeto"
git branch -M main
git remote add origin git@github.com:Mariano17omega/buffet-app.git
git push -u origin main
```
```

```

## 1 - Tarefa 1: Criar conta como dono de buffet

Um usuário pode criar sua conta como dono de um buffet informando seu e-mail e uma senha. No futuro, teremos também usuários do tipo cliente que vão precisar criar sua conta para contratar um buffet. Esta sprint é focada no usuário dono de buffet, mas estamos antecipando esta informação para seu planejamento.

### Objetivos da Tarefa

- [x]  Criar uma tela incial com dois botões para o usuário dizer se ele é um dono de buffet ou um cliente.

- [x] Se o usuário for um dono de buffet, ele deve ser direcionado para uma tela de login com um formulario com e-mail e senha. 

- [x] Depois criamos uma tela para o caso do usuário for um usuário cliente.

  
#### Solução 

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







## 2 - Tarefa 2: Cadastrar buffet

Com sua conta criada, o usuário deve, obrigatoriamente, cadastrar seu buffet informando: nome fantasia, razão social, CNPJ, telefone para contato, e-mail para contato e endereço completo com endereço, bairro, estado, cidade e CEP. Além destes dados, o dono do buffet deve poder adicionar uma descrição de seu buffet e os meios de pagamentos aceitos.

O usuário dono de buffet deve ser o único capaz de editar os dados de seu próprio buffet. Não deve ser possível excluir um buffet.

Cada usuário deve possuir somente um buffet cadastrado e o buffet deve estar diretamente vinculado ao usuário.

Um usuário dono de buffet deve, obrigatoriamente, cadastrar seu buffet logo após criar sua conta. Assim que a conta for criada com sucesso, a aplicação deve redirecionar para a tela de cadastro do buffet. Mesmo que o usuário tente acessar outras rotas, a aplicação deve sempre validar se é um login de dono de buffet que ainda não cadastrou seu buffet. Em caso afirmativo, a aplicação deve levar o usuário de volta para a tela de cadastro. A única rota que deve ser habilitada é a função de sair (sign out).


### Objetivos da Tarefa

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



### Solução


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



## 3 - Tarefa 3: Adicionar tipos de eventos

Um buffet pode oferecer diferentes tipos de eventos: festas de 15 anos, festas de casamento, serviço de buffet para conferências e congressos, festas corporativas etc. Cada dono de buffet deverá cadastrar os tipos de evento que realiza. Para cada tipo de evento deve informar: nome, descrição, quantidade mínima e máxima de pessoas que podem ser atendidas e a duração padrão do evento em minutos. Cada tipo de evento deve possuir também um texto que indica o cardápio para o evento. Deve ser informado se o evento possui opção de: bebidas alcoólicas, decoração e serviço de estacionamento ou valet.

Para cada tipo de evento, o dono do buffet precisa indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou se pode ser feito em um endereço indicado pelo contratante.

Ao cadastrar os tipos de evento de seu buffet, não faz sentido que o usuário atual precise indicar que o tipo de evento pertence ao seu buffet através do formulário. Faça com que este vínculo seja feito automaticamente dentro de seu código. Garanta que um tipo de evento não pode ser vinculado a qualquer buffet de usuário diferente do autenticado no momento do cadastro.


### Objetivos da Tarefa

- Um buffet pode oferecer diferentes tipos de eventos: 
  - festas de 15 anos
  - festas de casamento
  - serviço de buffet para conferências e congressos
  - festas corporativas
  - etc.

- Cada dono de buffet deverá cadastrar os tipos de evento que realiza.

- Para cada tipo de evento deve informar: 
  - nome
  - descrição
  - quantidade mínima de pessoas que podem ser atendidas 
  - quantidade máxima de pessoas que podem ser atendidas
  - duração padrão do evento em minutos


- Cada tipo de evento deve possuir também um texto que indica o cardápio para o evento. 

- Deve ser informado se o evento possui opção de: 
  - bebidas alcoólicas
  - decoração
  - serviço de estacionamento ou  valet

- Para cada tipo de evento, o dono do buffet precisa indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou se pode ser feito em um endereço indicado pelo contratante.

- Ao cadastrar os tipos de evento de seu buffet, não faz sentido que o usuário atual precise indicar que o tipo de evento pertence ao seu buffet através do formulário. 

- Faça com que este vínculo seja feito automaticamente dentro de seu código. Garanta que um tipo de evento não pode ser vinculado a qualquer buffet de usuário diferente do autenticado no momento do cadastro.




## 4 - Tarefa 4: Preços por evento

Um usuário autenticado como dono de um buffet pode, para cada tipo de evento, definir os preços-base daquele tipo de evento. Cada preço-base deve conter o valor mínimo (que está ligado com a quantidade mínima de pessoas) e deve haver um valor adicional por pessoa. Lembre-se que os valores aqui não são necessariamente lineares. Por exemplo: uma festa infantil com mínimo de 20 pessoas pode ter o preço-base de R$ 2.000,00, mas o valor adicional por pessoa pode ser de R$ 70,00.

Pode ser cadastrado também o valor por hora extra do evento, caso o evento extrapole a duração-padrão.

Os preços por tipo de evento podem ser diferenciados caso a festa seja realizada durante os dias da semana ou durante o fim de semana, então deve ser possível cadastrar, para cada tipo de evento, duas configurações diferentes de preço. 

Por exemplo:

De segunda a sexta-feira, uma festa de casamento pode ter preço-base de R$ 10.000,00 (para 30 convidados), a taxa adicional por pessoa é de R$ 250,00 e a hora extra do evento é de R$ 1.000,00. Mas, aos fins de semana, a mesma festa tem o preço-base de R$ 14.000,00, taxa adicional por pessoa de R$ 300,00 e a hora extra de evento custa R$ 1.500,00.

 