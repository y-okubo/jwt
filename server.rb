this_dir = File.expand_path(__dir__)
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'jwt'
require 'openssl'
require 'base64'
require 'securerandom'
require 'grpc'
require 'auth_services_pb'

# AuthServer is simple server that implements the JWT server.
class AuthServer < Auth::Authenticator::Service
  def initialize
    File.open('rsa') do |f|
      @private_key = OpenSSL::PKey::RSA.new(f)
    end

    # openssl rsa -in id_rsa -pubout -out id_rsa_pub で作成
    File.open('rsa.pub') do |f|
      @public_key = OpenSSL::PKey::RSA.new(f)
    end
  end

  def payload
    {
      jti: SecureRandom.uuid,
      iat: Time.now.to_i,
      nbf: Time.now.to_i,
      exp: Time.now.to_i + 2,
      iss: 'Ruby',
      aud: 'Go',
      sub: 'AccessToken',
      account:  'y-okubo',
      full_name: 'Yuki Okubo'
    }
  end

  def do_auth(_req, _unused_call)
    Auth::AuthResponse.new(token: JWT.encode(payload, @private_key, 'RS256'))
  end
end

# serve starts an RpcServer.
def serve
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:7831', :this_port_is_insecure)
  s.handle(AuthServer)
  s.run_till_terminated
end

serve
