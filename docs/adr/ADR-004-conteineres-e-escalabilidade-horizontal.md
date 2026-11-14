# ADR-004 – Contêineres Docker e escalabilidade horizontal

**Status:** Aceita

## Contexto
Na abertura das vendas, o número de acessos cresce de repente (RNF-001), e o sistema deve ficar disponível pelo menos 99,9% do ano (RNF-003). Fora desses picos, a demanda é baixa, e um servidor sobredimensionado seria desperdício.

## Decisão
- Empacotar os componentes em contêineres Docker, com o ambiente descrito em `docker-compose.yml`: um balanceador nginx (`infra/nginx.conf`), 2 réplicas da aplicação e o banco PostgreSQL.
- Manter a aplicação sem estado (stateless): sessões e dados ficam no banco, e não na memória do servidor.
- Colocar o balanceador de carga na frente das réplicas, que são acrescentadas quando houver pico (ver Diagrama de Implantação). No compose, as réplicas são aplicações de exemplo, pois o código ainda não existe.
- Manter o PostgreSQL em um nó separado, com volume persistente para os dados.

## Consequências
- **Positivas:** mais instâncias da aplicação podem ser criadas ou removidas conforme a demanda. Se uma instância cair, as outras continuam atendendo, o que ajuda a manter a disponibilidade. O ambiente é reproduzível em qualquer máquina.
- **Negativas:** o banco continua sendo ponto único de falha, a menos que se acrescente réplica ou backup. A configuração tem mais componentes para manter.
- **RNF atendidos:** RNF-001 e RNF-003. A consistência com várias réplicas depende da ADR-002.
