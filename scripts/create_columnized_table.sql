CREATE TABLE business_summary (
    id SERIAL PRIMARY KEY,
    original_id INTEGER,
    title TEXT,
    phone TEXT,
    owner_name TEXT,
    address TEXT,
    category TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    review_rating DOUBLE PRECISION,
    review_count INTEGER,
    curbside_pickup BOOLEAN,
    takeout BOOLEAN,
    dine_in BOOLEAN,
    delivery BOOLEAN,
    wheelchair_accessible_entrance BOOLEAN,
    wheelchair_accessible_parking_lot BOOLEAN,
    wheelchair_accessible_restroom BOOLEAN,
    wheelchair_accessible_seating BOOLEAN,
    alcohol BOOLEAN,
    beer BOOLEAN,
    coffee BOOLEAN,
    wine BOOLEAN,
    lunch BOOLEAN,
    dinner BOOLEAN,
    dessert BOOLEAN,
    seating BOOLEAN,
    accepts_reservations BOOLEAN,
    credit_cards BOOLEAN,
    debit_cards BOOLEAN,
    nfc_mobile_payments BOOLEAN
);
