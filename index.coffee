{spawn} = require 'child_process'
path = require 'path'
fs = require 'fs'
fibrous = require 'fibrous'

cmd = (cmd, args...) ->
  future = new fibrous.Future
  ps = spawn(cmd, args)
  stdout = []
  stderr = []
  ps.stdout.on 'data', (chunk) -> stdout.push(chunk)
  ps.stderr.on 'data', (chunk) -> stderr.push(chunk)
  ps.on 'exit', (code) ->
    if code == 0
      future.return stdout.join('')
    else
      error = new Error stderr.join('')
      future.throw error
  future

isSass = /\.(sass|scss)$/

exports.serve = (filename) ->
  dirname = path.dirname(filename)
  render = -> cmd 'sass', '--compass', filename

  rendered = render()

  fs.watch dirname, {persistent: false}, (ev, filename) ->
    rendered = render() if isSass.test filename

  (req, res, next) ->
    rendered.resolve (err, result) ->
      if err? then next() else res.end(result)
