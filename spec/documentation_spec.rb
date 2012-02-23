require_relative 'spec_helper'

describe Sinatra::Documentation do
  def respond_app(&block)
    types = @provides
    mock_app do
      set :app_file, __FILE__
      set :views, root + '/documentation'
      register Sinatra::Documentation
      respond_to(*types) if types
      class_eval(&block)
    end
  end
end
