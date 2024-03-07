# Sistema de Gerenciamento de Boletos Bancários

Este projeto é um sistema de gerenciamento de boletos bancários desenvolvido com Ruby on Rails utilizando a API de *Testes Sandbox* do [Kobana](https://developers.kobana.com.br/docs/comecando).

## Demonstração

Uma versão de demonstração deste projeto está hospedada gratuitamente em [https://gestao-boletos-kobana.onrender.com/](https://gestao-boletos-kobana.onrender.com/).

> **Observação:** Como a hospedagem é gratuita, a instância pode estar inativa e o primeiro acesso pode demorar um pouco para carregar.

## Funcionalidades do Sistema com testes
- **Visualização de Boletos**: Listagem de todos os boletos bancários cadastrados com opções de paginação.
- **Criação de Boletos**: Interface para criação de novos boletos bancários.
- **Edição de Boletos**: Opção para editar boletos bancários existentes.
- **Cancelamento de Boletos**: Funcionalidade para cancelar boletos bancários.
- **Pagamento de Boletos**: Funcionalidade de marcação de boletos como pagos diretamente pelo sistema.

## Requisitos

- Ruby 3.2.0
- Rails 7.1.3
- PostgreSQL
- Nodejs

## Configuração e Instalação

Para configurar e rodar este projeto localmente, siga os passos abaixo:

1. Clone o repositório para sua máquina local:

```bash
git clone https://github.com/thomasjteixeira/gestao_boletos_kobana
```
2. Navegue até o diretório do projeto:

```bash
cd gestao_boletos_kobana
```
3. Instale as dependências do projeto:

```bash
bundle install
yarn install
```
4. Crie e configure o banco de dados:

```bash
rails db:create db:migrate
```
5. Adicione o arquivo o .env na raiz do projeto com base no .sample.env

6. Faça o build do tailwind
```bash
rails tailwindcss:build
```
7. Inicie o servidor Rails:

```bash
rails server
```

Acesse http://localhost:3000 em seu navegador para visualizar o projeto.

## Executando os Testes

Este projeto utiliza RSpec para testes. Para executar todos os testes:

```bash
bundle exec rspec
```

## Principais Gems Utilizadas
- boletosimples: Integração com a API Boleto Simples para gerenciamento de boletos bancários.
- rspec-rails: Framework de testes para Rails.
- stimulus-rails, turbo-rails: Suporte para Hotwire (Stimulus + Turbo) no Ruby on Rails, permitindo uma interação mais dinâmica na aplicação web.
- factory_bot_rails: Facilita a criação de instâncias de objetos para testes.
- cpf_faker, faker: Geração de dados para testes.
- tailwindcss-rails e flowbite: Frameworks CSS para estilização rápida e responsiva.
