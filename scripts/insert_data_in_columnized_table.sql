INSERT INTO business_summary (
    original_id,
    title,
    phone,
    owner_name,
    street,
    city,
    state,
    postal_code,
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
    id,
    data->>'title' AS title,
    data->>'phone' AS phone,
    data->'owner'->>'name' AS owner_name,
    data->'complete_address'->>'street' AS street,
    data->'complete_address'->>'city' AS city,
    data->'complete_address'->>'state' AS state,
    data->'complete_address'->>'postal_code' AS postal_code,
    data->>'category' AS category,
    (data->>'latitude')::DOUBLE PRECISION AS latitude,
    CASE 
        WHEN data->>'longtitude' = '' THEN NULL
        ELSE (data->>'longtitude')::DOUBLE PRECISION 
    END AS longitude,
    (data->>'review_rating')::DOUBLE PRECISION AS review_rating,
    (data->>'review_count')::INTEGER AS review_count,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Curbside pickup").enabled'))::BOOLEAN AS curbside_pickup,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Takeout").enabled'))::BOOLEAN AS takeout,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Dine-in").enabled'))::BOOLEAN AS dine_in,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "service_options").options[*] ? (@.name == "Delivery").enabled'))::BOOLEAN AS delivery,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "accessibility").options[*] ? (@.name == "Wheelchair accessible entrance").enabled'))::BOOLEAN AS wheelchair_accessible_entrance,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "accessibility").options[*] ? (@.name == "Wheelchair accessible parking lot").enabled'))::BOOLEAN AS wheelchair_accessible_parking_lot,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "accessibility").options[*] ? (@.name == "Wheelchair accessible restroom").enabled'))::BOOLEAN AS wheelchair_accessible_restroom,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "accessibility").options[*] ? (@.name == "Wheelchair accessible seating").enabled'))::BOOLEAN AS wheelchair_accessible_seating,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "offerings").options[*] ? (@.name == "Alcohol").enabled'))::BOOLEAN AS alcohol,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "offerings").options[*] ? (@.name == "Beer").enabled'))::BOOLEAN AS beer,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "offerings").options[*] ? (@.name == "Coffee").enabled'))::BOOLEAN AS coffee,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "offerings").options[*] ? (@.name == "Wine").enabled'))::BOOLEAN AS wine,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "dining_options").options[*] ? (@.name == "Lunch").enabled'))::BOOLEAN AS lunch,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "dining_options").options[*] ? (@.name == "Dinner").enabled'))::BOOLEAN AS dinner,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "dining_options").options[*] ? (@.name == "Dessert").enabled'))::BOOLEAN AS dessert,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "dining_options").options[*] ? (@.name == "Seating").enabled'))::BOOLEAN AS seating,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "planning").options[*] ? (@.name == "Accepts reservations").enabled'))::BOOLEAN AS accepts_reservations,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "payments").options[*] ? (@.name == "Credit cards").enabled'))::BOOLEAN AS credit_cards,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "payments").options[*] ? (@.name == "Debit cards").enabled'))::BOOLEAN AS debit_cards,
    (jsonb_path_query_first(data, '$.about[*] ? (@.id == "payments").options[*] ? (@.name == "NFC mobile payments").enabled'))::BOOLEAN AS nfc_mobile_payments
FROM
    results
WHERE
    data->>'phone' IS NOT NULL AND data->>'phone' != ''
    AND data->>'address' IS NOT NULL AND data->>'address' != ''
    AND (data->>'review_count')::INTEGER > 0
    AND data->>'category' IS DISTINCT FROM 'Gas station';
