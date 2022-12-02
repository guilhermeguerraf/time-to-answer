require 'uri'
require 'net/http'
require 'active_support/json'

class CEP
	attr_reader :logradouro, :bairro, :localidade, :uf

  END_POINT = "https://viacep.com.br/ws/"
  FORMAT = "json"

	def initialize(cep)
		cep_encontrado = encontrar(cep)
		preencher_dados(cep_encontrado)
	end

	def endereco
		"#{logradouro}, #{bairro}, #{localidade}-#{uf}"
	end

	private
		def preencher_dados(cep)
			@logradouro = cep["logradouro"]
			@bairro     = cep["bairro"]
			@localidade = cep["localidade"]
			@uf         = cep["uf"]
		end

		def encontrar(cep)
			ActiveSupport::JSON.decode(
				Net::HTTP.get(
					URI("#{END_POINT}#{cep}/#{FORMAT}/")
				)
			)
		end
end