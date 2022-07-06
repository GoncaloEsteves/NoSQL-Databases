-- a - Quantos t�tulos possui a cole��o?

select count(*) as num_titulos from titulo;

-- R: 49

-- b - Quantas m�sicas no total possui toda a cole��o?
select count(*) as num_musicas from musica;

-- R: 500

-- c - Quantos autores existem na cole��o?

select count(*) as num_autores from autor;

-- R: 213

-- d - Quantas editoras distintas existem na cole��o?

select count(*) as num_editoras from editora;

-- R: 5

-- e - O autor �Max Changmin� � o principal autor de quantos t�tulo?

select count(*) as num_titulos from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where autor."nome" = 'Max Changmin';

-- R: 2

-- f - No ano de 1970, quais foram os t�tulos comprados pelo utilizador?

select count(*) as num_titulos from titulo 
where "dta_compra" >= '70.01.01' and "dta_compra" <= '70.12.31';

-- R: 8

-- g -  Qual o autor do t�tulo que foi adquirido em �01-02-2010�, cujo pre�o foi de 12�?

select autor."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where "dta_compra" = '10.02.01' and "preco" = 12;

-- R: Yumi Yoshimura

-- h - Na al�nea anterior indique qual a editora desse t�tulo?

select editora."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
join editora on editora."id_editora" = titulo."id_editora_fk"
where "dta_compra" = '10.02.01' and "preco" = 12;

-- R: EMI

-- i - Quais as reviews (data e classifica��o) existentes para o t�tulo �oh whoa oh�

select "dta_review" as "data", "conteudo" as "classificacao" from review
join titulo on review."id_titulo_fk" = titulo."id_titulo"
where titulo."titulo" = 'oh whoa oh';

-- R: '17.05.07' 'EXCELENTE' '16.05.24' 'EXCELENTE' '17.07.24' 'EXCELENTE' 

-- j - Quais as reviews (data e classifica��o) existentes para o t�tulo �pump�, ordenadas por data da mais antiga
-- para a mais recente?

select "dta_review" as "data", "conteudo" as "classificacao" from review
join titulo on review."id_titulo_fk" = titulo."id_titulo"
where titulo."titulo" = 'pump'
order by review."dta_review" asc;

-- R: '14.07.12' 'EXCELENTE' '15.01.04' 'OBRA PRIMA' '16.02.01' 'P�SSIMO' '18.09.24' 'P�SSIMO' 

-- k - Quais os diversos autores das m�sicas do t�tulo lan�ado a �04-04-1970� com o pre�o de 20�?

select autor."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where "dta_compra" = '70.04.04' and "preco" = 20;

-- R: Jeon So-mi

-- l - Qual foi o total de dinheiro investido em compras de t�tulo da editora �EMI�?

select sum("preco") as total_ganho from titulo
join editora on editora."id_editora" = titulo."id_editora_fk"
where editora."nome" = 'EMI';

-- R: 104

-- m - Qual o t�tulo mais antigo cujo pre�o foi de 20�?

select * from(
select * from titulo
where "preco" = 20
order by "dta_compra" asc)
where ROWNUM = 1;

-- R: woman

-- n - Quantos �MP3� tem a cole��o?

select count(*) as total_mp3 from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
where suporte."nome" = 'MP3';

-- R: 7

-- o - Destes mp3 quais s�o o t�tulos cujo g�nero �: Pop Rock?

select * from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
join genero on genero."id_genero" = titulo."id_genero_fk"
where suporte."nome" = 'MP3' and genero."nome" = 'Pop Rock';

-- R: pop e imma

-- p - Qual o custo total com �Blue-Ray�?

select sum("preco") as total_blue_ray from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
where suporte."nome" = 'Blue-Ray';

-- R: 72

-- q - Qual o custo total com �Blue-Ray� cuja editora � a EMI?

select sum("preco") as total_blue_ray from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
join editora on editora."id_editora" = titulo."id_editora_fk"
where suporte."nome" = 'Blue-Ray' and editora."nome" = 'EMI';

-- R: 48

-- r - Qual o patrim�nio total dos t�tulos da cole��o?

select sum("preco") as total from titulo;

-- R: 503

-- s - Qual a editora na qual o colecionador investiu mais dinheiro?

select editora."nome", sum("preco") as price from editora
join titulo on editora."id_editora" = titulo."id_editora_fk"
group by editora."nome"
order by price desc;

-- R: Vevo e Apple

-- t - Qual a editora que possui mais t�tulos de �Heavy Metal� na cole��o? Quanto titulo possui essa editora?

select editora."nome", count(*) as num_titulos from editora
join titulo on editora."id_editora" = titulo."id_editora_fk"
join genero on titulo."id_genero_fk" = genero."id_genero"
where genero."nome" = 'Heavy Metal'
group by editora."nome"
order by num_titulos desc;

-- R: Valentim de Carvalho com 3 titulos


