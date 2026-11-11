# Modelo de Processo: Cascata

## Por que Cascata?
- Os requisitos já estão definidos desde o início.
- As funcionalidades (eventos, venda, pagamento, QR Code) dependem umas das outras e precisam ser planejadas juntas.
- A arquitetura para o pico de acessos precisa ser decidida antes de construir.

## Fases seguidas

| Fase | O que foi feito | Resultado |
|------|-----------------|-----------|
| 1. Requisitos | Definição dos RF e RNF | `docs/requisitos/` |
| 2. Análise | Casos de uso e matriz de rastreabilidade | `docs/casos-de-uso/`, diagrama de casos de uso |
| 3. Projeto | Classes, sequência, implantação e ADRs | `diagramas/`, `docs/adr/` |
| 4. Implementação | Banco de dados e ambiente Docker | `banco/init.sql`, `docker-compose.yml` |
| 5. Verificação | Conferência da coerência e teste do ambiente | `docker compose up` testado |

Cada fase usa o resultado da anterior: requisitos → casos de uso → classes → sequência → implantação → banco.
