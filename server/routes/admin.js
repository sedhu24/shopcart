var express = require("express");

const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Product = require("../models/product");

adminRouter.post("/admin/addproducts", admin, async (req, res) => {
  try {
    console.log("admin => Route => try");
    const { productName, description, images, quantity, price, category } =
      req.body;

    let product = new Product({
      productName,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();
    res.json(product);
  } catch (e) {
    console.log("admin => Route => catch");
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
