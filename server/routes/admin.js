var express = require("express");

const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
const e = require("express");

// change Order Status

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    // const { id, status } = req.body;

    // console.log(status);
    // let order = await Order.findById(id);
    // order.status = status;
    // order = await order.save();
    // res.json(order);
    // console.log(order);

    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
    console.log(order);
  } catch (error) {
    console.log("admin services => order => change status => 19");
    res.status(500).json({ error: e.message });
  }
});

// list Orders

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    console.log("admin => Route => get-orders ");
    const order = await Order.find({});
    res.json(order);
  } catch (error) {
    console.log("admin => Route => get-orders ");
    res.status(500).json({ error: e.message });
  }
});

// upload products
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

// get all products
// /admin/get-products

adminRouter.get("/admin/getproducts", admin, async (req, res) => {
  try {
    // getting all the products i  need
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// delete a product  Api

adminRouter.post("/admin/deleteproducts", admin, async (req, res) => {
  // delete a product
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);

    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
