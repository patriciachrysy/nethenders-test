class HomeController < ApplicationController
  def index
    puts "this function is called"
    respond_to do |format|
      format.html { render :index, locals: { status_msg: "", evaluation: "" } }
    end
  end

  def evaluate
    result = nil
    form_status_msg = nil
    if params.has_key? :datas and not params[:datas].blank?
      dataArray = params[:datas].split
      result = []
      dataArray.each do |data|
        varArray = data.split(',')
        result.push(calculateReachingNuts(varArray[0].to_f, varArray[1].to_f, varArray[2].to_f, varArray[3].to_f))
      end
      form_status_msg = 'Thank you'
    else
      puts "the parans are blank"
      form_status_msg = (form_status_msg.nil? ? "" : form_status_msg) + '!Please provide some datas for analysis.!'
    end

    respond_to do |format|
      format.html { render "index", locals: { status_msg: form_status_msg, evaluation: result } }
    end
  end

  private
  
  def calculateReachingNuts (d, n, f, c)

    totalTours = n / c
    kgEatenPerTour = d * f
    totalKgEaten = totalTours * kgEatenPerTour
    kgToCity = n - totalKgEaten

    return kgToCity > 0 ? kgToCity : 0
  end
end
