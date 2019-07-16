class UsuariosController < ApplicationController

  def index
  	  redirect_to "/pronosticos"
    @usuarios = Usuario.all()
  end

  def show
      @usuario = Usuario.find(params[:id])
      @jornadas = Juego.distinct.pluck(:jornada)  
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

  def get_puntaje_de_partido(usuario_id,juego_id)
    @juego = Juego.find(juego_id)
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
        return "No se ha jugado"
      end
  end
  helper_method :get_puntaje_de_partido

end
