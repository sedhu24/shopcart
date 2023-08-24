const mongoose = require("mongoose");
const { productsScheme } = require("./product");

const orderScheme = mongoose.Schema({
  products: [
    {
      product: productsScheme,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],

  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId: {
    required: true,
    type: Number,
  },
  orderedAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,

    default: 0,
  },
});

const Order = mongoose.model("Order", orderScheme);
module.exports = Order;

// 0 - pending / placed ordered
// 1 - completed
// 2 - received
// 3 - delivered
