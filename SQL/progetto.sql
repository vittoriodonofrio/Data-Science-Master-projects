#l'idea è creare una tabella per ogni punto con id_cliente e le colonne richieste.
#Alla fine con una join recupero le colonne che mi interessa inserire nella tabella finale.

DROP TABLE IF EXISTS 
eta,
num_uscite,
num_entrate,
sum_uscite,
sum_entrate,
num_conti,
num_conti_per_tipo,
num_uscite_per_tipo,
num_entrate_per_tipo,
sum_uscite_per_tipo,
sum_entrate_per_tipo,
client_features,
client_features2;

#punto 1
create table eta as 
select
id_cliente, 
YEAR(CURDATE())-YEAR(data_nascita)-
(DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(data_nascita, '%m%d')) as eta
from
banca.cliente; 



#punto 2
create table num_uscite as 
select cliente.id_cliente, COUNT(*) as numero_uscite
from banca.cliente cliente 
left join banca.conto conto 
on conto.id_cliente=cliente.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '-'
group by cliente.id_cliente
order by cliente.id_cliente
;



#punto 3
create table num_entrate as 
select cliente.id_cliente, COUNT(*) as numero_entrate
from banca.cliente cliente 
left join banca.conto conto 
on conto.id_cliente=cliente.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '+'
group by cliente.id_cliente
order by cliente.id_cliente
;


#punto 4
create table sum_uscite as 
select cliente.id_cliente, SUM(transazioni.importo) as importo_uscite
from banca.cliente cliente 
left join banca.conto conto 
on conto.id_cliente=cliente.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '-'
group by cliente.id_cliente
order by cliente.id_cliente;



#punto 5
create table sum_entrate as 
select cliente.id_cliente, SUM(transazioni.importo) as importo_entrate
from banca.cliente cliente 
left join banca.conto conto 
on conto.id_cliente=cliente.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '+'
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 6
create table num_conti as 
select cliente.id_cliente, count(*) as numero_conti
from banca.cliente cliente
inner join banca.conto conto
on cliente.id_cliente = conto.id_cliente
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 7
create table num_conti_per_tipo as 
select cliente.id_cliente, 
count(distinct case when tipo_conto.desc_tipo_conto='Conto Privati' 
				then conto.id_conto 
                else null 
                end) count_privati,
count(distinct case when tipo_conto.desc_tipo_conto='Conto Base' 
				then conto.id_conto 
                else null 
                end) count_base,
count(distinct case when tipo_conto.desc_tipo_conto='Conto Business' 
				then conto.id_conto 
                else null 
                end) count_business,
count(distinct case when tipo_conto.desc_tipo_conto='Conto Famiglie' 
				then conto.id_conto 
                else null 
                end) count_famiglie
from banca.cliente cliente
left join banca.conto conto
on cliente.id_cliente = conto.id_cliente
left join banca.tipo_conto tipo_conto
on tipo_conto.id_tipo_conto = conto.id_tipo_conto
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 8
create table num_uscite_per_tipo as
select 
cliente.id_cliente,
count(case when tipo_transazione.desc_tipo_trans='Acquisto su Amazon' 
				then conto.id_conto 
                else null 
                end) num_uscite_amazon,
count(case when tipo_transazione.desc_tipo_trans='Rata mutuo' 
				then conto.id_conto 
                else null  
                end) num_uscite_mutuo,
count(case when tipo_transazione.desc_tipo_trans='Hotel' 
				then conto.id_conto 
                else null 
                end) num_uscite_hotel,
count(case when tipo_transazione.desc_tipo_trans='Biglietto aereo' 
				then conto.id_conto 
                else null 
                end) num_uscite_aereo,
count(case when tipo_transazione.desc_tipo_trans='Supermercato' 
				then conto.id_conto 
                else null 
                end) num_uscite_supermercato
from banca.cliente cliente
left join banca.conto conto
on cliente.id_cliente = conto.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 9
create table num_entrate_per_tipo as
select 
cliente.id_cliente,
count(case when tipo_transazione.desc_tipo_trans='Stipendio' 
				then conto.id_conto 
                else null 
                end) num_entrate_stipendio,
count(case when tipo_transazione.desc_tipo_trans='Pensione' 
				then conto.id_conto 
                else null  
                end) num_entrate_pensione,
count(case when tipo_transazione.desc_tipo_trans='Dividendi' 
				then conto.id_conto 
                else null 
                end) num_entrate_dividendi
from banca.cliente cliente
left join banca.conto conto
on cliente.id_cliente = conto.id_cliente
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 10
create table sum_uscite_per_tipo as 
select cliente.id_cliente, 
sum(case when tipo_conto.desc_tipo_conto='Conto Privati' 
				then transazioni.importo
                else 0
                end) somma_uscite_privati,
sum(case when tipo_conto.desc_tipo_conto='Conto Base' 
				then transazioni.importo 
                else 0 
                end) somma_uscite_base,
sum(case when tipo_conto.desc_tipo_conto='Conto Business' 
				then transazioni.importo 
                else 0 
                end) somma_uscite_business,
sum(case when tipo_conto.desc_tipo_conto='Conto Famiglie' 
				then transazioni.importo
                else 0 
                end) somma_uscite_famiglie
from banca.cliente cliente
left join banca.conto conto
on cliente.id_cliente = conto.id_cliente
left join banca.tipo_conto tipo_conto
on tipo_conto.id_tipo_conto = conto.id_tipo_conto
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '-'
group by cliente.id_cliente
order by cliente.id_cliente;




#punto 11
create table sum_entrate_per_tipo as 
select cliente.id_cliente, 
sum(case when tipo_conto.desc_tipo_conto='Conto Privati' 
				then transazioni.importo
                else 0
                end) somma_entrate_privati,
sum(case when tipo_conto.desc_tipo_conto='Conto Base' 
				then transazioni.importo 
                else 0 
                end) somma_entrate_base,
sum(case when tipo_conto.desc_tipo_conto='Conto Business' 
				then transazioni.importo 
                else 0 
                end) somma_entrate_business,
sum(case when tipo_conto.desc_tipo_conto='Conto Famiglie' 
				then transazioni.importo
                else 0 
                end) somma_entrate_famiglie
from banca.cliente cliente
left join banca.conto conto
on cliente.id_cliente = conto.id_cliente
left join banca.tipo_conto tipo_conto
on tipo_conto.id_tipo_conto = conto.id_tipo_conto
left join banca.transazioni transazioni 
on conto.id_conto = transazioni.id_conto
left join banca.tipo_transazione tipo_transazione
on tipo_transazione.id_tipo_transazione = transazioni.id_tipo_trans
where tipo_transazione.segno = '+'
group by cliente.id_cliente
order by cliente.id_cliente;




create table client_features as
select cliente.id_cliente,
eta,
IFNULL(numero_uscite, 0) as numero_uscite,
IFNULL(numero_entrate, 0) as numero_entrate,
IFNULL(importo_uscite, 0) as importo_uscite,
IFNULL(importo_entrate, 0) as importo_entrate,
IFNULL(numero_conti, 0) as numero_conti,
count_privati,
count_base,
count_business,
count_famiglie,
num_uscite_amazon,
num_uscite_mutuo,
num_uscite_hotel,
num_uscite_aereo,
num_uscite_supermercato,
num_entrate_stipendio,
num_entrate_pensione,
num_entrate_dividendi,
IFNULL(somma_uscite_privati, 0) as somma_uscite_privati,
IFNULL(somma_uscite_base, 0) as somma_uscite_base,
IFNULL(somma_uscite_business, 0) as somma_uscite_business,
IFNULL(somma_uscite_famiglie, 0) as somma_uscite_famiglie,
IFNULL(somma_entrate_privati, 0) as somma_entrate_privati,
IFNULL(somma_entrate_base, 0) as somma_entrate_base,
IFNULL(somma_entrate_business, 0) as somma_entrate_business,
IFNULL(somma_entrate_famiglie, 0) as somma_entrate_famiglie
from banca.cliente cliente
left join banca.eta eta
on cliente.id_cliente = eta.id_cliente
left join banca.num_uscite uscite 
on cliente.id_cliente = uscite.id_cliente
left join banca.num_entrate entrate
on cliente.id_cliente = entrate.id_cliente
left join banca.sum_uscite s_uscite 
on cliente.id_cliente = s_uscite.id_cliente
left join sum_entrate s_entrate 
on cliente.id_cliente = s_entrate.id_cliente
left join num_conti n_conti 
on cliente.id_cliente = n_conti.id_cliente
left join num_conti_per_tipo tipo1 
on cliente.id_cliente = tipo1.id_cliente
left join num_uscite_per_tipo tipo2 
on cliente.id_cliente = tipo2.id_cliente
left join num_entrate_per_tipo tipo3 
on cliente.id_cliente = tipo3.id_cliente
left join sum_uscite_per_tipo tipo4 
on cliente.id_cliente = tipo4.id_cliente
left join sum_entrate_per_tipo tipo5 
on cliente.id_cliente = tipo5.id_cliente;

select * from client_features;

DROP TABLE IF EXISTS 
eta,
num_uscite,
num_entrate,
sum_uscite,
sum_entrate,
num_conti,
num_conti_per_tipo,
num_uscite_per_tipo,
num_entrate_per_tipo,
sum_uscite_per_tipo,
sum_entrate_per_tipo;

