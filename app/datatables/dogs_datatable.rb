class DogsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      total: Dog.count,
      rows: data.as_json
    }
  end

  private

  def data
    dogs.map do |dog|
      {
        id: dog.id,
        name: dog.name,
        link: link_to('選択', dog),
      }
    end
  end

  def dogs
    @dogs ||= fetch_dogs
  end

  def fetch_dogs
    dogs = Dog.order("#{sort_column} #{sort_direction}")
    dogs = dogs.page(page).per(per_page)
    if params['name'].present?
      dogs = dogs.where('name like ?', "%#{params["name"]}%")
    end
    dogs
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per] || 10
  end

  def sort_column
    params[:sort_column] || 'id'
  end

  def sort_direction
    params[:sort_direction]
  end
end
