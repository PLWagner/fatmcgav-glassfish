require 'puppet/provider/asadmin'
Puppet::Type.type(:set).provide(:asadmin, :parent =>
                                      Puppet::Provider::Asadmin) do
  desc "Glassfish domain attribute support."

  def create
    args = Array.new
    args << 'set'
    args << "#{@resource[:name]}=#{@resource[:value]}"
    asadmin_exec(args)
  end

  def destroy
    # Destroy can't do anything with set. 
  end

  def exists?
    asadmin_exec(["get #{@resource[:name]}"]).each do |line|
      return true if "#{@resource[:name]}=#{@resource[:value]}" == line.chomp
    end
    return false
  end
end
