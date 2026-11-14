# ADR-001 – Banco de dados relacional (PostgreSQL)

## Contexto
O sistema guarda dados fortemente relacionados (usuários, eventos, pedidos, ingressos e pagamentos). Uma venda precisa alterar vários desses dados de uma só vez, e os dados não podem ficar inconsistentes (RNF-004).

## Decisão
Usar o PostgreSQL como banco relacional, executado em um container Docker (`docker-compose.yml`). O esquema fica em `banco/init.sql`, com chaves estrangeiras e restrições `CHECK`.

## Consequências
- **Positivas:** transações garantem que o pedido, o estoque e os ingressos sejam gravados juntos ou não sejam gravados. As restrições impedem dados inválidos, como estoque negativo. O container deixa o ambiente igual para toda a equipe.
- **Negativas:** o escalonamento do banco é mais difícil que o da aplicação. No volume esperado para eventos locais isso é aceitável, e a replicação de leitura pode ser usada se necessário.
- **RNF atendidos:** RNF-004.
