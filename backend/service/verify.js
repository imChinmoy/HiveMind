import admin from "../src/config/firebase.js";

(async () => {
  const user = await admin.auth().createUser({
    email: "test@demo.com",
    password: "password123",
  });

  console.log("Firebase user created:", user.uid);
})();
