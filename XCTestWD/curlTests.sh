
export JSON_HEADER='-H "Content-Type:application/json"'
export DEVICE_URL='http://127.0.0.1:8001'

TagHead() {
  echo "\n#### $1 ####"
}

#Session: create session

TagHead "Create Session"

curl -X POST $JSON_HEADER \
-d "{\"desiredCapabilities\":{\"deviceName\":\"iPhone 6\",\"platformName\":\"iOS\", \"bundleId\":\"xudafeng.ios-app-bootstrap\",\"autoAcceptAlerts\":false}}" \
$DEVICE_URL/wd/hub/session \

### Read session as input for next stage testing

echo "\n\ninput the sessionID generated:\n"
read sessionID

#Session: query sessions

TagHead "Query Session"

curl -X GET $JSON_HEADER \
$DEVICE_URL/wd/hub/sessions \

#Session: checkon source

TagHead "Check Source"

# curl -X GET $JSON_HEADER \
# $DEVICE_URL/session/$sessionID/source \

curl -X GET $JSON_HEADER \
$DEVICE_URL/source \

#Session: checkon accessible source

TagHead "Check Accessiblility"

# curl -X GET $JSON_HEADER \
# $DEVICE_URL/session/$sessionID/source \

curl -X GET $JSON_HEADER \
$DEVICE_URL/accessibleSource \


TagHead "Check Window Size"

curl -X GET $JSON_HEADER \
$DEVICE_URL/wd/hub/session/$sessionID/window/current/size

TagHead "Element"

# curl -X POST $JSON_HEADER \
# -d "{\"using\":\"xpath\",\"value\":\"//XCUIElementTypeTextField[1]\"}" \
# $DEVICE_URL/element \
#
# curl -X POST $JSON_HEADER \
# -d "{\"using\":\"name\",\"value\":\"Login\"}" \
# $DEVICE_URL/element \

curl -X POST $JSON_HEADER \
-d "{\"using\":\"class name\",\"value\":\"XCUIElementTypeTextField\"}" \
$DEVICE_URL/element \

TagHead "Elements"

curl -X POST $JSON_HEADER \
-d "{\"using\":\"xpath\",\"value\":\"//XCUIElementTypeOther\"}" \
$DEVICE_URL/elements \


TagHead "Element Value"

curl -X POST $JSON_HEADER  \
$DEVICE_URL/element/mockElementId/value \


#Session: delete session by ID

TagHead "Delete Session By ID"

curl -X DELETE $JSON_HEADER \
$DEVICE_URL/wd/hub/session/$sessionID \
