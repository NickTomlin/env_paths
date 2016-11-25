describe EnvPaths do
  it 'accepts and uses a suffix to avoid conflicting with other applications' do
    env_paths = EnvPaths.get('my_app', suffix: 'my_suffix')

    expect(env_paths.data).to match(/my_app-my_suffix$/)
  end

  it 'allows overriding suffix by passing "false"' do
    env_paths = EnvPaths.get('my_app', suffix: false)

    expect(env_paths.data).to match(/my_app$/)
  end

  context 'MacOs' do
    it 'returs osx specific data' do
      allow(EnvPaths).to receive(:_platform).and_return('x86_64-darwin13.0')
      env_paths = EnvPaths.get('my_app')

      expect(env_paths.data).to match(%r{Library/Application Support/my_app-ruby})
      expect(env_paths.config).to match(%r{Library/Preferences/my_app-ruby})
      expect(env_paths.cache).to match(%r{Library/Caches/my_app-ruby})
      expect(env_paths.log).to match(%r{Library/Logs/my_app-ruby})
      expect(env_paths.temp).to match(%r{/var/folders/.*/my_app-ruby})
    end
  end

  context 'Linux' do
    it 'returs linux specific data' do
      allow(EnvPaths).to receive(:_platform).and_return('hipster-linux')
      env_paths = EnvPaths.get('my_app')

      expect(env_paths.data).to match(%r{.local/share/my_app-ruby$})
      expect(env_paths.config).to match(%r{.config/my_app-ruby$})
      expect(env_paths.cache).to match(%r{.cache/my_app-ruby$})
      expect(env_paths.log).to match(%r{.local/state/my_app-ruby$})
      expect(env_paths.temp).to include('my_app-ruby')
    end

    it 'prefers XDG_* ENV settings to defaults'
  end

  context 'Windows' do
    it 'returs windows specific data' do
      allow(EnvPaths).to receive(:_platform).and_return('win32')
      env_paths = EnvPaths.get('my_app')

      expect(env_paths.data).to include('Data')
      expect(env_paths.config).to include('Config')
      expect(env_paths.cache).to include('Cache')
      expect(env_paths.log).to include('Log')
      expect(env_paths.temp).not_to be_nil
    end
  end
end
