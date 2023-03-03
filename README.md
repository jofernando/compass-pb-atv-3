# Documentação da atividade sobre Docker

José Fernando Mendes da Costa

## Sumário

1. [Criando um gateway da internet](https://github.com/jofernando/compass-pb-atv-3/#criando-um-gateway-da-internet)
1. [Alterando sua VPC](https://github.com/jofernando/compass-pb-atv-3/#alterando-sua-vpc)
1. [Criando um Grupo de Segurança para o Balanceador de Carga](https://github.com/jofernando/compass-pb-atv-3/#criando-um-grupo-de-segurança-para-o-balanceador-de-carga)
1. [Alterando seu Grupo de Segurança default](https://github.com/jofernando/compass-pb-atv-3/#alterando-seu-grupo-de-segurança-default)
1. [Criando um Grupo de Destino](https://github.com/jofernando/compass-pb-atv-3/#criando-um-grupo-de-destino)
1. [Criando um Balanceador de Carga](https://github.com/jofernando/compass-pb-atv-3/#criando-um-balanceador-de-carga)
1. [Criando sua instância](https://github.com/jofernando/compass-pb-atv-3/#criando-sua-instância)

### Criando um gateway da internet
Como criar um gateway da internet usando o Console de gerenciamento da AWS
1. Abra o console da Amazon VPC em https://console.aws.amazon.com/vpc/ (realize o login se não estiver logado).
2. No painel de navegação, clique em `Gateways da internet`.
3. Clique em `Criar gateway da internet`.
4. No campo nome informe um nome descritivo.
5. Clique em `Criar gateway da internet`.

### Alterando sua VPC
Como alterar sua VPC usando o Console de gerenciamento da AWS
1. Abra o console da Amazon VPC em https://console.aws.amazon.com/vpc/ (realize o login se não estiver logado).
2. No painel de navegação, clique em `Tabela de rotas`.
3. Selecione a tabela de rotas associada a Sub-rede privada A.
4. Clique em `Ações` e `Editar rotas`:
1. Adicione a seguinte entrada na tabela de rotas, em `Destino`: `0.0.0.0/0` e em `Alvo` coloque o internet gateway criado anteriormente.
1. Clique em `Salvar alterações`.

### Criando um Grupo de Segurança para o Balanceador de Carga
Como criar um Grupo de Segurança usando o Console de gerenciamento da AWS
1. Faça login no AWS Management Console e abra o console do Amazon EC2 em https://console.aws.amazon.com/ec2/.
2. No painel de navegação, selecione `Grupos de segurança`.
3. Clique em `Criar Grupo de Segurança`.
4. Informe o nome e a descrição do Grupo de Segurança.
5. Em `VPC` Selecione a VPC existente.
6. Nas regras de entrada, adicine as seguintes regras:


| Name | ID da regra do Grupo de Segurança | Versão do IP | Tipo | Protocolo | Intervalo de portas | Origem | Descrição          |
|------|-----------------------------------|--------------|------|-----------|---------------------|--------|--------------------|
| | | IPv4         | HTTP              | TCP       | 80                  | 0.0.0.0/0      | Permite conexao com protocolo HTTP   |


### Alterando seu Grupo de Segurança
Como alterar seu Grupo de Segurança usando o Console de gerenciamento da AWS
1. Faça login no AWS Management Console e abra o console do Amazon EC2 em https://console.aws.amazon.com/ec2/.
2. No painel de navegação, selecione `Grupos de segurança`.
3. Selecione o Grupo de Segurança existente.
4. Clique em `Ações` e em `Editar regras de entrada`.
5. Em `VPC` selecione a VPC existente.
6. Nas regras de entrada, adicine as seguintes regras:


| Name | ID da regra do Grupo de Segurança | Versão do IP | Tipo | Protocolo | Intervalo de portas | Origem | Descrição          |
|------|-----------------------------------|--------------|------|-----------|---------------------|--------|--------------------|
| | | IPv4         | HTTP              | TCP       | 80                  | sg-0c9db7c4728c89542 / loadbalancer | Permite conexao com protocolo HTTP   |
| | | IPv4         | NFS               | TCP       | 2049                | sg-05d0804b79c900cdd / default      | Porta necessaria para utilizar o NFS |


7. Clique em `Salvar regras`.

### Criando um Grupo de Destino
1. Faça login no AWS Management Console e abra o console do Amazon EC2 em https://console.aws.amazon.com/ec2/.
2. No painel de navegação, selecione `Grupos de destino`.
3. Clique em `Criar grupo de destino`.
4. Em `Escolha um tipo de destino` selecione `Instâncias`.
4. Informe o nome em `Nome do grupo de destino`.
4. Selecione a VPC existente em `VPC`
4. Em `Configurações avançadas de verificação de integridade` no campo `Códigos de sucesso` informe `200,302`.
4. Clique em `Próximo`.
4. Clique em `Criar grupo de destino`.

### Criando um Balanceador de Carga
1. Faça login no AWS Management Console e abra o console do Amazon EC2 em https://console.aws.amazon.com/ec2/.
2. No painel de navegação, selecione `Balanceador de Carga`.
3. Clique em `Criar Balanceador de Carga`.
4. Em `Application Load Balancer` clique em `Criar`.
5. Informe o nome no campo `Nome do load balancer`.
6. No `Esquema` selecione `Voltado para a Internet`.
7. Em `VPC` selecione a VPC existente.
8. Em `Mapeamentos` selecione a zona de disponibilidade `us-east-1a (use1-az2)` e a sub-rede `aws-controltower-PrivateSubnet1A`
9. Em `Grupos de Segurança` selecione somente o Grupo de Segurança criado para o Balanceador de Carga.
10. Em `Listener HTTP:80` no campo `Ação padrão` selecione o Grupo de Destino criado.
11. Clique em `Criar Balanceador de Carga'.
### Criação da sua instância
Abra o console do Amazon EC2 em https://console.aws.amazon.com/ec2/.
1. No painel do console do EC2, clique em `Executar instância`.
2. Em `Nome e etiquetas`, em Name (Nome), insira um nome descritivo para a instância e adicione as seguintes tags para a instância e volume:

   Project: PB

   CostCenter: PBCompass
3. Em `Imagens de aplicação e de sistema operacional`, faça o seguinte:

    Escolha Início rápido e depois Amazon Linux. Este é o sistema operacional (SO) de sua instância.

4. Em `Tipo de instância`, escolha o tipo de instância t2.micro.
5. Em `Par de chaves (login)`, escolha o par de chaves criado anteriormente.
6. Ao lado `Configurações de rede`, escolha `Editar`.
  - Em `VPC` selecione a VPC existente.
  - Em `Sub-rede` selecione a sub-rede privada A.
  - Em `Firewall (grupos de segurança)` escolha `Selecionar um Grupo de Segurança existente` e escolha o Grupo de Segurança default.
7. Em `Configurar armazenamento` crie um disco GP2 de 8GB.
8. Copie o conteúdo do arquivo [user_data.sh](https://github.com/jofernando/compass-pb-atv-3/blob/main/user-data.sh), substitua o texto `DNS_LB` na linha 17 pelo DNS do LoadBalancer
9. Clique em `Detalhes avançados` e no campo `Dados do usuário` cole o conteúdo do passo anterior. Esse script vai executar depois da criação da instância e instalar o Docker, Docker Compose, montar o sistema de arquivos EFS e iniciar dois contêiners, do WordPress e MySQL.

Mantenha as seleções padrão para outras configurações de sua instância.

Revise um resumo da configuração da instância no painel `Resumo` e, quando você estiver pronto, escolha `Executar instância`.

Uma página de confirmação informa que sua instância está sendo executada. 

Pode levar alguns minutos até que a instância esteja pronta para sua conexão. Verifique se a instância foi aprovada nas verificações de status da coluna Status Checks (Verificações de status).

Depois vá no grupo de destino criado, clique em `Registrar destinos` selecione a instância criada clique em `Incluir como pendente abaixo` e clique em `Registrar destinos pendentes`.