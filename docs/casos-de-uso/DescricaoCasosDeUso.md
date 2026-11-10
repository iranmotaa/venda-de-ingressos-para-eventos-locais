# Descrição textual dos casos de uso principais

Casos descritos: UC-01, UC-05, UC-06 e UC-07.
Os casos **UC-05 (Comprar ingresso)** e **UC-06 (Pagar ingresso)** são os que terão Diagrama de Sequência.

---

## UC-01 – Cadastrar evento

| Campo | Descrição |
|-------|-----------|
| **Nome** | Cadastrar evento |
| **Atores** | Organizador (principal) |
| **Pré-condições** | 1. O organizador está cadastrado e autenticado no sistema. |
| **Pós-condições** | O evento fica registrado e publicado, visível na busca e disponível para venda de ingressos. |
| **RF relacionados** | RF-001, RF-008 |

**Fluxo principal**
1. O organizador seleciona a opção "Cadastrar evento".
2. O sistema exibe o formulário de cadastro.
3. O organizador informa nome, descrição, data, horário, local, categoria, valor e quantidade de ingressos.
4. O organizador confirma o cadastro.
5. O sistema valida os dados informados.
6. O sistema registra e publica o evento.
7. O sistema exibe a confirmação de cadastro.

**Fluxos alternativos**
- **A1 – Cancelar (qualquer passo):** o organizador cancela; o sistema descarta os dados e retorna à tela inicial.

**Fluxos de exceção**
- **E1 – Dados inválidos ou obrigatórios ausentes (passo 5):** o sistema indica os campos com erro e retorna ao passo 3.
- **E2 – Data no passado (passo 5):** o sistema rejeita a data e solicita uma data futura.

---

## UC-05 – Comprar ingresso *(Diagrama de Sequência)*

| Campo | Descrição |
|-------|-----------|
| **Nome** | Comprar ingresso |
| **Atores** | Comprador (principal); Gateway de Pagamento (secundário, via UC-06) |
| **Pré-condições** | 1. O comprador está cadastrado e autenticado.<br>2. O evento está publicado e possui ingressos disponíveis. |
| **Pós-condições** | 1. O pedido é registrado e o pagamento confirmado.<br>2. A quantidade de ingressos disponíveis é reduzida.<br>3. Um ingresso com QR Code único é gerado para o comprador. |
| **RF relacionados** | RF-002, RF-003, RF-005, RF-009 (via UC-06) |
| **RNF relacionados** | RNF-001 (escalabilidade), RNF-004 (concorrência) |

**Fluxo principal**
1. O comprador seleciona um evento e escolhe a opção "Comprar ingresso".
2. O sistema exibe os dados do evento e a quantidade de ingressos disponíveis.
3. O comprador informa a quantidade desejada de ingressos.
4. O sistema verifica a disponibilidade e reserva temporariamente os ingressos (controle de estoque).
5. O sistema cria o pedido com o valor total e exibe o resumo.
6. O comprador confirma o pedido.
7. O sistema executa o caso de uso **UC-06 – Pagar ingresso** («include»).
8. Com o pagamento aprovado, o sistema confirma o pedido e baixa o estoque definitivamente.
9. O sistema gera um QR Code único para cada ingresso.
10. O sistema exibe a confirmação da compra e disponibiliza os ingressos ao comprador.

**Fluxos alternativos**
- **A1 – Cancelar compra (passos 3 a 6):** o comprador cancela; o sistema libera a reserva e encerra o caso de uso.

**Fluxos de exceção**
- **E1 – Ingressos insuficientes (passo 4):** o sistema informa a quantidade realmente disponível e retorna ao passo 3.
- **E2 – Compra simultânea esgota o estoque (passo 4):** outro comprador reservou os últimos ingressos; o sistema informa a indisponibilidade e nenhum pedido é criado (RNF-004).
- **E3 – Reserva expirada (passo 6):** o tempo da reserva terminou; o sistema libera os ingressos, informa o comprador e retorna ao passo 2.
- **E4 – Pagamento recusado ou falho (passo 7):** o sistema libera a reserva, marca o pedido como não pago e informa o comprador, que pode tentar novamente.

---

## UC-06 – Pagar ingresso *(Diagrama de Sequência)*

| Campo | Descrição |
|-------|-----------|
| **Nome** | Pagar ingresso |
| **Atores** | Comprador (principal); Gateway de Pagamento (secundário) |
| **Pré-condições** | 1. Existe um pedido pendente de pagamento, com reserva de ingressos válida.<br>2. O Gateway de Pagamento está acessível. |
| **Pós-condições** | 1. Pagamento aprovado: o pagamento é registrado e o pedido passa a "pago".<br>2. Pagamento recusado: o pedido permanece pendente ou é cancelado e a reserva é liberada.<br>3. Nenhum dado de cartão é armazenado pelo sistema (RNF-002). |
| **RF relacionados** | RF-009 |
| **RNF relacionados** | RNF-002 (segurança) |

**Fluxo principal**
1. O sistema apresenta as formas de pagamento disponíveis e o valor total do pedido.
2. O comprador escolhe a forma de pagamento.
3. O sistema redireciona o comprador ao ambiente seguro do Gateway de Pagamento (ou envia a solicitação de cobrança).
4. O comprador informa os dados de pagamento diretamente ao Gateway.
5. O Gateway processa a transação e retorna o resultado ao sistema.
6. O sistema registra o pagamento (identificador da transação e status, sem dados de cartão) e atualiza o pedido para "pago".
7. O sistema retorna o resultado ao UC-05.

**Fluxos alternativos**
- **A1 – Comprador desiste do pagamento (passos 2 a 4):** o sistema marca o pagamento como cancelado e libera a reserva.
- **A2 – Pagamento por meio assíncrono, como Pix ou boleto (passo 5):** o Gateway notifica a confirmação posteriormente; o sistema mantém o pedido "aguardando pagamento" até receber a notificação.

**Fluxos de exceção**
- **E1 – Pagamento recusado (passo 5):** o sistema registra a recusa, informa o motivo ao comprador e permite escolher outra forma de pagamento (retorna ao passo 2).
- **E2 – Gateway indisponível ou tempo esgotado (passos 3 a 5):** o sistema informa a falha, mantém o pedido pendente enquanto a reserva for válida e sugere tentar novamente.
- **E3 – Reserva expirada durante o pagamento:** o sistema cancela o pedido; caso a cobrança tenha sido aprovada, solicita o estorno ao Gateway.

---

## UC-07 – Validar ingresso (QR Code)

| Campo | Descrição |
|-------|-----------|
| **Nome** | Validar ingresso (QR Code) |
| **Atores** | Equipe de entrada / Organizador (principal) |
| **Pré-condições** | 1. O responsável pela validação está autenticado.<br>2. O ingresso foi emitido após pagamento aprovado.<br>3. O evento está em andamento ou na data de realização. |
| **Pós-condições** | O ingresso válido é marcado como utilizado e a entrada é liberada. |
| **RF relacionados** | RF-003 |

**Fluxo principal**
1. O responsável seleciona a opção "Validar ingresso".
2. O responsável lê o QR Code do ingresso do participante.
3. O sistema localiza o ingresso e verifica sua autenticidade, se pertence ao evento e se ainda não foi utilizado.
4. O sistema marca o ingresso como utilizado.
5. O sistema exibe a mensagem "Ingresso válido – entrada liberada".

**Fluxos alternativos**
- **A1 – Leitura manual (passo 2):** a leitura do QR Code falha e o responsável digita o código do ingresso; o fluxo segue no passo 3.

**Fluxos de exceção**
- **E1 – QR Code inválido ou inexistente (passo 3):** o sistema exibe "Ingresso inválido" e a entrada não é liberada.
- **E2 – Ingresso já utilizado (passo 3):** o sistema exibe "Ingresso já utilizado", com data e hora do primeiro uso.
- **E3 – Ingresso de outro evento (passo 3):** o sistema informa que o ingresso não pertence a este evento.
