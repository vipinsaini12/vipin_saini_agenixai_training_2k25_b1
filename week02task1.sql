CREATE TABLE weather (
    id SERIAL PRIMARY KEY,
    city VARCHAR(50),
    temperature FLOAT,
    weather_description TEXT,
    humidity INT,
    wind_speed FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM weather;