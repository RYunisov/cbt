module LogsHelper
  def view_method(id)
    hs = {2 => 'SMS',
          1 => 'Email' }
    return hs[id]
  end
  def view_status(id)
    hs = {0 => 'SUCCESS', 1 => "ERROR"}
    return hs[id]
  end	
end
