# Descrição textual dos casos de uso principais

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

## UC-02 – Editar evento

- **Atores:** Organizador
- **Pré-condições:** organizador autenticado; evento cadastrado por ele.
- **RF relacionados:** RF-008

**Fluxo principal**
1. O organizador seleciona um de seus eventos e escolhe "Editar".
2. O sistema exibe os dados atuais do evento.
3. O organizador altera os dados desejados e confirma.
4. O sistema valida, grava as alterações e exibe a confirmação.

**Fluxos alternativos/exceção**
- **E1 – Dados inválidos (passo 4):** o sistema indica os erros e volta ao passo 3.
- **E2 – Quantidade menor que a já vendida (passo 4):** o sistema recusa a alteração e informa quantos ingressos já foram vendidos.

**Pós-condições:** evento atualizado e visível na busca.

---

## UC-03 – Buscar e filtrar eventos

- **Atores:** Comprador
- **Pré-condições:** nenhuma.
- **RF relacionados:** RF-006

**Fluxo principal**
1. O comprador informa um termo de busca e/ou filtros (categoria, data, local, preço).
2. O sistema consulta os eventos publicados que atendem aos critérios.
3. O sistema exibe a lista de eventos encontrados.
4. O comprador escolhe um evento para ver os detalhes e, se quiser, seguir para a compra (UC-05).

**Fluxos alternativos/exceção**
- **E1 – Nenhum evento encontrado (passo 2):** o sistema informa que não há resultados e sugere ampliar os filtros.

**Pós-condições:** nenhuma alteração de dados.

---

## UC-04 – Consultar disponibilidade

- **Atores:** Comprador (acionado também pelo UC-05, via «include»)
- **Pré-condições:** evento publicado.
- **RF relacionados:** RF-005

**Fluxo principal**
1. O sistema lê a quantidade disponível de ingressos do evento.
2. O sistema informa a quantidade disponível ao comprador.

**Fluxos alternativos/exceção**
- **E1 – Ingressos esgotados (passo 1):** o sistema exibe "Esgotado" e a compra não é permitida.

**Pós-condições:** nenhuma alteração de dados.

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

---

## UC-08 – Acompanhar vendas

- **Atores:** Organizador
- **Pré-condições:** organizador autenticado; possui ao menos um evento cadastrado.
- **RF relacionados:** RF-004

**Fluxo principal**
1. O organizador escolhe "Acompanhar vendas" e seleciona um de seus eventos.
2. O sistema consolida os pedidos pagos e os ingressos do evento.
3. O sistema exibe a quantidade vendida, a quantidade disponível e o valor arrecadado.

**Fluxos alternativos/exceção**
- **E1 – Evento sem vendas (passo 2):** o sistema exibe os totais zerados.

**Pós-condições:** nenhuma alteração de dados.

---

## UC-09 – Notificar participantes

- **Atores:** Sistema (agendador); Comprador como destinatário
- **Pré-condições:** existem ingressos pagos para um evento que se aproxima.
- **RF relacionados:** RF-007

**Fluxo principal**
1. O agendador do sistema dispara a rotina de notificações antes da data do evento.
2. O sistema identifica os compradores com ingressos pagos para o evento.
3. O sistema registra uma notificação para cada comprador, com os dados do evento (data, horário e local).
4. O sistema entrega as notificações aos compradores.

**Fluxos alternativos/exceção**
- **E1 – Evento alterado ou cancelado (passo 1):** o sistema notifica os compradores sobre a mudança, e não mais sobre o lembrete.
- **E2 – Falha na entrega (passo 4):** a notificação permanece registrada para nova tentativa.

**Pós-condições:** notificações registradas para os participantes do evento.
