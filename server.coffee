#  server.js does serveral things
#  1. configure our application
#  2. connect to our database
#  3. create our mongoose models
#  4. define routes for our restful api
#  5. define routes for our frontend angular application
#  6. set the app to listen on a port so we can view it in our browser

require('coffee-script/register')

express     = require('express')
app         = express()
bodyParser  = require('body-parser')
mongoose    = require('mongoose')

# Databse
mongoose.connect('mongodb://localhost/develop')

# Create a Todo Model
Todo = mongoose.model('Todo', {
  text: String
})


# configuration
app.use(express.static(__dirname + '/public'))
app.use(bodyParser())

# Routes
app.get('/api/todos', (req, res) ->
  Todo.find((err, todos) ->
    return res.end(err) if err
    res.json(todos)
  )
)

app.post('/api/todos', (req, res) ->
  Todo.create({
    text: req.body.text,
    done: false
  }, (err, todo) ->
    return res.send(err) if err
    Todo.find((err, todos) ->
      return res.send(err) if err
      res.json(todos)
    )
  )
)

app.delete('/api/todos/:todo_id', (req, res) ->
  Todo.remove({
    _id: req.params.todo_id
  }, (err, todo) ->
    return res.send(err) if err
    Todo.find((err, todos) ->
      return res.send(err) if err
      res.json(todos)
    )
  )
)


# Angualr the frontend
app.get('*', (req, res) ->
  res.sendfile('./public/index.html')
)

app.listen(3000)

console.log('App listening on port 3000')
