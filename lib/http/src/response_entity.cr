struct ResponseEntity(ResponseType)
  property http_status : HttpStatus = HttpStatus.not_implemented
  property response : ResponseType = ResponseType.new
  property headers : Hash(String, String) = Hash(String, String).new

  def initialize; end

  def initialize(@http_status : HttpStatus); end

  def initialize(@response : ResponseType); end

  def initialize(@headers : Hash(String, String), @http_status : HttpStatus); end

  def initialize(@response : ResponseType, @http_status : HttpStatus); end

  def initialize(@response : ResponseType, @headers : Hash(String, String), @http_status : HttpStatus); end

  def initialize(@response : ResponseType, @headers : Hash(String, String), _rawStatus : Int32)
    @http_status = HttpStatus.new(_rawStatus)
  end
end
