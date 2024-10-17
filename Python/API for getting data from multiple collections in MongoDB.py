from flask import Flask, Response
from pymongo import MongoClient
import xml.etree.ElementTree as ET

app = Flask(__name__)
client = MongoClient('mongodb://localhost:27017/')
db = client['local']

# Get the list of collections in the database
collection_names = db.list_collection_names()
print(collection_names)

def dict_to_xml(data):
    # Convert dict to XML and handle nested structures
    def build_xml_element(key, val):
        elem = ET.Element(key)
        if isinstance(val, dict):  # If the data is in dict format
            for sub_key, sub_val in val.items():
                elem.append(build_xml_element(sub_key, sub_val))
        elif isinstance(val, list):  # If the data is in list format
            for item in val:
                elem.append(build_xml_element(key[:-1], item))
        else:  # For simple values
            elem.text = str(val)
        return elem

    # Create root based on the first document's structure
    root = None
    for key, val in data.items():
      root = build_xml_element(key, val)
      break
    return root 

@app.route('/<collection_name>', methods=['GET'])
def fetch_collection_data(collection_name):
    try:
        if collection_name not in collection_names:
            return Response('<error>Collection not found</error>', content_type='application/xml'), 404

        # Retrieve all documents from the specified collection
        collection = db[collection_name]
        documents = list(collection.find({}, {'_id': 0}))

        if len(documents) == 0:
            return Response('<error>No documents found</error>', content_type='application/xml'), 404

        # Converting to XML
        xml_root = dict_to_xml(documents[0])

        # Generate the XML string
        xml_data = ET.tostring(xml_root, encoding='utf-8', method='xml')

        # Return XML with appropriate content
        return Response(xml_data, content_type='application/xml'), 200

    except Exception as e:
        error_elem = ET.Element('Error')
        error_elem.text = str(e)
        error_xml = ET.tostring(error_elem, encoding='utf-8', method='xml')
        return Response(error_xml, content_type='application/xml'), 500

if __name__ == '__main__':
    app.run(debug=True)
