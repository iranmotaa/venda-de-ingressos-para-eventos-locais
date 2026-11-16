# Venda de Ingressos para Eventos Locais

**Seminário Projeto Final – Engenharia de Software I**

## Tema
Tema 3 – Plataforma para organizadores de eventos da cidade (shows, festas, feiras) cadastrarem eventos e venderem ingressos on-line, com validação do ingresso por QR Code na portaria.

**Desafio de infraestrutura:** suportar o pico de acessos na abertura das vendas (escalabilidade e balanceamento de carga) e integrar com um serviço externo de pagamento.

## Integrantes
- Iran Mota da Silva

## Índice dos entregáveis

| # | Entregável | Arquivo |
|---|------------|---------|
| 1 | Modelo de processo (Cascata) | [docs/processo/Modelo.md](docs/processo/Modelo.md) |
| 2 | Requisitos funcionais | [docs/requisitos/RF.md](docs/requisitos/RF.md) |
| 2 | Requisitos não funcionais | [docs/requisitos/RNF.md](docs/requisitos/RNF.md) |
| 3 | Matriz de rastreabilidade | [docs/requisitos/Matriz.md](docs/requisitos/Matriz.md) |
| 4 | Diagrama de casos de uso | [diagramas/fontes/DiagramaCasosDeUso.md](diagramas/fontes/DiagramaCasosDeUso.md) |
| 5 | Lista e descrição dos casos de uso | [CasosDeUso.md](docs/casos-de-uso/CasosDeUso.md), [DescricaoCasosDeUso.md](docs/casos-de-uso/DescricaoCasosDeUso.md) |
| 6 | Diagrama de classes | [diagramas/fontes/DiagramaClasses.md](diagramas/fontes/DiagramaClasses.md) |
| 7 | Diagramas de sequência (UC-05 e UC-06) | [diagramas/fontes/DiagramasSequencia.md](diagramas/fontes/DiagramasSequencia.md) |
| 8 | Diagrama de implantação | [diagramas/fontes/DiagramaImplantacao.md](diagramas/fontes/DiagramaImplantacao.md) |
| 9 | Script SQL | [banco/init.sql](banco/init.sql) |
| 10 | Ambiente Docker | [docker-compose.yml](docker-compose.yml) |
| 11 | ADRs | [docs/adr/](docs/adr/) |
| 13 | Diagrama do esquema do banco (bônus) | [diagramas/fontes/DiagramaBanco.md](diagramas/fontes/DiagramaBanco.md) |

Os diagramas foram feitos em Mermaid: os arquivos-fonte (`.mmd`) ficam em [diagramas/fontes/](diagramas/fontes/) e as imagens exportadas (SVG e PNG) em [diagramas/img/](diagramas/img/).

## Como executar o ambiente

Requisitos: Docker e Docker Compose.

```bash
docker compose up -d  
docker compose ps     
docker compose down   
docker compose down -v
```

| Serviço | Função | Acesso |
|---------|--------|--------|
| `balanceador` | nginx que distribui as requisições entre as réplicas | http://localhost |
| `app1`, `app2` | réplicas da aplicação (**placeholders**, pois o código da aplicação ainda não existe) | via balanceador |
| `db` | PostgreSQL 16, com as tabelas criadas por `banco/init.sql` | `localhost:5432`, banco `ingressos`, usuário `ingressos`, senha `ingressos` |

Para ver o balanceamento, acesse `http://localhost` várias vezes: o campo `Hostname` alterna entre as duas réplicas.

Para conferir as tabelas:

```bash
docker compose exec db psql -U ingressos -c '\dt'
```
