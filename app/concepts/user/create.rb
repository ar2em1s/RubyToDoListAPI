class User::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: User::Contracts::Create)
  step Contract::Validate()
  step Contract::Persist()
  step :generate_tokens!

  def generate_tokens!(options, params:, request:, **)
    result = Session::Create.call(params: params, request: request)
    options[:tokens] = result[:tokens]
  end
end
