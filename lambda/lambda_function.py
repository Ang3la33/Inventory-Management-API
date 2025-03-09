import json
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        logger.info(f"Received event: {json.dumps(event)}") 
        
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            "body": json.dumps({"message": "Inventory API is running!"})
        }
    except Exception as e:
        logger.error(f"Error: {str(e)}")  
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
