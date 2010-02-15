class PriceOptionsController < ApplicationController
  # GET /price_options
  # GET /price_options.xml
  def index
    @price_options = PriceOption.find(:all, :order => :value)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @price_options }
    end
  end

  # GET /price_options/1
  # GET /price_options/1.xml
  def show
    @price_option = PriceOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @price_option }
    end
  end

  # GET /price_options/new
  # GET /price_options/new.xml
  def new
    @price_option = PriceOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @price_option }
    end
  end

  # GET /price_options/1/edit
  def edit
    @price_option = PriceOption.find(params[:id])
  end

  # POST /price_options
  # POST /price_options.xml
  def create
    @price_option = PriceOption.new(params[:price_option])

    respond_to do |format|
      if @price_option.save
		if defined? ResponseCache == 'constant'
			ResponseCache.instance.clear
		else
			Radiant::Cache.clear
		end
		
        flash[:notice] = 'PriceOption was successfully created.'
        format.html { redirect_to(@price_option) }
        format.xml  { render :xml => @price_option, :status => :created, :location => @price_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @price_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /price_options/1
  # PUT /price_options/1.xml
  def update
    @price_option = PriceOption.find(params[:id])

    respond_to do |format|
      if @price_option.update_attributes(params[:price_option])
		if defined? ResponseCache == 'constant'
			ResponseCache.instance.clear
		else
			Radiant::Cache.clear
		end
		
        flash[:notice] = 'PriceOption was successfully updated.'
        format.html { redirect_to(@price_option) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @price_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /price_options/1
  # DELETE /price_options/1.xml
  def destroy
    @price_option = PriceOption.find(params[:id])
    @price_option.destroy

    respond_to do |format|
      format.html { redirect_to(price_options_url) }
      format.xml  { head :ok }
    end
  end
end
