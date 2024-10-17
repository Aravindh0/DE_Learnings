from flask import Flask, Response
from pymongo import MongoClient
import xml.etree.ElementTree as ET

app = Flask(__name__)
client = MongoClient('mongodb://localhost:27017/')
db = client['local']
collection = db['sample']

def dict_to_xml(data):
  #Convert dict to xml and handling nested structures
  def build_xml_element(key, val):
    elem = ET.Element(key)
    if isinstance(val, dict): #If the data is in dict format
      for sub_key, sub_val in val.items():
        elem.append(build_xml_element(sub_key, sub_val))
    elif isinstance(val, list): #If the data is in list format
      for item in val:
        elem.append(build_xml_element(key[:-1], item))
    else: 
      elem.text = str(val)
    return elem
  #Getting keys which is the top level keys on  MongoDB
  root = None
  for key, val in data.items():
    root = build_xml_element(key, val)
    break
  return root


@app.route('/', methods = ['GET'])
def fetch_all_data():
  try:
      #Retrive all documents from the collections
      documents = list(collection.find({}, {'_id': 0}))

      if len(documents) == 0:
        return Response('<error>No documents found</error>', content_type = 'application/xml'),404
         
      #Converting to XML
      xml_root = dict_to_xml(documents[0])

      #Generate the XML string
      xml_data = ET.tostring(xml_root, encoding = 'utf-8', method = 'xml')

      #Return XML with appropriate content
      return Response (xml_data, content_type = 'application/xml'), 200
  except Exception as e:
    error_elem = ET.Element('Error')
    error_elem.text = str(e)
    error_xml = ET.tostring(error_elem, encoding='utf-8', method='xml')
    return Response(error_xml, content_type='application/xml'), 500
        
if __name__ == '__main__':
    app.run(debug=True)