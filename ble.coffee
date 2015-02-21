module.exports = (env) ->
  Promise = env.require 'bluebird'
  convict = env.require "convict"
  assert = env.require 'cassert'
  
  noble = require "noble"
  events = require "events"

  class BLEPlugin extends env.plugins.Plugin
    init: (app, @framework, @config) =>
      @devices = []
      @peripheralNames = []

      @noble = require "noble"
      setInterval( =>
        if @devices?.length > 0
          env.logger.debug "Scan for devices"
          env.logger.debug @devices
          @noble.startScanning([],true)
      , 10000)

      @noble.on 'discover', (peripheral) =>
        if (@peripheralNames.indexOf(peripheral.advertisement.localName) >= 0)
          env.logger.debug "Device found "+ peripheral.uuid
          @noble.stopScanning()
          @emit "discover", peripheral

      @noble.on 'stateChange', (state) =>
        if state == 'poweredOn'
          @noble.startScanning([],true)

    registerName: (name) =>
      env.logger.debug "Registering peripheral name "+name
      @peripheralNames.push name

    addOnScan: (uuid) =>
      env.logger.debug "Adding device "+uuid
      @devices.push uuid

    removeFromScan: (uuid) =>
      env.logger.debug "Removing device "+uuid
      @devices.splice @devices.indexOf(uuid), 1

  plugin = new BLEPlugin
  return plugin
