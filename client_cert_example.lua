#! /usr/bin/tarantool

local log = require('log')
local websocket = require('websocket')
local ssl = require('websocket.ssl')
local json = require('json')

local ctx = ssl.ctx()
if not ssl.ctx_use_private_key_file(ctx, './certificate.pem') then
    log.info('Error private key')
    return
end

if not ssl.ctx_use_certificate_file(ctx, './certificate.pem') then
    log.info('Error certificate')
    return
end

--local function connect(url, ctx)
--    local ws, err = websocket.connect(url, nil, {timeout = 3, ssl = ctx})
--    if not ws then error(err) end
--    return ws
--end
--local ws = connect('wss://localhost:8445', ctx)
local ws, err = websocket.connect(
    'wss://localhost:8445', nil, {timeout = 3, ssl = ctx})

if not ws then
    log.info(err)
    return
end

--ws:write('HELLO')
local response = ws:read()
log.info(response)
assert(response.data == 'HELLO')
