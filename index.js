require('./index.html')
const Elm = require('./src/Cats.elm')

const mountNode = document.getElementById('main')

Elm.Main.embed(mountNode)