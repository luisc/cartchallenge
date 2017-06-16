module FileLoader
  def require_all(*globs)
    globs.each do |glob|
      Dir[File.dirname(__FILE__) + glob].each {|file| require file }
    end
  end
end