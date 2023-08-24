var express = require("express");

const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

// fetch order for user

userRouter.get("/api/orders/my", auth, async (req, res) => {
  try {
    console.log("user => Route => catch => Order => 13  ");
    const orders = await Order.find({ userId: req.user });
    console.log("user => Route => catch => Order => 15  ");

    res.json(orders);
    console.log("user => Route => catch => Order => 18  ");
  } catch (e) {
    console.log("user => Route => catch => Order => error  ");
    res.status(500).json({ error: e.message });
  }
});

// save address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log("user => Route => catch => SaveAddress => error  ");
    res.status(500).json({ error: e.message });
  }
});

// order product

userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;

    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res
          .status(400)
          .json({ msg: `${product.name} is out of Stock!` });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    console.log("user => Route => catch => Order => error  ");

    res.status(500).json({ error: e.message });
  }
});

// add to cart api service

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);

    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;

      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
          console.log(isProductFound);
        }
      }

      if (isProductFound) {
        console.log("====> 30");
        let producttt = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );

        producttt.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log("admin => Route => catch => error ");
    res.status(500).json({ error: e.message });
  }
});

// /api/remove-from-cart/${product.id}

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log("admin => Route => catch => error ");
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
