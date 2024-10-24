# Wallet Service

## API Endpoints

### 1. Create Transaction

- **Endpoint**: `POST /transactions`
- **Description**: Create the transactions.
- **Parameters**:
  - `debit_id`: The debit wallet id. This field is optional depends on the operation type
  - `credit_id`: The credit wallet id. This field is optional depends on the operation type
  - `amount`: The transaction amount
  - `operation_type`: The operation type (`TOP-UP`, `TRANSFER`)
- **Headers**"
  - `Authorization`: The authorization token
- **Response**: 
  ```json
  {
    "message": "OK",
    "data": null,
    "status_code": 200
  }

### 2. Get Entity Details

- **Endpoint**: `POST /entity`
- **Description**: Get the entity details.
- **Headers**"
  - `Authorization`: The authorization token
- **Response**: 
  ```json
  {
    "message": "OK",
    "data": {
        "entity": {
            "id": 5,
            "name": "test",
            "email": "test@gmail.com"
        },
        "wallet": {
            "id": 3,
            "balance": 0.0
        }
    },
    "status_code": 200
  }

### 3. Sign In

- **Endpoint**: `POST /login`
- **Description**: Create the authentication.
- **Parameters**:
  - `name`: The entity name
  - `email`: The entity email
  - `password`: The entity password
- **Response**: 
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbnRpdHlfaWQiOjUsImV4cCI6MTcyOTg0MDU0M30=.58383cbca3cc48976b3c2c77bf77ca3a289a48ae7b3e8c21d21e6b32d5653d32",
    "exp": "2024-10-25T07:15:43.266Z"
  }

### 4. Get Stock Prices

- **Endpoint**: `POST /stocks/prices`
- **Description**: Get stock prices.
- **Parameters**:
  - `Identifier`: The stock identifier
- **Response**: 
  ```json
  [
    {
        "identifier": "NIFTY 50",
        "change": -43.150000000001455,
        "dayHigh": 24480.65,
        "dayLow": 24341.2,
        "lastPrice": 24392.35,
        "lastUpdateTime": "24-Oct-2024 13:55:53",
        "meta": {
            "companyName": null,
            "industry": null,
            "isin": null
        },
        "open": 24412.7,
        "pChange": -0.18,
        "perChange30d": -5.11,
        "perChange365d": 26.92,
        "previousClose": 24435.5,
        "symbol": "NIFTY 50",
        "totalTradedValue": 197270925862.73,
        "totalTradedVolume": 150545737,
        "yearHigh": 26277.35,
        "yearLow": 18926.65
    }
  ]