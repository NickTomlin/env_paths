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

      expect(env_paths.data).to match(%r{/Users/.*/Library/Application Support/my_app-ruby})
      expect(env_paths.config).to match(%r{/Users/.*/Library/Preferences/my_app-ruby})
      expect(env_paths.cache).to match(%r{/Users/.*/Library/Caches/my_app-ruby})
      expect(env_paths.log).to match(%r{/Users/.*/Library/Logs/my_app-ruby})
      expect(env_paths.temp).to match(%r{/var/folders/.*/my_app-ruby})
    end
  end

  context 'Linux' do
    it 'returs linux specific data'
  end

  context 'Windows' do
    it 'returs windows specific data'
  end
end
