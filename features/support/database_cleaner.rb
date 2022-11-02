require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :transaction

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end