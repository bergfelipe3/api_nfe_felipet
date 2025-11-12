# app/lib/data_repository.rb
class DataRepository
  include Singleton

  def initialize
    @store = {}
  end

  def get(key)
    @store[key]
  end

  def set(key, value)
    @store[key] = value
  end

  def delete(key)
    @store.delete(key)
  end

  def clear
    @store.clear
  end

  def all
    @store
  end
end
