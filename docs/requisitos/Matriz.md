## Matriz de Rastreabilidade

| Requisito | Descrição resumida | Casos de uso | Classes |
|-----------|--------------------------|--------------|---------|
| RF-001 | Cadastro de eventos | UC-01 | Usuario, Organizador, Evento, Categoria |
| RF-002 | Participação em eventos | UC-05 | Usuario, Evento, Ingresso, Pedido |
| RF-003 | Validação por QR Code | UC-07 | Ingresso, QRCode, ValidadorIngresso |
| RF-004 | Controle de vendas | UC-08 | Organizador, Evento, Pedido, Ingresso |
| RF-005 | Disponibilidade de ingressos | UC-04 | Evento, Ingresso |
| RF-006 | Busca e filtros | UC-03 | Evento, Categoria, BuscaEvento |
| RF-007 | Notificações | UC-09 | Notificacao, Usuario, Evento |
| RF-008 | Gerenciamento de eventos | UC-01, UC-02 | Organizador, Evento, Categoria |
| RF-009 | Pagamento de ingressos | UC-06 | Pagamento, Pedido, GatewayPagamento |
| RNF-001 | Escalabilidade | UC-03, UC-05 | Infraestrutura (balanceador de carga); Evento, Pedido |
| RNF-002 | Segurança | UC-06 | Pagamento, GatewayPagamento (sem dados de cartão) |
| RNF-003 | Disponibilidade | Todos | Infraestrutura (transversal) |
| RNF-004 | Concorrência | UC-05 | Pedido, Ingresso, Evento (controle de estoque) |
