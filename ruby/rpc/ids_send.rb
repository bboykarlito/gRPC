this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'api_services_pb'
require 'pry'

include Api

class IdsSend
  def initialize(ids)
    @ids = ids
  end

  def each
    #return enum_for(:each) unless block_given?
    @ids.each_entry do |post_id|
      binding.pry
      yield PostId.new(post_id: post_id)	
    end
  end
end
