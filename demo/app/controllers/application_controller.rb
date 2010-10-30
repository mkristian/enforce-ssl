class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do

    # work around a bug somewhere in the
    # tcp stack from rails, rack, jruby-rack, jetty
    # when request HEAD and then following a GET on
    # the same connection does not send the body of the
    # GET. on a fresh connection both HEAD and HEAD work
    # as expected
    # only appeared on selenium tests
    response.header["Connection"] = "close"

  end
end
