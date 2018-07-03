require('./index.html')
const Elm = require('./src/Hello.elm')

const mountNode = document.getElementById('main')

Elm.Main.embed(mountNode)