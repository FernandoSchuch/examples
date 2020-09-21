-- Conferência de Movimentos
select a.mov_sequencia, 
       a.mov_descricao,
       a.mov_data_base,
       a.con_conta_origem,
       b.con_descricao as descricao_origem,
       a.con_conta_destino,
       c.con_descricao as descricao_destino,
       a.mov_valor       
  from movimentos_contas a
       join contas b on b.con_conta = a.con_conta_origem
       join contas c on c.con_conta = a.con_conta_destino
 where a.mov_data_base between '2020-08-01' and '2020-08-31'
 order by a.mov_sequencia;
 
-- Entradas
select sum(mov_valor)
  from movimentos_contas a
 where a.mov_data_base between '2020-08-01' and '2020-08-31'
   and a.con_conta_origem = 11;
-- Saídas
select sum(mov_valor)
  from movimentos_contas a
 where a.mov_data_base between '2020-08-01' and '2020-08-31'
   and a.con_conta_destino = 12;