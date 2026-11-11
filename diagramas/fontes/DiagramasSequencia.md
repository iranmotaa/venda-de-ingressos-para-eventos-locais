# Diagramas de Sequência

Fluxos principais de **UC-05 – Comprar ingresso** e **UC-06 – Pagar ingresso** (ver [DescricaoCasosDeUso.md](../../docs/casos-de-uso/DescricaoCasosDeUso.md)).

## UC-05 – Comprar ingresso

```mermaid
sequenceDiagram
    actor Comprador
    participant Sistema
    participant Evento
    participant Pedido
    participant Ingresso

    Comprador->>Sistema: escolherEvento(evento, quantidade)
    Sistema->>Evento: reservarIngressos(quantidade)
    Evento-->>Sistema: reserva confirmada
    Sistema->>Pedido: criarPedido(comprador, evento, quantidade)
    Pedido-->>Sistema: pedido (status PENDENTE)
    Sistema-->>Comprador: resumo do pedido
    Comprador->>Sistema: confirmarPedido()
    Sistema->>Sistema: pagarIngresso(pedido) [UC-06]
    Sistema->>Ingresso: gerarIngressos(pedido) com QR Code
    Ingresso-->>Sistema: ingressos
    Sistema-->>Comprador: ingressos com QR Code
```

## UC-06 – Pagar ingresso

```mermaid
sequenceDiagram
    actor Comprador
    participant Sistema
    participant Gateway as Gateway de Pagamento
    participant Pagamento
    participant Pedido

    Sistema-->>Comprador: valor total e formas de pagamento
    Comprador->>Sistema: escolherFormaPagamento(forma)
    Sistema->>Gateway: cobrar(valor, pedido)
    Gateway-->>Comprador: solicita dados de pagamento
    Comprador->>Gateway: informarDadosPagamento()
    Gateway-->>Sistema: resultado (aprovado, idTransacao)
    Sistema->>Pagamento: registrar(idTransacao, status)
    Sistema->>Pedido: marcarComoPago()
    Sistema-->>Comprador: pagamento aprovado
```