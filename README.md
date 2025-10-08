# TechChallenge Infra Data

[Documentação completa do projeto](https://alealencarr.github.io/TechChallenge/)

Cria os serviços de dados: Azure SQL, e Azure Blob Storage.

### Descrição
Este repositório é responsável por provisionar toda a camada de persistência de dados da nossa aplicação. Ele cria os serviços gerenciados no Azure que serão usados para armazenar informações estruturadas (banco de dados relacional) e não estruturadas (ficheiros/imagens).

### Tecnologias Utilizadas
Terraform: Ferramenta de Infraestrutura como Código (IaC).

Azure Resources:

Azure SQL Database

Azure SQL Server

Azure Blob Storage

### Responsabilidades
Criar o Servidor SQL e a Base de Dados SQL (Hungry) que serão utilizados pela API principal e pela função de autenticação.

Criar a Conta de Armazenamento e o Contêiner de Blob (imagens) para guardar as imagens dos produtos e outros ficheiros.

### Dependências
TechChallenge-infra-foundational: Este repositório depende do Grupo de Recursos criado pela infraestrutura de base.

### Processo de CI/CD
O pipeline de CI/CD (.github/workflows/deploy-infra.yml) automatiza a gestão da infraestrutura:

Em Pull Requests: Executa terraform plan para validar as alterações e mostrar o impacto previsto.

Em Merges na main: Executa terraform apply para aplicar as alterações no Azure.
