CREATE OR REPLACE FUNCTION insert_business_summary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data->>'phone' IS NOT NULL AND NEW.data->>'phone' != ''
       AND NEW.data->>'address' IS NOT NULL AND NEW.data->>'address' != ''
       AND (NEW.data->>'review_count')::INTEGER > 0
       AND NEW.data->>'category' IS DISTINCT FROM 'Gas Station' THEN
        INSERT INTO business_summary (
            original_id,
            title,
            phone,
            owner_name,
            address,
            category,
            latitude,
            longitude,
            review_rating,
            review_count,
            curbside_pickup,
            takeout,
            dine_in,
            delivery,
            wheelchair_accessible_entrance,
            wheelchair_accessible_parking_lot,
            wheelchair_accessible_restroom,
            wheelchair_accessible_seating,
            alcohol,
            beer,
            coffee,
            wine,
            lunch,
            dinner,
            dessert,
            seating,
            accepts_reservations,
            credit_cards,
            debit_cards,
            nfc_mobile_payments
        )
        SELECT
            NEW.id,
            NEW.data->>'title' AS title,
            NEW.data->>'phone' AS phone,
            NEW.data->'owner'->>'name' AS owner_name,
            NEW.data->>'address' AS address,
            NEW.data->>'category' AS category,
            (NEW.data->>'latitude')::DOUBLE PRECISION AS latitude,
            CASE 
                WHEN NEW.data->>'longtitude' = '' THEN NULL
                ELSE (NEW.data->>'longtitude')::DOUBLE PRECISION 
            END AS longitude,
            (NEW.data->>'review_rating')::DOUBLE PRECISION AS review_rating,
            (NEW.data->>'review_count')::INTEGER AS review_count,
            (jsonb_path_query_first(NEW.data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Curbside pickup").enabled'))::BOOLEAN AS curbside_pickup,
            (jsonb_path_query_first(NEW.data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Takeout").enabled'))::BOOLEAN AS takeout,
            (json
