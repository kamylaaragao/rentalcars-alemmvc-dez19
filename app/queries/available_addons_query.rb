class AvailableAddonsQuery
  def initialize(addons =  Addons.all)
    @addons = addons
  end

  def self.call
    @addons = Addon.joins(:addon_items)
                   .where(addon_items: { status: :available }).group(:id)
  end
end
