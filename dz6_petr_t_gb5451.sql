/* 
1. Создайте функцию, которая принимает кол-во сек и 
формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DROP DATABASE IF EXISTS midterm_certification;
CREATE DATABASE IF NOT EXISTS midterm_certification;
USE midterm_certification;

DELIMITER $$
CREATE FUNCTION time_format1(num INT UNSIGNED)
RETURNS VARCHAR(100)
DETERMINISTIC 
BEGIN
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE result VARCHAR(50) DEFAULT '0 seconds';
    IF num  BETWEEN 1 AND 59 THEN
        SET result = CONCAT (num, ' seconds = ', num, ' seconds');
        RETURN result;
	ELSEIF num  BETWEEN 60 AND 3599 THEN
        SET minutes = FLOOR(num / 60);
        SET seconds = num - minutes*60;
        SET result = CONCAT (num, ' sec = ', minutes, ' min ', seconds, ' sec ');
        RETURN result;	
    ELSEIF num  BETWEEN 3600 AND 86399 THEN
        SET hours = FLOOR (num / 3600);
        SET minutes = FLOOR ((num - hours*3600) / 60);
        SET seconds = num - hours*3600 - minutes*60;
        SET result = CONCAT (num, ' sec = ', hours, ' h ', minutes, ' min ', seconds, ' sec ');
        RETURN result;	
    ELSEIF num  > 86399 THEN
        SET days = FLOOR (num / 86400);
        SET hours = FLOOR((num - days*86400)/3600);
        SET minutes = FLOOR((num - days*86400 - hours*3600) / 60);
        SET seconds = num - days*86400 - hours*3600 - minutes*60;
        SET result = CONCAT (num, ' sec = ', days, ' d ', hours, ' h ', minutes, ' min ', seconds, ' sec ');
        RETURN result;	    
    END IF;
END $$
DELIMITER ;

DROP FUNCTION time_format1;
SELECT time_format1(123456) AS 'формат секунд';

/* 
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

DELIMITER $$
CREATE PROCEDURE proc1(num1 INT)
BEGIN
    DECLARE result VARCHAR(45) DEFAULT ' ';
    CASE
     WHEN MOD(num1, 2) = 0
        THEN WHILE num1 > 1 DO
            SET result = CONCAT (num1, ', ', result);
            SET num1 = num1 - 2;
        END WHILE;
        SELECT result AS even_numbers;
    WHEN MOD(num1, 2) = 1
        THEN 
        SET num1 = num1 - 1;
            WHILE num1 > 1 DO
            SET result = CONCAT (num1, ', ', result);
            SET num1 = num1 - 2;
        END WHILE;
        SELECT result AS even_numbers;
    END CASE;
END $$
DELIMITER ;
DROP PROCEDURE proc1;
CALL proc1(10);
