const mongoose = require("mongoose");
const ratingScheme = require("./rating");

const productsScheme = mongoose.Schema({
  productName: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    required: true,
    type: String,
    trim: true,
  },
  images: [
    {
      required: true,
      type: String,
    },
  ],
  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  ratings: [ratingScheme],
});

const Product = mongoose.model("Products", productsScheme);

module.exports = { Product, productsScheme };
