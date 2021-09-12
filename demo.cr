require "annotations/request_mapping"
require "http/server"
require "annotations/get_mapping"
require "annotations/post_mapping"
require "annotations/entity"
require "controllers/rest_controller"
require "routes/route_handler"
require "http/response_entity"
require "http/http_status"
require "exec/start_server"
require "json"

@[Entity]
struct FooBar
  include JSON::Serializable
  property hi : String = "First Fennec default entity"

  def initialize
  end

  def initialize(@hi : String)
  end
end

@[RequestMapping("/foo")]
module Foo
  extend self
  include RestController


  @[GetMapping]
  def index : ResponseEntity(FooBar)
    ResponseEntity.new(FooBar.new("First Fennec foo restful api"), HttpStatus.ok)
  end
end

@[RequestMapping("/bar")]
module Bar
  extend self
  include RestController


  @[GetMapping]
  def index : ResponseEntity(FooBar)
    ResponseEntity.new(FooBar.new("First Fennec bar restful api"), HttpStatus.ok)
  end
end

StartServer.new.run
