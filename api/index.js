const app = require('./app')
const db = require('./config/db')

const port = 3001

app.listen(port, () => {
  console.log(`Server Listening on http://localhost:${port}`);
})
