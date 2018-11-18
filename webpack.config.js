// webpack.config.js
const webpack = require('webpack')
const path = require('path')

module.exports = {
    entry: './app/javascript/packs/application.js',
    output: {
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                include: [ // use `include` vs `exclude` to white-list vs black-list
                    path.resolve(__dirname, "src"), // white-list your app source files
                    require.resolve("bootstrap-vue"), // white-list bootstrap-vue
                ],
                loader: "babel-loader"
            }
        ]
    }
}