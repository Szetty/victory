require "victory/version"
require 'require_all'

module Victory
  class Error < StandardError; end
  # Your code goes here...
end

module Algorithms; end
module Containers; end

require 'XORList'

require_all 'lib/**/*rb'
