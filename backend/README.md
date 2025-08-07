# MFS Mobile Backend

A Flask-based backend service for the MFS Mobile application, using MongoDB for data storage.

## Project Structure

```
backend/
├── app/
│   ├── __init__.py         # Application factory
│   ├── api/                # API routes and controllers
│   │   ├── __init__.py
│   │   └── routes.py
│   ├── models/             # Database models
│   └── utils/              # Utility functions
├── tests/                  # Test files
├── .env.example           # Environment variables template
├── .gitignore
├── requirements.txt       # Python dependencies
└── run.py                # Application entry point
```

## Prerequisites

- Python 3.8+
- MongoDB Atlas account or local MongoDB instance
- pip (Python package manager)

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd MFS-Mobile/backend
   ```

2. **Create and activate a virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   Update the `.env` file with your MongoDB connection string and other configurations.

5. **Run the application**
   ```bash
   # Development mode
   flask run
   
   # Or using Python directly
   python run.py
   ```

6. **Verify the application is running**
   - Open http://localhost:5000 in your browser
   - Or check the health endpoint: http://localhost:5000/api/health

## API Endpoints

- `GET /` - Welcome message
- `GET /api/health` - Health check
- `GET /api/test` - Test database connection

## Development

### Running Tests
```bash
pytest
```

### Code Formatting
```bash
# Auto-format code
black .

# Check code style
flake8
```

### Environment Setup
- Create a `.env` file based on `.env.example`
- Set `FLASK_ENV=development` for development
- Set `FLASK_ENV=production` for production

## Deployment

For production deployment, consider using:
- Gunicorn as the WSGI server
- Nginx as a reverse proxy
- Process manager like PM2 or systemd

## License

[Your License Here]
