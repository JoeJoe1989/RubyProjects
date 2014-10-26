class Fixnum
  def seconds
    self
  end

  def minutes
    self * 60
  end

  def hours
    self * 60 * 60
  end

  def ago
    Time.now - self
  end

  def from_now
    Time.now + self
  end

end

p Time.now
p 5.minutes
p 5.minutes.ago

