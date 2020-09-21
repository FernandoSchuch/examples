CREATE TABLE contas (
	con_conta numeric(5) not null,
	con_descricao varchar(60),
	con_saldo_inicial numeric(16,2) not null default 0,
	con_data_saldo_inicial timestamp not null default now(),
	con_saldo_atual numeric(16,2) not null default 0,
	con_ativa varchar(1) not null default 'S'
);

ALTER TABLE contas ADD CONSTRAINT contas_pk PRIMARY KEY (con_conta);

CREATE TABLE movimentos_contas (
	mov_sequencia numeric(10) not null,
	mov_descricao varchar(50) not null,
	con_conta_origem numeric(5) not null,
	con_conta_destino numeric(5),
	mov_valor numeric(16,2) not null default 0,
	mov_data timestamp not null
);

ALTER TABLE movimentos_contas ADD CONSTRAINT movimentos_contas_pk PRIMARY KEY (mov_sequencia);
ALTER TABLE movimentos_contas ADD CONSTRAINT mov_contas_origem_fk FOREIGN KEY (con_conta_origem) REFERENCES contas (con_conta);
ALTER TABLE movimentos_contas ADD CONSTRAINT mov_contas_destino_fk FOREIGN KEY (con_conta_destino) REFERENCES contas (con_conta);

CREATE TABLE agendamentos (
	age_agendamento numeric(10) not null,
	age_descricao varchar(50) not null,
	age_dia_vencimento numeric(2) not null,
	age_operacao varchar(1) not null,
	age_ativo varchar(1) not null default 'S'
);

ALTER TABLE agendamentos ADD CONSTRAINT agendamentos_pk PRIMARY KEY (age_agendamento);
ALTER TABLE movimentos_contas ADD COLUMN age_agendamento numeric(10);
ALTER TABLE movimentos_contas ADD CONSTRAINT mov_agendamentos_fk FOREIGN KEY (age_agendamento) REFERENCES agendamentos (age_agendamento);

CREATE TABLE ultimos_codigos
(
  ult_tabela varchar(50) not null,
  ult_codigo numeric(10,0) not null 
);

CREATE TABLE parametros (
   par_parametro varchar(50),
   par_valor     varchar(50)
);

alter table agendamentos add column con_conta_origem numeric(5) not null;
alter table agendamentos add column con_conta_destino numeric(5) not null;
--
alter table agendamentos add constraint age_contas_origem_fk foreign key (con_conta_origem) references contas(con_conta);
alter table agendamentos add constraint age_contas_destino_fk foreign key (con_conta_destino) references contas(con_conta);
--
alter table movimentos_contas add column mov_data_base timestamp not null default now();
--
create table fechamentos (
  fec_fechamento numeric(5) not null,
  fec_data_inicial timestamp not null,
  fec_data_final timestamp not null
);

create table fechamentos_contas (
  fec_fechamento numeric(5) not null,
  con_conta numeric(5) not null,
  fco_saldo numeric(16,2) not null
);

alter table fechamentos add constraint fechamentos_pk primary key (fec_fechamento);
alter table fechamentos_contas add constraint fechamentos_contas_pk primary key (fec_fechamento, con_conta);
alter table fechamentos_contas add constraint fco_fechamentos_fk foreign key (fec_fechamento) references fechamentos (fec_fechamento);
alter table fechamentos_contas add constraint fco_contas_fk foreign key (con_conta) references contas (con_conta);
