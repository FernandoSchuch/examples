/*do $$
declare
  v_retorno varchar;
begin
  v_retorno := prc_fechar_periodo('01/01/2020', '01/01/2020');
  raise notice 'Teste: %', v_retorno;
end;
$$language plpgsql;*/

create or replace function prc_fechar_periodo (p_data_inicial character varying, 
                                               p_data_final character varying, 
                                               out p_retorno character varying) returns character varying as
$$
declare
  cursor c_ultimo_fechamento ...
  v_data_inicial date;
  v_data_final date;
begin
  v_data_inicial := to_date(p_data_inicial, 'dd/mm/yyyy');
  v_data_final := to_date(p_data_final, 'dd/mm/yyyy');

  p_retorno := 'S';
end;
$$
language plpgsql;