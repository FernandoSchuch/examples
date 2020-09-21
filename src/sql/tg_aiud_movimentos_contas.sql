create or replace function TG_AIUD_MOVIMENTOS_CONTAS() returns trigger as 
$$
declare
  V_VALOR MOVIMENTOS_CONTAS.MOV_VALOR%type;
  V_CONTA_DESTINO MOVIMENTOS_CONTAS.CON_CONTA_DESTINO%type;
  V_CONTA_ORIGEM MOVIMENTOS_CONTAS.CON_CONTA_ORIGEM%type;
begin
  --
  -- Movimenta da origem para o destino ou volta o saldo do destino para origem
  if TG_OP = 'INSERT' then
    V_VALOR = NEW.MOV_VALOR;
    V_CONTA_DESTINO = NEW.CON_CONTA_DESTINO;
    V_CONTA_ORIGEM  = NEW.CON_CONTA_ORIGEM;
  elsif TG_OP = 'UPDATE' then
    V_VALOR = NEW.MOV_VALOR - OLD.MOV_VALOR;
    V_CONTA_DESTINO = NEW.CON_CONTA_DESTINO;
    V_CONTA_ORIGEM  = NEW.CON_CONTA_ORIGEM;
  else -- DELETE
    V_VALOR = OLD.MOV_VALOR * -1;
    V_CONTA_DESTINO = OLD.CON_CONTA_DESTINO;
    V_CONTA_ORIGEM  = OLD.CON_CONTA_ORIGEM;
  end if;
  --
  update CONTAS
     set CON_SALDO_ATUAL = CON_SALDO_ATUAL + V_VALOR
   where CON_CONTA = V_CONTA_DESTINO;
  --
  update CONTAS
     set CON_SALDO_ATUAL = CON_SALDO_ATUAL + (V_VALOR * -1)
   where CON_CONTA = V_CONTA_ORIGEM;
  --
  if TG_OP = 'INSERT' or TG_OP = 'UPDATE' then
    return NEW;
  else -- DELETE
    return OLD;
  end if;
end;
$$
LANGUAGE plpgsql;

drop trigger TG_AIUD_MOVIMENTOS_CONTAS on MOVIMENTOS_CONTAS;
create trigger TG_AIUD_MOVIMENTOS_CONTAS after insert or update or delete on MOVIMENTOS_CONTAS
  for each row execute procedure TG_AIUD_MOVIMENTOS_CONTAS();