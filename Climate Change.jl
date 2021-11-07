### A Pluto.jl notebook ###
# v0.14.9

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ a760fb60-3f05-11ec-1040-258671c4c205
begin
	using Plots
	using DifferentialEquations
	using PlutoUI
end

# ╔═╡ 3d606a54-b43e-4846-a06e-8028f1576267
md"# Climate Change Modelling"

# ╔═╡ c101002d-6918-4f6d-af97-8eebcd609be9
md"""
#### 1) Unrealistic Heating Model(**Earth Baking Model**)
"""

# ╔═╡ d8ddb39f-08f6-450a-ab57-b47aa0251492
md"There are many Climate Change Models This is a simple graph of one, where we assume that from each year after 1850 we emmit green house gases"

# ╔═╡ 0f8cc3ec-c355-4f6e-801b-f660250b727b
md"""
This model can be expressed as
> **Cₜ = C₀ * ϵ (simplified Equation)**
where Cₜ is the temperature at time 𝓉 C₀ is the temperature at 1850 and ϵ is the factor by which the temperature increases 
"""

# ╔═╡ 34ea6628-81bc-4b78-bf09-8394f326543c
md"""
This model is completly unrealistic as it says that we would have a temperature of around 800°C which cannot hold life
"""

# ╔═╡ 4bb137bd-1ab5-4ee2-9371-050c206e5577
md"""
#### 2) **Healthy Earth Model** (With no human induced green house gases)
"""

# ╔═╡ ee7eb18a-2978-49c8-a3a4-de76cb877d9d
md"""
Another way to model the earth climate is by introducing the cooling mechanisim of earth where a sun ray hits the earth temperature (**heating**)(𝒮) and the earth reflects the sun rays back to space(**cooling**)(α)
"""

# ╔═╡ c0a9fd3c-a601-447a-8ac6-32091303a2d5
md"""
Model can be expressed as
> **cooling of earth = 𝒮(1 - α)/4**
where 𝒮 is the incoming solar radiation with a value of **1368 W/m²** and
α is the reflectivity of the earth with a value of **0.3** \
\
So combing The heating and cooling equations we get the equation for a healthy
Earth Simulation
> **Health Earth Simulation = Cooling Of Earth - Heating of Earth**
"""

# ╔═╡ dcb1a918-cbfb-47e4-ad75-9827e46735c3
md"""
> Below here is a simulation of a **Healthly Earth Temperature Simulation** where if you adjust the slider which the starting point of Earth's temperature, Earth will always cool itself down This process occured for millions and millions of years without the intervention of **human induced green house gases**
"""

# ╔═╡ d2860b33-0434-4e33-8817-e2e35b958992
md"Earth Start Temperature $(@bind start_temp Slider(0.1:0.01:25.1,show_value=true)) °C"

# ╔═╡ ef7e8293-bc42-4b38-81b2-c4a1d2ca7235
md"""
# Climate Change!
"""

# ╔═╡ d35ee881-7353-46e1-8e9f-15a5ecbc12ce
md"""
#### 3) Temperature Rise With **Human Induced Green House Gases Model**
"""

# ╔═╡ 223453e4-3642-4953-a942-53effa6c126b
md"""
We can model climate change by equation
> **Cₜ = (cooling effect - heating effect) + human induced effect**
"""

# ╔═╡ 16488cb8-a129-4dff-a575-887407ed316c
md"""
> Slider Controls The Start **Temperature At 1850**, As you can see a **cooling effect occurs in the early 1850s** and after the industrial revolution the **human induced effect take place**
"""

# ╔═╡ bb77a7a1-a226-4dca-a980-804a35f96817
md"""
Model predicts that currently the Global temperature is at **15.1 °C** and according to [NASA](https://climate.nasa.gov) the climate change is **1.18 °C** 
> So if we subtract **current predicted temperature - Global Average Temperature At 1850 = Change In Temperature** 

> **15.1 - 14.1 = 1 °C**
"""

# ╔═╡ 628ece4f-024e-440a-9183-e5d8011ecfcc
md"Human induced Climate Change Modelling °C  = $(@bind human_temp Slider(0.1:0.01:25.1,show_value=true)) °C"

# ╔═╡ b53a82f4-45a3-4657-8cb9-e4f09715570c


# ╔═╡ 4e88e20b-066c-4144-a913-e9be59a2395d
gr();

# ╔═╡ 86e88866-f998-4d3e-bd41-eb2c5fedd97a
gr();

# ╔═╡ 26940047-17c7-4c55-9e94-27149af0e4f5
begin
	S = 1368.0
	α = 0.3
	C =  51.0
	temp0 = 14.10
	B = 1.5
	forcing_coef = 5.0
	CO2_PreIndustrial = 280.0
end;

# ╔═╡ 3f866044-279c-41c4-a34f-ba505332813d
p2 = ODEProblem((temp,p,t) -> (1/C) * B * (temp0 - temp),start_temp,(0.0,180.0));

# ╔═╡ 51482521-ef60-4cab-80ea-d68f21879f2e
begin
	plot(solve(p2).t .+ 1850,solve(p2).u,ylim=(0,35.0),label= "Healthy Earth Temperature",xlabel=" Years Since 1850",ylabel = "Number Temperature Scale")
	hline!( [14.1,14.1] ,c=:black,ls=:dash,label="Earth Temperature At 1850 PreIndustrial Age 14°C")
	title!("Healthy Earth Temperature Simulation")
	# annotate!(91.0,15.8,text("Global Temperature At 1850"))
end

# ╔═╡ 5aeef5ee-866b-488a-ab8e-757f9224b086
greenhouse_effect(CO2) = forcing_coef * log(CO2/CO2_PreIndustrial);

# ╔═╡ 14d6487f-62fc-40e6-9802-b0f6476e28e9
CO2(t) = CO2_PreIndustrial * (1 + (t/220)^3);

# ╔═╡ a32cbb16-29b9-4cb6-acec-9345a47e0c94
p3 = ODEProblem((temp,p,t) -> (1/C) * (B * (temp0 - temp) +  greenhouse_effect(CO2(t)) ),human_temp,(0.0,200.0));

# ╔═╡ 4c626313-91b7-42d2-bc1e-32ac704dd749
begin
	plot(solve(p3).t .+ 1850,solve(p3).u,xlabel="Number Year",ylabel="Temperature",label="Earth Temperature",ylims=(10.1,21.5),xlims=(1801.0,2101.1))
	hline!([temp0,temp0],c = :black,ls = :dash,label="Global Temperature At 1850 14°C")
	plot!([0, 1901], [0.0, 0.5], fillrange=[25.1, 25.1], color=:lightblue, alpha=0.2, label="Pre Industrial Time")
	plot!([1951.0, 2101.1], [0.0, 0.5], fillrange=[25.1, 25.1], color=:red, alpha=0.2, label="Industrial Time Green House Gas Emission")
	# annotate!(53,15.8,text("Global Temperature At 1850"))
end

# ╔═╡ 9dac79ee-fb2d-4fc6-af12-db40fd7d4a92
begin
	current = solve(p3)(191.1);
end;

# ╔═╡ 48b66ee2-9b50-4af5-8c42-4e47d16c650b
md"""
Current Temperature = **$(current) °C** \
Change In Temperature = **$(current - 14.10)**
"""

# ╔═╡ 670ec61d-0175-4f1d-9b52-a31576824c77
greenhouse_effect(CO2(159));

# ╔═╡ a17a3b04-4a46-446d-bf4b-00e119c0ef2a
absorbed_solar_radiation = S * (1 - α)/4;

# ╔═╡ 01d5f55c-452d-4848-966a-be20cc1ae0f4
p1 = ODEProblem((temp, p, t) -> (1/C) * absorbed_solar_radiation,temp0,(0.0,350.0));

# ╔═╡ 69f3aadc-21c4-46d1-8d7d-818057d144cc
begin
	plot(solve(p1).t .+ 1850,solve(p1).u,xlabel="years since 1850",ylabel="temperature",label="Earth Temperature")
	hline!( [14.1,14.1] ,c=:black,ls=:dash,label="Global Earth Temperature At 1850 14°C")
end

# ╔═╡ 8d4e7794-bdf9-4ffa-8716-aebef40cfc0e
temp_human = @bind start_temp_human Slider(0.1:0.01:25.1,show_value=true);

# ╔═╡ 54cafc8c-aac2-40b5-ba23-ef93045ba60e
gr();

# ╔═╡ Cell order:
# ╟─a760fb60-3f05-11ec-1040-258671c4c205
# ╟─3d606a54-b43e-4846-a06e-8028f1576267
# ╟─c101002d-6918-4f6d-af97-8eebcd609be9
# ╟─d8ddb39f-08f6-450a-ab57-b47aa0251492
# ╟─0f8cc3ec-c355-4f6e-801b-f660250b727b
# ╟─69f3aadc-21c4-46d1-8d7d-818057d144cc
# ╟─34ea6628-81bc-4b78-bf09-8394f326543c
# ╟─4bb137bd-1ab5-4ee2-9371-050c206e5577
# ╟─ee7eb18a-2978-49c8-a3a4-de76cb877d9d
# ╟─c0a9fd3c-a601-447a-8ac6-32091303a2d5
# ╟─dcb1a918-cbfb-47e4-ad75-9827e46735c3
# ╟─d2860b33-0434-4e33-8817-e2e35b958992
# ╟─51482521-ef60-4cab-80ea-d68f21879f2e
# ╟─ef7e8293-bc42-4b38-81b2-c4a1d2ca7235
# ╟─d35ee881-7353-46e1-8e9f-15a5ecbc12ce
# ╟─223453e4-3642-4953-a942-53effa6c126b
# ╟─16488cb8-a129-4dff-a575-887407ed316c
# ╟─628ece4f-024e-440a-9183-e5d8011ecfcc
# ╟─48b66ee2-9b50-4af5-8c42-4e47d16c650b
# ╟─4c626313-91b7-42d2-bc1e-32ac704dd749
# ╟─bb77a7a1-a226-4dca-a980-804a35f96817
# ╟─b53a82f4-45a3-4657-8cb9-e4f09715570c
# ╟─3f866044-279c-41c4-a34f-ba505332813d
# ╟─9dac79ee-fb2d-4fc6-af12-db40fd7d4a92
# ╟─5aeef5ee-866b-488a-ab8e-757f9224b086
# ╟─4e88e20b-066c-4144-a913-e9be59a2395d
# ╟─86e88866-f998-4d3e-bd41-eb2c5fedd97a
# ╟─a32cbb16-29b9-4cb6-acec-9345a47e0c94
# ╟─670ec61d-0175-4f1d-9b52-a31576824c77
# ╟─14d6487f-62fc-40e6-9802-b0f6476e28e9
# ╟─26940047-17c7-4c55-9e94-27149af0e4f5
# ╟─a17a3b04-4a46-446d-bf4b-00e119c0ef2a
# ╟─01d5f55c-452d-4848-966a-be20cc1ae0f4
# ╟─8d4e7794-bdf9-4ffa-8716-aebef40cfc0e
# ╟─54cafc8c-aac2-40b5-ba23-ef93045ba60e
