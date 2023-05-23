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

productRouter.get(
  "/api/products/search/:productName",
  auth,
  async (req, res) => {
    try {
      // getting all the products i  need

      console.log(req.params.productName);
      const products = await Product.find({
        productName: { $regex: req.params.productName, $options: "i" },
      });
      res.json(products);
      // console.log(res.json(products));
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Post request route to rate the product
// productRouter.post("/api/rate-product", auth, async (req, res) => {
//   try {
//     const { id, rating } = req.body;
//     let product = await Product.findById({ id });
//     console.log(id);
//     console.log(" => " + rating);

//     console.log(" => " + product);

//     for (let i = 0; i < product.ratings.length; i++) {
//       if (product.ratings[i].userId == req.user) {
//         product.ratings.splice(i, 1);
//         break;
//       }
//     }

//     const ratingScheme = {
//       userId: req.user,
//       rating,
//     };

//     console.log(req.user);
//     product.ratings.push(ratingScheme);
//     product = await product.save();
//     res.json(product);
//   } catch (e) {
//     console.log("User Id : " + req.user);
//     res.status(500).json({ error: e.message });
//   }
// });

productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;

    console.log("=> " + id);
    console.log("=> " + rating);

    let product = await Product.findById(id);
    console.log("=> check");
    console.log(product);

    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    console.log("=> catch");
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
