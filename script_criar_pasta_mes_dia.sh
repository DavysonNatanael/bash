# AUTOR: Davyson Natanael (davyson.natanael@celogos.com.br)
# DATA: 2021-02-10 17:16

# FUNCAO: 
#	  Criar uma pasta para cada mes (PASTA_MES) do ano vigente.
#	  Cada PASTA_MES contem uma pasta para cada dia (PASTA_DIA), identificada por "dia.dia_semana"
#	  Exemplo PASTA-MES: 2021.1
#	  Exemplo PASTA-DIA: 1.sexta

# Consulta e armazena o Ano Atual
ANO=$(date +"%Y")

# Armazena a quantidade de meses (valor fixo)
MESES=12

# Contador de MES e DIA.
MES=1
DIA=1

# Repete os comandos MES_1 ate o MES_12
while [ $MES -le $MESES ]; do

	# Consulta e armazena o nome do mes da contagem
	
	# Existem dois formatos para o nome do mes
	###	Opcao1: +%B retorna o nome completo: janeiro
	### Opcao2: +%b retorna o nome abreviado: jan
	MES_NOME=$(date -d "$(date +%Y-$MES-$DIA)" +%B)
	
	# Cria as pastas com o ANO, NUMERO DO MES e NOME DO MES
	#	Exemplo: 2021-01.janeiro
	case $MES in
		1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 )
			mkdir "$ANO"-0"$MES"."$MES_NOME"
			;;
		*)
			mkdir "$ANO"-"$MES"."$MES_NOME"
			;;
	esac

	# Verifica a quantidade de dias do mes que esta criando a pasta
	# Do mes 1 ao 11:
	if [ $MES -lt $MESES ]
	then
		# Funcao que utiliza 'primeiro dia do mes seguinte ao atual, menos 1 dia'
		# Exemplo: 01-02-2021 menos 1 dia = 31-01-2021
		DIAS=$(date -d "$(date +$ANO-$(($MES+1))-01) -1 day" +%d)
	fi
	
	# Mes 12:
	if [ $MES -eq $MESES ]
	then
		# Funcao exclusiva para o mes 12 (dezembro)
		# Utiliza 'primeiro dia do ano seguinte ao atual, menos 1 dia'
		# Exemplo: 01-01-2022 menos 1 dia = 31-12-2022
		DIAS=$(date -d "$(date +$(($ANO+1))-01-01) -1 day" +%d)
	fi

		# Repete os comandos do DIA_1 ate o ultimo dia do mes
		while [ $DIA -le $DIAS ]; do

			# Consulta o dia_semana
			DIA_SEMANA=$(date -d "$(date +%Y-$MES-$DIA)" +%A)

			case $MES in
				1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 )
					case $DIA in
					1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 )
						# Cria a pasta do dia com dia_semana
						mkdir "$ANO"-0"$MES"."$MES_NOME"/"0$DIA"."$DIA_SEMANA"
						;;
					*)
						mkdir "$ANO"-0"$MES"."$MES_NOME"/"$DIA"."$DIA_SEMANA"
						;;
					esac
					;;
				*)
					case $DIA in
					1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 )
						# Cria a pasta do dia com dia_semana
						mkdir "$ANO"-"$MES"."$MES_NOME"/"0$DIA"."$DIA_SEMANA"
						;;
					*)
						# Cria a pasta do dia com dia_semana
						mkdir "$ANO"-"$MES"."$MES_NOME"/"$DIA"."$DIA_SEMANA"
						;;
				esac
			esac

			# Incrementa 1 no contador DIA
			DIA=$(($DIA + 1))

		done

	# Incrementa 1 no contador MES	
	let "MES=MES+1"

	# Reseta a contagem de dias ao trocar o MES
	let "DIA=1"
done

