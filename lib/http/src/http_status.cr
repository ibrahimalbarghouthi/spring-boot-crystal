enum HttpStatus
  ACCEPTED                        = 202
  ALREADY_REPORTED                = 208
  BAD_GATEWAY                     = 502
  BAD_REQUEST                     = 400
  BANDWIDTH_LIMIT_EXCEEDED        = 509
  CHECKPOINT                      = 103
  CONFLICT                        = 409
  CONTINUE                        = 100
  CREATED                         = 201
  EXPECTATION_FAILED              = 417
  FAILED_DEPENDENCY               = 424
  FORBIDDEN                       = 403
  FOUND                           = 302
  GATEWAY_TIMEOUT                 = 504
  GONE                            = 410
  HTTP_VERSION_NOT_SUPPORTED      = 505
  I_AM_A_TEAPOT                   = 418
  IM_USED                         = 226
  INSUFFICIENT_STORAGE            = 507
  INTERNAL_SERVER_ERROR           = 500
  LENGTH_REQUIRED                 = 411
  LOCKED                          = 423
  LOOP_DETECTED                   = 508
  METHOD_NOT_ALLOWED              = 405
  MOVED_PERMANENTLY               = 301
  MULTI_STATUS                    = 207
  MULTIPLE_CHOICES                = 300
  NETWORK_AUTHENTICATION_REQUIRED = 511
  NO_CONTENT                      = 204
  NON_AUTHORITATIVE_INFORMATION   = 203
  NOT_ACCEPTABLE                  = 406
  NOT_EXTENDED                    = 510
  NOT_FOUND                       = 404
  NOT_IMPLEMENTED                 = 501
  NOT_MODIFIED                    = 304
  OK                              = 200
  PARTIAL_CONTENT                 = 206
  PAYLOAD_TOO_LARGE               = 413
  PAYMENT_REQUIRED                = 402
  PERMANENT_REDIRECT              = 308
  PRECONDITION_FAILED             = 412
  PRECONDITION_REQUIRED           = 428
  PROCESSING                      = 102
  PROXY_AUTHENTICATION_REQUIRED   = 407
  REQUEST_HEADER_FIELDS_TOO_LARGE = 431
  REQUEST_TIMEOUT                 = 408
  REQUESTED_RANGE_NOT_SATISFIABLE = 416
  RESET_CONTENT                   = 205
  SEE_OTHER                       = 303
  SERVICE_UNAVAILABLE             = 503
  SWITCHING_PROTOCOLS             = 101
  TEMPORARY_REDIRECT              = 307
  TOO_EARLY                       = 425
  TOO_MANY_REQUESTS               = 429
  UNAUTHORIZED                    = 401
  UNAVAILABLE_FOR_LEGAL_REASONS   = 451
  UNPROCESSABLE_ENTITY            = 422
  UNSUPPORTED_MEDIA_TYPE          = 415
  UPGRADE_REQUIRED                = 426
  URI_TOO_LONG                    = 414
  VARIANT_ALSO_NEGOTIATES         = 506

  def self.accepted
    ACCEPTED
  end

  def self.already_reported
    ALREADY_REPORTED
  end

  def self.bad_gateway
    BAD_GATEWAY
  end

  def self.bad_request
    BAD_REQUEST
  end

  def self.bandwidth_limit_exceeded
    BANDWIDTH_LIMIT_EXCEEDED
  end

  def self.checkpoint
    CHECKPOINT
  end

  def self.conflict
    CONFLICT
  end

  def self.continue
    CONTINUE
  end

  def self.created
    CREATED
  end

  def self.expectation_failed
    EXPECTATION_FAILED
  end

  def self.failed_dependency
    FAILED_DEPENDENCY
  end

  def self.forbidden
    FORBIDDEN
  end

  def self.found
    FOUND
  end

  def self.gateway_timeout
    GATEWAY_TIMEOUT
  end

  def self.gone
    GONE
  end

  def self.http_version_not_supported
    HTTP_VERSION_NOT_SUPPORTED
  end

  def self.i_am_a_teapot
    I_AM_A_TEAPOT
  end

  def self.im_used
    IM_USED
  end

  def self.insufficient_storage
    INSUFFICIENT_STORAGE
  end

  def self.internal_server_error
    INTERNAL_SERVER_ERROR
  end

  def self.length_required
    LENGTH_REQUIRED
  end

  def self.locked
    LOCKED
  end

  def self.loop_detected
    LOOP_DETECTED
  end

  def self.method_not_allowed
    METHOD_NOT_ALLOWED
  end

  def self.moved_permanently
    MOVED_PERMANENTLY
  end

  def self.multi_status
    MULTI_STATUS
  end

  def self.multiple_choices
    MULTIPLE_CHOICES
  end

  def self.network_authentication_required
    NETWORK_AUTHENTICATION_REQUIRED
  end

  def self.no_content
    NO_CONTENT
  end

  def self.non_authoritative_information
    NON_AUTHORITATIVE_INFORMATION
  end

  def self.not_acceptable
    NOT_ACCEPTABLE
  end

  def self.not_extended
    NOT_EXTENDED
  end

  def self.not_found
    NOT_FOUND
  end

  def self.not_implemented
    NOT_IMPLEMENTED
  end

  def self.not_modified
    NOT_MODIFIED
  end

  def self.ok
    OK
  end

  def self.partial_content
    PARTIAL_CONTENT
  end

  def self.payload_too_large
    PAYLOAD_TOO_LARGE
  end

  def self.payment_required
    PAYMENT_REQUIRED
  end

  def self.permanent_redirect
    PERMANENT_REDIRECT
  end

  def self.precondition_failed
    PRECONDITION_FAILED
  end

  def self.precondition_required
    PRECONDITION_REQUIRED
  end

  def self.processing
    PROCESSING
  end

  def self.proxy_authentication_required
    PROXY_AUTHENTICATION_REQUIRED
  end

  def self.request_header_fields_too_large
    REQUEST_HEADER_FIELDS_TOO_LARGE
  end

  def self.request_timeout
    REQUEST_TIMEOUT
  end

  def self.requested_range_not_satisfiable
    REQUESTED_RANGE_NOT_SATISFIABLE
  end

  def self.reset_content
    RESET_CONTENT
  end

  def self.see_other
    SEE_OTHER
  end

  def self.service_unavailable
    SERVICE_UNAVAILABLE
  end

  def self.switching_protocols
    SWITCHING_PROTOCOLS
  end

  def self.temporary_redirect
    TEMPORARY_REDIRECT
  end

  def self.too_early
    TOO_EARLY
  end

  def self.too_many_requests
    TOO_MANY_REQUESTS
  end

  def self.unauthorized
    UNAUTHORIZED
  end

  def self.unavailable_for_legal_reasons
    UNAVAILABLE_FOR_LEGAL_REASONS
  end

  def self.unprocessable_entity
    UNPROCESSABLE_ENTITY
  end

  def self.unsupported_media_type
    UNSUPPORTED_MEDIA_TYPE
  end

  def self.upgrade_required
    UPGRADE_REQUIRED
  end

  def self.uri_too_long
    URI_TOO_LONG
  end

  def self.variant_also_negotiates
    VARIANT_ALSO_NEGOTIATES
  end
end
