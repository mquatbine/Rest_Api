const jsonServer = require('json-server')
const cors = require('cors')

// Create server
const server = jsonServer.create()

// Default middlewares
const middlewares = jsonServer.defaults()

// Create router
const router = jsonServer.router('db.json')

// Add cors and other middlewares
server.use(cors())
server.use(middlewares)
server.use(router)

// Define port
const PORT = process.env.PORT || 3001

// Start server
server.listen(PORT, () => {
  console.log(`JSON Server is running on port ${PORT}`)
})