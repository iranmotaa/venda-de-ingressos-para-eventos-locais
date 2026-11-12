CREATE TABLE usuario (
    id    SERIAL PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE organizador (
    id INTEGER PRIMARY KEY REFERENCES usuario (id)
);

CREATE TABLE categoria (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE evento (
    id                    SERIAL PRIMARY KEY,
    nome                  VARCHAR(150) NOT NULL,
    descricao             TEXT,
    data_hora             TIMESTAMP NOT NULL,
    local                 VARCHAR(200) NOT NULL,
    valor_ingresso        NUMERIC(10,2) NOT NULL CHECK (valor_ingresso >= 0),
    quantidade_disponivel INTEGER NOT NULL CHECK (quantidade_disponivel >= 0), 
    organizador_id        INTEGER NOT NULL REFERENCES organizador (id),        
    categoria_id          INTEGER NOT NULL REFERENCES categoria (id)           
);

CREATE TABLE pedido (
    id          SERIAL PRIMARY KEY,
    data        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0),
    status      VARCHAR(20) NOT NULL DEFAULT 'PENDENTE'
                CHECK (status IN ('PENDENTE', 'PAGO', 'CANCELADO')),
    usuario_id  INTEGER NOT NULL REFERENCES usuario (id)                        
);

CREATE TABLE ingresso (
    id         SERIAL PRIMARY KEY,
    codigo_qr  VARCHAR(100) NOT NULL UNIQUE,                                    
    utilizado  BOOLEAN NOT NULL DEFAULT FALSE,
    pedido_id  INTEGER NOT NULL REFERENCES pedido (id),                         
    evento_id  INTEGER NOT NULL REFERENCES evento (id)                          
);


CREATE TABLE pagamento (
    id           SERIAL PRIMARY KEY,
    id_transacao VARCHAR(100) NOT NULL,
    valor        NUMERIC(10,2) NOT NULL CHECK (valor >= 0),
    status       VARCHAR(20) NOT NULL
                 CHECK (status IN ('APROVADO', 'RECUSADO')),
    pedido_id    INTEGER NOT NULL UNIQUE REFERENCES pedido (id)                 
);

CREATE TABLE notificacao (
    id         SERIAL PRIMARY KEY,
    mensagem   VARCHAR(300) NOT NULL,
    data_envio TIMESTAMP NOT NULL,
    usuario_id INTEGER NOT NULL REFERENCES usuario (id),                        
    evento_id  INTEGER NOT NULL REFERENCES evento (id)                          
);
