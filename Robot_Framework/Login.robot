*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Variables   variables.py

# *** Variables ***
# ${user-name}    standard_user
# ${password}     secret_sauce

*** Test Cases ***
Login
    Open Browser                        https://www.saucedemo.com/          chrome
    Maximize Browser Window
    Wait Until Element Is Visible       id:user-name
    Input Text                          id:user-name                        ${User.username}
    Input Password                      id:password                         ${User.password}
    Click Element                       id:login-button
    Sleep                               5s
    Close Browser

Do a GET Request and validate the response code and response body
    [tags]  Smoke
    Create Session  mysession  https://pokeapi.co/api/v2  verify=true
    ${response}=  GET On Session  mysession  /pokemon/ditto
    Status Should Be  200  ${response}  #Check Status as 200

#    #Check Title as London from Response Body
#    ${title}=  Get Value From Json  ${response.json()}[0]  title
#    ${titleFromList}=  Get From List   ${title}  0
#    Should be equal  ${titleFromList}  London
#
#    #Check location_type is present in the repsonse body
#    ${body}=  Convert To String  ${response.content}
#    Should Contain  ${body}  location_type
    ${name}=    Get Value From Json    ${response.json()}    name
    Should Be Equal    ${name}[0]    ditto