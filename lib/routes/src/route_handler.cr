require "json"

WILDCARD = "wild*** param ***wild"

abstract struct ActionBase
  include JSON::Serializable
end

class NoRouteError404 < Exception
end

struct ActionMethod(ActionType, ReturnType, ArgTypeTuple) < ActionBase
  include JSON::Serializable

  @weight = 0

  @[JSON::Field(ignore: true)]
  @action : ActionType

  def initialize(@action : ActionType, _return_type : ReturnType.class, _arg_types : ArgTypeTuple.class)
  end

  @[JSON::Field]
  def return_type : ReturnType.class
    ReturnType
  end

  def execute(arguments : Array) : ReturnType
    @action.call.call *{{ArgTypeTuple.type_vars.empty? ? "Tuple.new".id : ArgTypeTuple}}.from arguments
  end

  def get_action
    @action
  end

  def get_weight
    @weight
  end

  def set_weight(val)
    @weight = val
  end
end

class RouteNode
  include JSON::Serializable

  def initialize(@action_method : ActionBase?, @param : String, @next_hash : Hash(String, RouteNode)?)
  end

  def get_action_method
    @action_method
  end

  def set_next_hash(next_hash : Hash(String, RouteNode))
    @next_hash = next_hash
  end
end

class RouteHandler
  @get_routes = Hash(String, RouteNode).new
  @get_template_routes = Hash(String, ActionBase).new
  @post_routes = Hash(String, ActionBase).new

  def initialize
    {% for c in RestController.includers %}
      pp {{c}}
      {% cont_method = c.annotation(RequestMapping)[0] %}
      {% for m in c.methods.select { |m| m.annotation(GetMapping) || m.annotation(PostMapping) || m.annotation(PutMapping) || m.annotation(RequestMapping) } %}
      {% arg_types = m.args.map &.restriction %}

        {% if d = m.annotation(GetMapping) %}
          add_route(@get_routes, {{cont_method}} + {{d[0] || ""}},
                    ActionMethod.new(action: ->{ ->{{c}}.{{m.name.id}}{% unless m.args.empty? %}({{arg_types.splat}}){% end %}},
                                     _return_type: {{m.return_type}},
                                     _arg_types: {{arg_types.empty? ? "typeof(Tuple.new)".id : "Tuple(#{arg_types.splat})".id}}))
        {% elsif d = m.annotation(PostMapping) %}
          add_post_route({{cont_method}} + {{d[0] || ""}}, ActionMethod.new(action: -> { ->{{c}}.{{m.name.id}} },
                                                                            _return_type: {{m.return_type}},
                                                                            _arg_types: {{arg_types.empty? ? "typeof(Tuple.new)".id : "Tuple(#{arg_types.splat})".id}}))
        {% elsif d = m.annotation(RequestMapping) %}
          {% if d[:method] == "GET" %}
            add_route(@get_routes, {{cont_method}} + {{d[:path] || ""}}, ActionMethod.new(action: ->{ ->{{c}}.{{m.name.id}} },
                                                                                          _return_type: {{m.return_type}},
                                                                                          _arg_types: {{arg_types.empty? ? "typeof(Tuple.new)".id : "Tuple(#{arg_types.splat})".id}}))
          {% elsif d[:method] == "POST" %}
            add_post_route({{cont_method}} + {{d[0] || ""}}, ActionMethod.new(action: ->{ ->{{c}}.{{m.name.id}} },
                                                                              _return_type: {{m.return_type}},
                                                                              _arg_types: {{arg_types.empty? ? "typeof(Tuple.new)".id : "Tuple(#{arg_types.splat})".id}}))
          {% end %}
        {% end %}
      {% end %}
    {% end %}
  end

  def add_route(routes : Hash(String, RouteNode), path : String, action : ActionMethod)
    path_entries = path.strip.split("/").reject { |path_entry| path_entry.empty? }.map_with_index { |path_entry, idx| {entry: path_entry.gsub(/{.*}/, WILDCARD), param: path_entry, index: idx} }
    action.set_weight(path_entries.select { |x| x[:entry] == WILDCARD }.size)
    if path_entries.size == 0
      routes["/"] = RouteNode.new(action_method: action, param: "", next_hash: nil)
    else
      if path_entries.size == 1
        if !routes.has_key?(path_entries[0][:entry])
          routes[path_entries[0][:entry]] = RouteNode.new(action_method: action, param: path_entries[0][:param], next_hash: nil)
        end
      else
        if routes.has_key?(path_entries[0][:entry]) && routes[path_entries[0][:entry]].@next_hash.nil?
          routes[path_entries[0][:entry]].set_next_hash(Hash(String, RouteNode).new)
        elsif !routes.has_key?(path_entries[0][:entry])
          routes[path_entries[0][:entry]] = RouteNode.new(action_method: nil, param: path_entries[0][:entry], next_hash: Hash(String, RouteNode).new)
        end

        weight = path_entries[0][:entry] == WILDCARD ? 1 : 0

        path_entries.skip(1).reduce(routes[path_entries[0][:entry]].@next_hash) do |acc, idx|
          if acc.nil?
            return
          elsif idx[:index] < path_entries.size - 1
            if acc.has_key?(idx[:entry]) && acc[idx[:entry]].@next_hash.nil?
              acc[idx[:entry]].set_next_hash(Hash(String, RouteNode).new)
            elsif !acc.has_key?(idx[:entry])
              acc[idx[:entry]] = RouteNode.new(action_method: nil, param: idx[:param], next_hash: Hash(String, RouteNode).new)
            end
            acc[idx[:entry]].@next_hash
          else
            acc[idx[:entry]] = RouteNode.new(action_method: action, param: idx[:param], next_hash: nil)
            nil
          end
        end
      end
    end
  end

  def check_get_path(path : String) : ActionBase?
    path_entries = path.strip.split("/").reject { |path_entry| path_entry.empty? }.map_with_index { |path_entry, idx| {entry: path_entry, index: idx} }
    if path_entries.size == 0
      return @get_routes["/"].get_action_method
    elsif path_entries.size == 1
      return @get_routes.fetch(path_entries[0][:entry]) {
        @get_routes.fetch(WILDCARD) { raise "Doesn't exist" }
      }.get_action_method
    else
      path_entries.skip(1).reduce(@get_routes.select(path_entries[0][:entry], WILDCARD).map { |key, val| val.@next_hash }.compact) do |acc, idx|
        if acc.nil? || acc.empty?
          raise NoRouteError404.new("No route for path #{path}")
        elsif idx[:index] < path_entries.size - 1
          acc.compact.map { |bb| bb.select(idx[:entry], WILDCARD).map { |key, val| val.@next_hash } }.flatten.compact
        else
          return acc.compact.map { |bb| bb.select(idx[:entry], WILDCARD).map { |key, val| val.get_action_method } }.flatten.compact.min_by { |method| method.get_weight }
        end
      end

      raise "No Path found"
    end
  end

  def add_post_route(path : String, action : ActionMethod)
  end
end
