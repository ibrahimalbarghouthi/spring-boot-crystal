class StartServer

  def initialize
    @route_handler = RouteHandler.new
  end

  def run
    server = HTTP::Server.new do |context|
      case context.request.method
      when "GET"
        pp context.request.path
        action = @route_handler.check_get_path(context.request.path)
      else
        context.response.content_type = "text/plain"
        context.response.print "Not Implmented method yet!"
        next
      end

      action_response = action.try(&.execute([] of Nil))

      if action_response
        context.response.content_type = "application/json; charset=utf-8"
        context.response.print action_response.@response.to_json
        context.response.status_code = action_response.@http_status.value
      end
    rescue
      context.response.content_type = "text/plain"
      context.response.print "404 Not Found"
      context.response.status_code = 404
    end

    address = server.bind_tcp 8080
    puts "Listening on http://#{address}"
    server.listen
  end
end
