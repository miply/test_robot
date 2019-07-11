from http.server import BaseHTTPRequestHandler,HTTPServer
import re
class HttpProcessor(BaseHTTPRequestHandler):

    def check_IMSI(self,v):
        reg = re.compile('[a-zA-Z_0-9]')

        if((len(v)>=1 and len(v)<=15)and len(reg.sub('',v))==0):
            self.send_response(200)
            self.send_header('content-type', 'text/html')
            self.end_headers()
            self.wfile.write("200 OK".encode())
            #serv.server_close()
        else:
            self.send_response(500)
            self.send_header('content-type', 'text/html')
            self.end_headers()
            self.wfile.write("500 ERROR".encode())
            #serv.server_close()
    def do_GET(self):
        a=self.headers.items()
        v=''
        for name,val in a:
            if(name=="IMSI"):
                v=val
        if(v!=" "):
            self.check_IMSI(v)
        else:
            self.send_response(500)
            self.send_header('content-type', 'text/html')
            self.end_headers()

            self.wfile.write("500 ERROR".encode())
            #serv.server_close()

try:
    serv = HTTPServer(("localhost",80),HttpProcessor)
    print('the server is running, use <Ctrl-C> to stop')
    serv.serve_forever()
except KeyboardInterrupt:
    print("the server is stopped")







