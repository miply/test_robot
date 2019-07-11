*** Settings ***
Documentation   This test cases for  check http server.
...  Answers 200 OK if the incoming request has a header IMSI satisfying the condition: 
...  length from 1 to 15 inclusive containing letters, numbers and _, otherwise 500\n.

Library   RequestsLibrary
Library   BuiltIn
Library   OperatingSystem
Test Template    Run Server

*** Variables ***
${IMSI_ALIAS}    imsi
${HTTP_ADRESS}   http://127.0.0.1
${IMSI}   IMSI
${empty}


*** Test Cases ***
Test title
    [Template]  Run Server

        #Key      Value                 Response
        ${IMSI}  4343fdf_f343           200
        Accept   json/xml               500
        ${IMSI}  _                      200
        ${IMSI}  1234567890abc_H        200
        ${IMSI}  ?><><_FDFDff43         500
        ${IMSI}  ${empty}               500




*** Keywords ***
Run Server
    [Arguments]  ${arg1}  ${arg2}  ${arg3}
    RequestsLibrary.Create Session   ${IMSI_ALIAS}  ${HTTP_ADRESS}
    ${headers}    create dictionary  ${arg1}=${arg2}
    ${response}   RequestsLibrary.Get Request   ${IMSI_ALIAS}  /  headers=${headers}
    #log to console   ${response.status_code}
    should be equal  '${response.status_code}'  '${arg3}'
    ...   msg=Error from response:${response.text}   values=False

