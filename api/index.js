const app = require('./app')

const port = 3001;

app.get('/', (req,res) => {
    res.send('Welcome to edeal app')
})

app.listen(port, () => {
    console.log(`Listening at http://localhost:${port}`)
})