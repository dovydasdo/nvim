local ls = require 'luasnip'

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require 'luasnip.util.types'
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'
local snips = require 'go.snips'

local in_test_fn = {
  show_condition = snips.in_test_function,
  condition = snips.in_test_function,
}

local in_test_file = {
  show_condition = snips.in_test_file_fn,
  condition = snips.in_test_file_fn,
}

local in_fn = {
  show_condition = snips.in_function,
  condition = snips.in_function,
}

local not_in_fn = {
  show_condition = snips.in_func,
  condition = snips.in_func,
}

local function copy(args)
  return args[0]
end

local snippets = {
  s(
    { trig = 'scf', name = 'scan file', descr = 'scan a file line by line' },
    fmt(
      [[
        {fname}, err {isNew}= os.Open({fpath})
        if err != nil {{
          {retErr}
        }}
        defer {fnameClose}.Close()
        {scanner} := bufio.NewScanner({fnameScan})
        for {scannerScan}.Scan() {{
          {scanLoop}
        }}
      ]],
      {
        fname = ls.i(1, { 'fname' }),
        isNew = ls.i(2, { ':' }),
        fpath = ls.i(3, { 'fname.txt' }),
        retErr = ls.i(4, { 'return err' }),
        fnameClose = rep(1),
        fnameScan = rep(1),
        scanner = ls.i(5, { 'scanner' }),
        scannerScan = rep(5),
        scanLoop = ls.i(6, { '' }),
      }
    ),
    in_fn
  ),
}

ls.add_snippets('all', snippets)
