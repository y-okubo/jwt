this_dir = File.expand_path(__dir__)
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'auth_services_pb'

def auth
  stub = Auth::Authenticator::Stub.new('0.0.0.0:7831', :this_channel_is_insecure)
  auth = stub.do_auth(Auth::AuthRequest.new(username: 'user', password: 'pass'))
  p "Token: #{auth.token}"
end

auth
