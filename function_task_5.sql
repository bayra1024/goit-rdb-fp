DROP FUNCTION IF EXISTS fun_dif_date;

DELIMITER //

CREATE FUNCTION fun_dif_date(zero_day int)
RETURNS int
DETERMINISTIC 
NO SQL
BEGIN
   set @years = TIMESTAMPDIFF(year, MAKEDATE(zero_day, 1), now());
    
    
    RETURN @years;
END //

DELIMITER ;