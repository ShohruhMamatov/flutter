const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const logger = require("firebase-functions/logger");

// Task 7: HTTP-triggered function
exports.helloWorld = onRequest((request, response) => {
  logger.info("Hello World function called!", {structuredData: true});

  response.json({
    message: "Hello from Firebase!",
    timestamp: new Date().toISOString(),
    status: "success",
    request_method: request.method,
    user_agent: request.get("user-agent"),
  });
});

// Task 8: Firestore-triggered function
exports.onMessageCreated = onDocumentCreated(
    "messages/{docId}",
    (event) => {
      const snapshot = event.data;

      if (!snapshot) {
        logger.info("No data associated with the event");
        return;
      }

      const data = snapshot.data();

      logger.info("New message created!", {
        docId: event.params.docId,
        text: data.text,
        createdAt: data.createdAt,
        timestamp: new Date().toISOString(),
      });

      return null;
    },
);

// Optional: HTTP function to get all messages
exports.getMessages = onRequest(async (request, response) => {
  const admin = require("firebase-admin");

  if (!admin.apps.length) {
    admin.initializeApp();
  }

  try {
    const snapshot = await admin.firestore()
        .collection("messages")
        .orderBy("createdAt", "desc")
        .limit(10)
        .get();

    const messages = [];
    snapshot.forEach((doc) => {
      messages.push({
        id: doc.id,
        ...doc.data(),
      });
    });

    response.json({
      success: true,
      count: messages.length,
      messages: messages,
    });
  } catch (error) {
    logger.error("Error getting messages:", error);
    response.status(500).json({
      success: false,
      error: error.message,
    });
  }
});