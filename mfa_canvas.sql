-- table for canvasser responses

CREATE TABLE IF NOT EXISTS hvdsa.mfa_canvas (
    id SERIAL PRIMARY KEY,
    parcel_id int REFERENCES hvdsa.parcel,
    canvas text,
    --address text, -- this is redundant with the parcel table
    answer boolean,
    receptive int,
    comment text,
    time_stamp timestamptz DEFAULT NOW()
);