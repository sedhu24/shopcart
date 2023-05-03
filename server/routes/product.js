var express = require("express");

const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

// /api/products?category=Essential
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);

    // getting all the products i  need
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get request for search products

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    // getting all the products i  need
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
