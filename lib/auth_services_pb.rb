# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: auth.proto for package 'auth'

require 'grpc'
require 'auth_pb'

module Auth
  module Authenticator
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'auth.Authenticator'

      rpc :DoAuth, AuthRequest, AuthResponse
    end

    Stub = Service.rpc_stub_class
  end
end