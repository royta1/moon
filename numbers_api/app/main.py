from fastapi import FastAPI
import random

app = FastAPI()

@app.get("/odd")
def random_odd():
    return random.choice([num for num in range(1, 20) if num % 2 != 0])

@app.get("/even")
def random_even():
    return random.choice([num for num in range(1, 20) if num % 2 == 0])

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=80)