#!/usr/bin/python3
from http.server import BaseHTTPRequestHandler,HTTPServer

PORT_NUMBER = 8070

#This class will handles any incoming request from
#the browser 
class myHandler(BaseHTTPRequestHandler):
    #Handler for the GET requests
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        # Send the html message
        message = "Hello World!"
        # Write content as utf-8 data
        self.wfile.write(bytes(message, "utf-8"))
        return

try:
    #Create a web server and define the handler to manage the
    #incoming request
    server_address = ('0.0.0.0', PORT_NUMBER)

    httpd = HTTPServer(server_address, myHandler)
    print('Started httpserver on port ' , PORT_NUMBER)
	
    #Wait forever for incoming htto requests
    httpd.serve_forever()

except KeyboardInterrupt:
    print('^C received, shutting down the web server')
    httpd.socket.close()


