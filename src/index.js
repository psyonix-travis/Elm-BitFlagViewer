'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
var bigInt = require("big-integer");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);

app.ports.convertFlag.subscribe(function(request)
{
    //console.log(request);
    let response = Object.assign({}, request);
    let values = [];

    if ( request.flag.startsWith("0x") )
    {
      values = hexToArray( request.flag.substring(2) );
    }
    else
    {
      try {
        let intValue = bigInt(request.flag);
        for (let i = 0; i < 64; ++i)
        {
          let testValue = bigInt(1).shiftLeft(i);
          if (intValue.and(testValue) > 0)
          {
            values.push(i + 1)
          }
        }
      }
      catch(err) {
        console.log(err);
      }
    }

    response.values = values;
    //console.log(response);
    app.ports.flagConverted.send(response);
});

function hexToArray(value)
{
  let values = [];
  for (let i = value.length-1; i >= 0 ; --i)
  {
    let char = parseInt(value.charAt(i),16);
    if ( char == 0 )
    {
      continue;
    }

    values = values.concat( hexCharToOffset(((value.length - i - 1) * 4), char) );
  }
  return values;
}

function hexCharToOffset(offset, value)
{
  let values = [];
  for (let i = 0; i < 4; ++i)
  {
    if (value & 1<<i)
    {
      values.push(offset + i + 1)
    }
  }
  return values;
}
