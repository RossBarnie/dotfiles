local M = {}
M.settings = {
  yaml = {
    schemastore = {
      enable = false
    },
    schemas = require('schemastore').yaml.schemas(),
  },
  redhat = {
    telemetry = {
      enabled = false
    }
  }
}

return M
