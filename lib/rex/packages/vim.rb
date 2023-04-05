module Rex
  module Packages
    class Vim < Package
      def initialize(vimrc: "", plugins: [], **kwargs)
        super(**kwargs)

        raise InvalidConfig, "#{vimrc} does not exist" unless File.exist?(vimrc) || vimrc.empty?

        @vimrc = vimrc
        @plugins = plugins
      end
    end
  end
end
