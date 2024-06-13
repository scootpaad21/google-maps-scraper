CREATE TRIGGER after_insert_results
AFTER INSERT ON results
FOR EACH ROW
EXECUTE FUNCTION insert_business_summary();
