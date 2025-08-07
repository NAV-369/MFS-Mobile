from flask import jsonify
from app import mongo
from . import api_bp

@api_bp.route('/health')
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'database': 'connected' if mongo.db.command('ping') else 'disconnected'
    })

@api_bp.route('/test')
def test_connection():
    """Test database connection"""
    try:
        # Test database connection
        mongo.db.command('ping')
        return jsonify({
            'status': 'success',
            'message': 'Successfully connected to MongoDB!',
            'database': mongo.db.name,
            'collections': mongo.db.list_collection_names()
        })
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 500
