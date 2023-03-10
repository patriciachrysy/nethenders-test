class HomeController < ApplicationController
  def index
    @datas = ""
    @results = []
  end

  def results
  end

  def evaluate
    @datas = datas_params
    respond_to do |format|
      if not @datas.blank?
        dataArray = @datas.split
        @results = []
        dataArray.each do |data|
          varArray = data.split(',')
          result = {
            d: varArray[0].to_f, 
            n: varArray[1].to_f, 
            f: varArray[2].to_f, 
            c: varArray[3].to_f, 
            res: calculateReachingNuts(varArray[0].to_f, varArray[1].to_f, varArray[2].to_f, varArray[3].to_f)
          }
          @results.push(result)
        end
        format.html { redirect_to :results, notice: @results }
        format.json { render :index, status: 200, location: @results }
      else
        format.html { render :index, notice: 'Please provide datas to calculate.' }
        format.json { render json: "Please provide some datas for analysis.", status: 400 }
      end
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

  def datas_params
    params.require(:datas)
  end
end
