1
use pandemic;

select count(1) from pandemic.infectious_cases ic;


2
DROP TABLE IF EXISTS countries;

CREATE TABLE `pandemic`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(45) NULL,
  `Code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `Code_IDX` (`Code` ASC) VISIBLE);
 
insert into `pandemic`.`countries` (Country,Code) select distinct Entity, Code from pandemic.infectious_cases;

ALTER TABLE pandemic.infectious_cases ADD Country_id INT NULL;

ALTER TABLE pandemic.infectious_cases 
ADD CONSTRAINT country_id
  FOREIGN KEY (country_id)
  REFERENCES pandemic.countries (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER Entity,
ADD PRIMARY KEY (`id`);

update infectious_cases ic set `Country_id` = (select id from countries c where c.Country=ic.Entity) where `Country_id` is null;

ALTER TABLE `pandemic`.`infectious_cases` 
DROP COLUMN `Code`,
DROP COLUMN `Entity`;


3
select Country_id, 
avg(Number_rabies) num_average, 
min(Number_rabies) num_min, 
max(Number_rabies) num_max, 
sum(Number_rabies) num_sum 
from infectious_cases
where Number_rabies is not null
group by Country_id
order by num_average desc
limit 10;


4
ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `first_year` DATE NULL DEFAULT NULL;


update infectious_cases
set `first_year` = MAKEDATE(year, 1);

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `cur_date` DATE NULL DEFAULT NULL AFTER `first_year`;

update infectious_cases
set `cur_date` = date(now());

ALTER TABLE `pandemic`.`infectious_cases` 
ADD COLUMN `dif_date` INT NULL DEFAULT NULL AFTER `current`;

update infectious_cases
set `dif_date`  = TIMESTAMPDIFF(year, `first_year`, `cur_date`);


5
select fun_dif_date(1989);

select dif_date, fun_dif_date(year) from infectious_cases;

