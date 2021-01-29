const { environment } = require("@rails/webpacker");
const webpack = require("webpack");

// Makes $/jQuery global scope/window scope
environment.config.merge({
  module: {
    rules: [
      {
        test: require.resolve("jquery"),
        use: [
          {
            loader: "expose-loader",
            options: "$",
          },
          {
            loader: "expose-loader",
            options: "jQuery",
          },
        ],
      },
    ],
  },
});

module.exports = environment;
