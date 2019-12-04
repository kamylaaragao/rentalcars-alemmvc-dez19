class NilUser
  def admin?
    false
  end

  def subsidiary
    NilSubsidiary.new
  end

  def persisted?
    false
  end

  def rentals
    []
  end
end
