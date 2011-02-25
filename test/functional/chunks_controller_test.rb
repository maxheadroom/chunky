require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/controllers/admin/chunks_controller'
require File.dirname(__FILE__) + '/../../app/models/chunk'

class ChunksController; def rescue_action(e) raise e end; end

class ChunksControllerTest < Test::Unit::TestCase
#class ChunksControllerTest < ActionController::TestCase
  def setup
    
        @controller = ChunksController.new
        @request    = ActionController::TestRequest.new
        @response   = ActionController::TestResponse.new

  end
  
  # Replace this with your real tests.
  def test_list_links
    get :list_links
    assert_response :success
  end
end
