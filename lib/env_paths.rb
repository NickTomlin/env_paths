require 'env_paths/version'
require 'tmpdir'
require 'etc'

module EnvPaths
  OSData = Struct.new(:data, :config, :cache, :log, :temp)
  HOMEDIR = Dir.home

  module Linux
    def self.config(app_name)
      OSData.new(
        File.join(ENV.fetch('XDG_DATA_HOME', File.join(HOMEDIR, '.local', 'share')), app_name),
        File.join(ENV.fetch('XDG_CONFIG_HOME', File.join(HOMEDIR, '.config')), app_name),
        File.join(ENV.fetch('XDG_CACHE_HOME', File.join(HOMEDIR, '.cache')), app_name),
        # https://wiki.debian.org/XDGBaseDirectorySpecification#state
        File.join(ENV.fetch('XDG_STATE_HOME', File.join(HOMEDIR, '.local', 'state')), app_name),
        File.join(Dir.tmpdir, Etc.getlogin, app_name)
      )
    end
  end

  module Windows
    def self.config(app_name)
      app_data = ENV.fetch('LOCALAPPDATA', File.join(HOMEDIR, 'AppData', 'Local'))

      OSData.new(
        File.join(app_data, app_name, 'Data'),
        File.join(app_data, app_name, 'Config'),
        File.join(app_data, app_name, 'Cache'),
        File.join(app_data, app_name, 'Log'),
        File.join(Dir.tmpdir, app_name)
      )
    end
  end

  module MacOs
    def self.config(app_name)
      library = File.join(Dir.home, 'Library')

      OSData.new(
        File.join(library, 'Application Support', app_name),
        File.join(library, 'Preferences', app_name),
        File.join(library, 'Caches', app_name),
        File.join(library, 'Logs', app_name),
        File.join(Dir.tmpdir, app_name)
      )
    end
  end

  def self._platform
    RUBY_PLATFORM
  end

  def self.get(app_name, opts = {})
    suffix = opts.fetch(:suffix, 'ruby')
    app_name += "-#{suffix}" unless opts[:suffix] == false
    case _platform.downcase
    when /win32/
      Windows.config(app_name)
    when /darwin/
      MacOs.config(app_name)
    else
      Linux.config(app_name)
    end
  end
end
