require 'redcarpet'
require 'sinatra/extension'
require 'tilt/markdown'

module Sinatra
  module Documentation
    extend Sinatra::Extension

    mime_type :readme, 'text/html'
    set :default_content, :html
    set :html_triggers_documentation, true

    before do
      # Let through sinatra image urls in development
      next if self.class.development? && request.path_info =~ %r{/__sinatra__/.*?.png}
      unless settings.static? && settings.public_folder? && (request.get? || request.head?) && static_file?(request.path_info)
        if request.params.has_key? 'format'
          format params['format']
        else
          # Sinatra relies on a side-effect from path_info= to
          # determine its routes. A direct string change (e.g., sub!)
          # would bypass that -- and fail to have the effect we're looking
          # for.
          request.path_info = request.path_info.sub %r{\.([^\./]+)$}, ''
          format $1 || (request.xhr? && settings.assume_xhr_is_js? ? :js : settings.default_content)
        end
      end
    end

    helpers do
      def format(val=nil)
        unless val.nil?
          mime_type = ::Sinatra::Base.mime_type(val)
          fail "Unknown media type #{val}\nTry registering the extension with a mime type" if mime_type.nil?
          @_format = val.to_sym
          response['Content-Type'] ? response['Content-Type'].sub!(/^[^;]+/, mime_type) : content_type(@_format)
        end
        @_format
      end

      # Patch the content_type function to remember the set type
      # This helps cut down on time in the format helper so it
      # doesn't have to do a reverse lookup on the header
      def content_type(*args)
        @_format = args.first.to_sym
        super
      end
    end

    get '/*' do
      pass if format != :readme and (request.preferred_type == 'text/html' and !settings.html_triggers_documentation)
      pass if self.class.development? && request.path_info =~ %r{/__sinatra__/.*?.png}
      cache_control :public, :max_age => 300
      render(:markdown, :"#{request.path}")
    end
  end
end

