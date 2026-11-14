# ADR-003 – Pagamento por Gateway externo

## Contexto
O sistema precisa cobrar os ingressos (RF-009), mas não deve armazenar dados de cartão (RNF-002). Guardar esses dados exigiria uma infraestrutura e controles de segurança complexos.

## Decisão
Delegar o pagamento a um Gateway de Pagamento externo. O comprador informa os dados de cartão diretamente ao Gateway, via HTTPS. O sistema envia a cobrança e recebe o resultado por resposta ou webhook. A tabela `pagamento` guarda apenas `id_transacao`, valor e status.

## Consequências
- **Positivas:** nenhum dado sensível de cartão passa pelo banco ou é guardado nele. O risco de segurança e o esforço de desenvolvimento diminuem.
- **Negativas:** o sistema depende da disponibilidade do Gateway. Se ele ficar fora do ar, o pedido permanece pendente (exceção E2 do UC-06). Há também a taxa cobrada pelo provedor.
- **RNF atendidos:** RNF-002.
