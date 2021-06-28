const { Router } = require("express");
const router = Router();

const admin = require("firebase-admin");
const db = admin.firestore();

// Create
router.post("/api/schedulemanagement", async (req, res) => {
  try {
    await db
      .collection("schedulemanagement")
      .doc("/" + req.body.id + "/")
      .create({ name: req.body.name });
    return res.status(200).json();
  } catch (error) {
    return res.status(500).send(error);
  }
});

router.get("/api/schedulemanagement/:schedulemanagement_id", (req, res) => {
  (async () => {
    try {
      const doc = db.collection("schedulemanagement").doc(req.params.product_id);
      const item = await doc.get();
      const response = item.data();
      return res.status(200).send(response);
    } catch (error) {
      return res.status(500).send(error);
    }
  })();
});

router.get("/api/schedulemanagement", async (req, res) => {
  try {
    let query = db.collection("schedulemanagement");
    const querySnapshot = await query.get();
    let docs = querySnapshot.docs;

    const response = docs.map((doc) => ({
      id: doc.id,
      UserName: doc.data().UserName,
      PassWord: doc.data().PassWord
    }));

    return res.status(200).json(response);
  } catch (error) {
    return res.status(500).json(error);
  }
});

router.put("/api/schedulemanagement/:schedulemanagement_id", async (req, res) => {
  try {
    const document = db.collection("schedulemanagement").doc(req.params.product_id);
    await document.update({
      name: req.body.name,
    });
    return res.status(200).json();
  } catch (error) {
    return res.status(500).json();
  }
});

router.delete("/api/schedulemanagement/:schedulemanagement_id", async (req, res) => {
  try {
    const doc = db.collection("schedulemanagement").doc(req.params.product_id);
    await doc.delete();
    return res.status(200).json();
  } catch (error) {
    return res.status(500).send(error);
  }
});

module.exports = router;
