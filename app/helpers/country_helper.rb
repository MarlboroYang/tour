module CountryHelper
  def check?(obj, type)
    obj.send("may_#{type}?") && policy(obj).send("#{type}?")
  end
end