create or replace function fnc_tamanho_campo (varchar, varchar) 
       returns setof record /*table (tamanho integer
                     ,edecimal integer
                     ,nulo    varchar(1))*/ as $$
declare
  v_tamanho integer;
begin

  return query 
	select case when data_type = 'numeric' then numeric_precision 
	       else character_maximum_length end /*as tamanho   */    :: integer
	     , numeric_scale     /*as edecimal*/                      :: integer
	     , case when is_nullable = 'Y' then 'S'
	       else 'N'  end    /*as nulo   */                        :: varchar
	  from information_schema.columns
	 where upper(table_name) = upper($1)
	   and upper(column_name) = upper($2);

	return;
 end;
$$ LANGUAGE plpgsql;