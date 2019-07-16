class PronosticosController < ApplicationController

	def cargar
		@usuario = Usuario.find(params[:id])
		@j = Juego.where(jornada: params[:jornada]).first
		@juegos = Juego.where(jornada: params[:jornada])
		ya =UsuarioPartido.exists?(juego_id: @j.juego_id, usuario_id: params[:id])
		if(ya==true)
			@pronosticos = true
			@partidos = Array.new()
			@juegos.each do |jp|
				@partidos.push(jp.juego_id)	
			end
			@resultados = UsuarioPartido.where(juego_id: @partidos,usuario_id: params[:id])
		end
	end


    def index


    	@puntosPorUsuario = Hash.new 
    	@totalMarcadoresExactos = 0;
    	
    	#Arrays
    	@ArrayMarcadoresExactos = Array.new()
    	@tablaPosiciones = Array.new()
    	@usuarios = Usuario.all()
    	 @juegos = Juego.where(registrado: 1)
    	 @usuarios.each do |usuario|
    	 	 @totalPuntos= 0
    	 	 @totalMarcadoresExactos = 0
    	 	 @juegos.each do |juego|
    	 	 	 UsuarioPartido.where(usuario_id: usuario.id, juego_id: juego.id).each do |us|
    	 	 	  if(juego.goles_local.to_s == us.goles_local.to_s && juego.goles_visitante.to_s == us.goles_visitante.to_s)
                  	@totalPuntos= @totalPuntos.to_i +  2
                  	@totalMarcadoresExactos = @totalMarcadoresExactos + 1
                  elsif obtener_resultado_juego(juego.goles_local.to_s, juego.goles_visitante.to_s) == obtener_resultado_juego(us.goles_local.to_s,us.goles_visitante.to_s)
                    @totalPuntos= @totalPuntos.to_i + 1
                  else
                   @totalPuntos= @totalPuntos.to_i +  0
                 end
             end
    	 	 end
    	 	 @puntosPorUsuario[usuario.nombre] = @totalPuntos.to_i
    	 	  @ArrayMarcadoresExactos[usuario.id] = @totalMarcadoresExactos.to_i
    	 	  @tablaPosiciones.push([usuario.nombre, @totalPuntos.to_i,@totalMarcadoresExactos.to_i])
    	 	  
    	  end
    	 @puntosPorUsuario = Hash[@puntosPorUsuario.sort_by{|k,v| v}.reverse.to_h]
    	 
    	 
    	@tablaPosiciones =  @tablaPosiciones.sort_by{ |i,j,k| [j,k,i]}.reverse

    end
	
  def new
      @juegos = Juego.find([63,64])
  end
  
 def obtener_resultado_juego(goles_local,goles_visitante)
    if(goles_local.to_i==goles_visitante.to_i)
      return "empate"
    elsif (goles_local.to_i > goles_visitante.to_i)
      return "gano_local"
    else
      return "gano_visitante"
    end
  end


  def create
      
      @juegos = Juego.where(jornada: params[:jornada])

      @juegos.each  do |j|
        @pronostico = UsuarioPartido.new()
        @pronostico.usuario_id = params[:usuario_id]
        @pronostico.juego_id = j.juego_id
        @pronostico.goles_local = params["goles_local_#{j.juego_id}"]
        @pronostico.goles_visitante = params["goles_visitante_#{j.juego_id}"]
        @pronostico.save
      end

      @usuario = Usuario.find(params[:usuario_id])
      @usuario.registro = 1
      @usuario.save

      redirect_to "/pronosticos"
  end

  def get_puntos_por_partido(usuario_id)
    @juego = Juego.find(params[:id])
      if(@juego.goles_local != "" && @juego.goles_visitante != "")
            UsuarioPartido.where(usuario_id: usuario_id, juego_id: @juego.id).each do |us|
                if(@juego.goles_local.to_s == us.goles_local.to_s && @juego.goles_visitante.to_s == us.goles_visitante.to_s)
                  return 2
                elsif obtener_resultado_juego(@juego.goles_local.to_s, @juego.goles_visitante.to_s) == obtener_resultado_juego(us.goles_local.to_s,us.goles_visitante.to_s)
                  return 1
                else
                  return 0
                end
            end

      else
        return ""
      end
  end
  helper_method :get_puntos_por_partido
  
end
