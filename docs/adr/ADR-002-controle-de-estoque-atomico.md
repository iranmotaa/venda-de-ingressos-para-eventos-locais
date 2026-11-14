# ADR-002 – Controle de estoque atômico na venda

## Contexto
O principal desafio do tema é a abertura das vendas: muitos compradores disputam os mesmos ingressos ao mesmo tempo. Sem controle, dois pedidos simultâneos poderiam vender mais ingressos do que o disponível (RNF-004).

## Decisão
Reservar o estoque dentro de uma transação do banco, com uma única atualização condicional:

```sql
UPDATE evento
SET quantidade_disponivel = quantidade_disponivel - :qtd
WHERE id = :evento AND quantidade_disponivel >= :qtd;
```

Se nenhuma linha for alterada, não há ingressos suficientes e a compra é recusada. Se o pagamento falhar ou a reserva expirar, o estoque é devolvido. A restrição `CHECK (quantidade_disponivel >= 0)` em `evento` é a última barreira.

## Consequências
- **Positivas:** a consistência fica garantida pelo banco, sem depender de quantas instâncias da aplicação estejam rodando. A solução é simples.
- **Negativas:** pedidos do mesmo evento ficam brevemente em fila na atualização da linha. É preciso devolver o estoque quando o pagamento falha (fluxos de exceção do UC-05).
- **RNF atendidos:** RNF-004, e apoia o RNF-001, pois a aplicação pode ser replicada sem risco de venda duplicada.
