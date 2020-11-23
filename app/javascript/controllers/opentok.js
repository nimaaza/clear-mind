const handleError = (error) => {
  if (error) console.log(error.message);
};

const initializeSession = (apiKey, sessionId, token) => {
  const session = OT.initSession(apiKey, sessionId);

  // Initialize a Publisher, and place it into the element with id="publisher"
  const publisher = OT.initPublisher('publisher', {
      insertMode: 'append',
  }, handleError);

  session.on({
    // This function runs when session.connect() asynchronously completes
    sessionConnected: (event) => {
      session.publish(publisher, handleError);
    },
    // This function runs when another client publishes a stream (eg. session.publish())
    streamCreated: (event) => {
      session.subscribe(event.stream, 'subscriber', {
          insertMode: 'append',
      }, handleError);
    }
  });

  // Connect to the Session using a 'token'
  session.connect(token, handleError);
};

const initOpenTok = () => {
  const openTokApiData = document.getElementById('opentok-api-data').dataset;
  if (openTokApiData)
    initializeSession(openTokApiData.apiKey, openTokApiData.sessionId, openTokApiData.token);
};

export { initOpenTok };
