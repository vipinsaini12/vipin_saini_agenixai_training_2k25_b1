import requests
import psycopg2
from psycopg2 import sql

class WeatherDataLoader:
    def __init__(self, db_params, api_key):
        """Initialize database connection and API key."""
        self.api_key = api_key
        self.db_params = db_params
        try:
            self.conn = psycopg2.connect(**db_params)
            self.cursor = self.conn.cursor()
        except Exception as e:
            print(f"Error connecting to PostgreSQL: {e}")
            raise

    def fetch_weather_data(self, city):
        """Fetch weather data from OpenWeather API."""
        url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={self.api_key}&units=metric"
        try:
            response = requests.get(url)
            response.raise_for_status()  # Raises an HTTPError for bad responses (4xx, 5xx)
        except requests.exceptions.HTTPError as err:
            print(f"HTTP error occurred while fetching data for {city}: {err}")
            return None
        except requests.exceptions.RequestException as err:
            print(f"Request error occurred: {err}")
            return None

        # Check if the necessary fields exist in the response
        if response.status_code == 200:
            data = response.json()
            if "name" in data and "main" in data and "weather" in data and "wind" in data:
                weather_info = {
                    "city": data["name"],
                    "temperature": data["main"]["temp"],
                    "weather_description": data["weather"][0]["description"],
                    "humidity": data["main"]["humidity"],
                    "wind_speed": data["wind"]["speed"]
                }
                return weather_info
            else:
                print("Unexpected response format from the API.")
                return None
        else:
            print(f"Failed to fetch data for {city}. Status Code: {response.status_code}")
            return None

    def insert_into_db(self, weather_info):
        """Insert fetched data into PostgreSQL."""
        try:
            insert_query = sql.SQL("""
                INSERT INTO weather (city, temperature, weather_description, humidity, wind_speed)
                VALUES (%s, %s, %s, %s, %s);
            """)

            values = (
                weather_info["city"],
                weather_info["temperature"],
                weather_info["weather_description"],
                weather_info["humidity"],
                weather_info["wind_speed"]
            )

            self.cursor.execute(insert_query, values)
            self.conn.commit()
            print(f"Weather data for {weather_info['city']} inserted successfully!")
        except Exception as e:
            print(f"Error inserting data into the database: {e}")
            self.conn.rollback()  

    def close_connection(self):
        """Close the database connection."""
        try:
            self.cursor.close()
            self.conn.close()
        except Exception as e:
            print(f"Error closing the database connection: {e}")

if __name__ == "__main__":
   
    db_params = {
        "dbname": "weather_data",
        "user": "postgres",
        "password": "Vipinxyz",
        "host": "localhost",
        "port": "5432"
    }

    api_key = "583b8bfaa38461c270750a810b360c71"  

    # Initialize the WeatherDataLoader
    loader = WeatherDataLoader(db_params, api_key)

    # Fetch and Insert Data for a Sample City
    city_name = "Jaipur"
    weather_data = loader.fetch_weather_data(city_name)

    if weather_data:
        loader.insert_into_db(weather_data)

    # Close Database Connection
    loader.close_connection()