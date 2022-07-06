-- a - Quantos títulos possui a coleção?

select count(*) as num_titulos from titulo;

-- R: 49

-- b - Quantas músicas no total possui toda a coleção?
select count(*) as num_musicas from musica;

-- R: 500

-- c - Quantos autores existem na coleção?

select count(*) as num_autores from autor;

-- R: 213

-- d - Quantas editoras distintas existem na coleção?

select count(*) as num_editoras from editora;

-- R: 5

-- e - O autor “Max Changmin” é o principal autor de quantos título?

select count(*) as num_titulos from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where autor."nome" = 'Max Changmin';

-- R: 2

-- f - No ano de 1970, quais foram os títulos comprados pelo utilizador?

select count(*) as num_titulos from titulo 
where "dta_compra" >= '70.01.01' and "dta_compra" <= '70.12.31';

-- R: 8

-- g -  Qual o autor do título que foi adquirido em “01-02-2010”, cujo preço foi de 12€?

select autor."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where "dta_compra" = '10.02.01' and "preco" = 12;

-- R: Yumi Yoshimura

-- h - Na alínea anterior indique qual a editora desse título?

select editora."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
join editora on editora."id_editora" = titulo."id_editora_fk"
where "dta_compra" = '10.02.01' and "preco" = 12;

-- R: EMI

-- i - Quais as reviews (data e classificação) existentes para o título “oh whoa oh”

select "dta_review" as "data", "conteudo" as "classificacao" from review
join titulo on review."id_titulo_fk" = titulo."id_titulo"
where titulo."titulo" = 'oh whoa oh';

-- R: '17.05.07' 'EXCELENTE' '16.05.24' 'EXCELENTE' '17.07.24' 'EXCELENTE' 

-- j - Quais as reviews (data e classificação) existentes para o título “pump”, ordenadas por data da mais antiga
-- para a mais recente?

select "dta_review" as "data", "conteudo" as "classificacao" from review
join titulo on review."id_titulo_fk" = titulo."id_titulo"
where titulo."titulo" = 'pump'
order by review."dta_review" asc;

-- R: '14.07.12' 'EXCELENTE' '15.01.04' 'OBRA PRIMA' '16.02.01' 'PÉSSIMO' '18.09.24' 'PÉSSIMO' 

-- k - Quais os diversos autores das músicas do título lançado a ‘04-04-1970’ com o preço de 20€?

select autor."nome" from autor
join titulo on autor."id_autor" = titulo."id_autor_fk"
where "dta_compra" = '70.04.04' and "preco" = 20;

-- R: Jeon So-mi

-- l - Qual foi o total de dinheiro investido em compras de título da editora ‘EMI’?

select sum("preco") as total_ganho from titulo
join editora on editora."id_editora" = titulo."id_editora_fk"
where editora."nome" = 'EMI';

-- R: 104

-- m - Qual o título mais antigo cujo preço foi de 20€?

select * from(
select * from titulo
where "preco" = 20
order by "dta_compra" asc)
where ROWNUM = 1;

-- R: woman

-- n - Quantos “MP3” tem a coleção?

select count(*) as total_mp3 from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
where suporte."nome" = 'MP3';

-- R: 7

-- o - Destes mp3 quais são o títulos cujo género é: Pop Rock?

select * from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
join genero on genero."id_genero" = titulo."id_genero_fk"
where suporte."nome" = 'MP3' and genero."nome" = 'Pop Rock';

-- R: pop e imma

-- p - Qual o custo total com “Blue-Ray”?

select sum("preco") as total_blue_ray from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
where suporte."nome" = 'Blue-Ray';

-- R: 72

-- q - Qual o custo total com “Blue-Ray” cuja editora é a EMI?

select sum("preco") as total_blue_ray from titulo
join suporte on suporte."id_suporte" = titulo."id_suporte_fk"
join editora on editora."id_editora" = titulo."id_editora_fk"
where suporte."nome" = 'Blue-Ray' and editora."nome" = 'EMI';

-- R: 48

-- r - Qual o património total dos títulos da coleção?

select sum("preco") as total from titulo;

-- R: 503

-- s - Qual a editora na qual o colecionador investiu mais dinheiro?

select editora."nome", sum("preco") as price from editora
join titulo on editora."id_editora" = titulo."id_editora_fk"
group by editora."nome"
order by price desc;

-- R: Vevo e Apple

-- t - Qual a editora que possui mais títulos de “Heavy Metal” na coleção? Quanto titulo possui essa editora?

select editora."nome", count(*) as num_titulos from editora
join titulo on editora."id_editora" = titulo."id_editora_fk"
join genero on titulo."id_genero_fk" = genero."id_genero"
where genero."nome" = 'Heavy Metal'
group by editora."nome"
order by num_titulos desc;

-- R: Valentim de Carvalho com 3 titulos


