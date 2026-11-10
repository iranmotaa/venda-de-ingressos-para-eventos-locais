# Descrição textual dos casos de uso principais

Casos descritos: UC-01, UC-05, UC-06 e UC-07.
**UC-05 (Comprar ingresso)** e **UC-06 (Pagar ingresso)** terão Diagrama de Sequência.

---

## UC-01 – Cadastrar evento

- **Atores:** Organizador
- **Pré-condições:** organizador autenticado.
- **RF relacionados:** RF-001, RF-008

**Fluxo principal**
1. O organizador escolhe "Cadastrar evento".
2. O sistema exibe o formulário.
3. O organizador informa nome, descrição, data, horário, local, categoria, valor e quantidade de ingressos, e confirma.
4. O sistema valida os dados, registra e publica o evento.
5. O sistema exibe a confirmação.

**Fluxos alternativos/exceção**
- **E1 – Dados inválidos ou ausentes (passo 4):** o sistema indica os erros e volta ao passo 3.

**Pós-condições:** evento publicado e disponível para busca e venda.

---

## UC-05 – Comprar ingresso *(Diagrama de Sequência)*

- **Atores:** Comprador; Gateway de Pagamento (via UC-06)
- **Pré-condições:** comprador autenticado; evento publicado com ingressos disponíveis.
- **RF relacionados:** RF-002, RF-003, RF-005, RF-009

**Fluxo principal**
1. O comprador escolhe um evento e informa a quantidade de ingressos.
2. O sistema verifica a disponibilidade e reserva os ingressos.
3. O sistema cria o pedido e mostra o resumo.
4. O comprador confirma.
5. O sistema executa **UC-06 – Pagar ingresso** («include»).
6. Com o pagamento aprovado, o sistema confirma o pedido e gera um QR Code para cada ingresso.
7. O sistema exibe os ingressos ao comprador.

**Fluxos alternativos/exceção**
- **E1 – Ingressos insuficientes (passo 2):** o sistema informa a quantidade disponível e volta ao passo 1.
- **E2 – Pagamento recusado (passo 5):** o sistema libera a reserva e informa o comprador.
- **A1 – Comprador cancela (passos 1 a 4):** o sistema libera a reserva e encerra.

**Pós-condições:** pedido pago, estoque reduzido e ingressos com QR Code emitidos.

---

## UC-06 – Pagar ingresso *(Diagrama de Sequência)*

- **Atores:** Comprador; Gateway de Pagamento
- **Pré-condições:** existe pedido pendente com ingressos reservados.
- **RF relacionados:** RF-009

**Fluxo principal**
1. O sistema mostra o valor total e as formas de pagamento.
2. O comprador escolhe a forma de pagamento.
3. O sistema envia a cobrança ao Gateway de Pagamento.
4. O comprador informa os dados de pagamento ao Gateway.
5. O Gateway retorna o resultado "aprovado".
6. O sistema registra o pagamento (id da transação e status) e marca o pedido como pago.

**Fluxos alternativos/exceção**
- **E1 – Pagamento recusado (passo 5):** o sistema registra a recusa e informa o comprador.
- **E2 – Gateway indisponível (passo 3):** o sistema informa a falha e mantém o pedido pendente.

**Pós-condições:** pagamento registrado sem dados de cartão (RNF-002).

---

## UC-07 – Validar ingresso (QR Code)

- **Atores:** Organizador (equipe de entrada)
- **Pré-condições:** organizador autenticado; ingresso emitido.
- **RF relacionados:** RF-003

**Fluxo principal**
1. O organizador lê o QR Code do ingresso.
2. O sistema verifica se o ingresso existe, é do evento e ainda não foi usado.
3. O sistema marca o ingresso como utilizado.
4. O sistema exibe "Ingresso válido".

**Fluxos alternativos/exceção**
- **E1 – Ingresso inválido ou já utilizado (passo 2):** o sistema exibe a mensagem correspondente e a entrada não é liberada.

**Pós-condições:** ingresso válido marcado como utilizado.
