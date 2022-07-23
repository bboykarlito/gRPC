require './lib/api_services_pb'

include Api

class IdsSend
  def initialize(ids)
    @ids = ids
  end

  def each
    return enum_for(:each) unless block_given?
    @ids.each { |post_id| yield PostId.new(post_id: post_id) }
  end
end
