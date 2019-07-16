class ResultadosController < ApplicationController

  def index
    @juegos = Juego.all()
  end

    def new
    @juego = Juego.find(params[:id])

  end
  
  def show
    @juego = Juego.where(juego_id: params[:id]).take
    @usuarios = Usuario.all()
#@usuarios = Usuario.find(2)		 
 end
  
   def create
   	  @juego = Juego.find(params[:juego_id])
      @juego.goles_local = params[:goles_local]
      @juego.goles_visitante = params[:goles_visitante]
      @juego.registrado = 1
      @juego.save
      redirect_to "/resultados"
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
  helper_method :obtener_resultado_juego



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
