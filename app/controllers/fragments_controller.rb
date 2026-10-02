class FragmentsController < ApplicationController
  PIECES = {
    "e44ebc9391b7" => {
      fragment: "44.4457",
      index: 1,
      row: 1,
      col: 1,
      label: "NORTH-WEST",
      hint: "Titlul începe aici."
    },
    "fc1979e3f783" => {
      fragment: "032383",
      index: 2,
      row: 1,
      col: 2,
      label: "NORTH-EAST",
      hint: "Vânătoarea continuă spre dreapta."
    },
    "5c3f454b0bb5" => {
      fragment: "2648, ",
      index: 3,
      row: 2,
      col: 1,
      label: "MID-WEST",
      hint: "Codul se deschide."
    },
    "c21d58fda52c" => {
      fragment: "26.082",
      index: 4,
      row: 2,
      col: 2,
      label: "MID-EAST",
      hint: "Zebră și semnale."
    },
    "274cb7f7abd3" => {
      fragment: "777891",
      index: 5,
      row: 3,
      col: 1,
      label: "SOUTH-WEST",
      hint: "Numele artistului."
    },
    "8ce024009253" => {
      fragment: "401104",
      index: 6,
      row: 3,
      col: 2,
      label: "SOUTH-EAST",
      hint: "Vernisajul te așteaptă."
    }
  }.freeze

  # Keep old constant for routes.rb
  FRAGMENTS = PIECES.transform_values { |p| p[:fragment] }.freeze

  def show
    @token = params[:token]
    @piece = PIECES[@token]
    raise ActionController::RoutingError, "Not Found" unless @piece

    @fragment = @piece[:fragment]
    piece_file = Rails.root.join("public/pieces/#{@token}.jpg")
    version = piece_file.exist? ? piece_file.mtime.to_i : Time.now.to_i
    @image_path = "/pieces/#{@token}.jpg?v=#{version}"

    respond_to do |format|
      format.html
      format.text { render plain: @fragment }
      format.any { render plain: @fragment }
    end
  end
end
