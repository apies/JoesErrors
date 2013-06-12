class JoeLogger

  def log_error(error_params)
    e = JoeError.create(error_params )
    puts "created#{e}"
    e
  end
  
end