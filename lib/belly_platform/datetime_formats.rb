[Time, Date].map do |klass|
  klass::DATE_FORMATS[:hadoop] = "%Y-%m-%d %H:%M:%S.%9N"
end