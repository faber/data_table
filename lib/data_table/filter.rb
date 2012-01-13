class DataTable::Filter
  def initialize(opts={})
    @scopes = opts.symbolize_keys
  end
  def method_missing(method,*args)
    @scopes.key?(method) ? @scopes[method] : nil
  end
  
  # Applys to a given scope, returning the scope with any additional things added
  # to it
  def apply(scope)
    @scopes.each do |scope_name, arg|
      scope = scope.send(scope_name, arg) unless arg.blank?
    end
    scope
  end
end