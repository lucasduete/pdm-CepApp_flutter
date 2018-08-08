class Cep extends Object {

	String bairro;
	String cidade;
	String estado;
	String logradouro;
	String complemento;

	Cep({
		this.bairro,
		this.cidade,
		this.estado,
		this.logradouro,
		this.complemento
	});


	factory Cep.fromJson(Map<String, dynamic> json) {
		return Cep(
			bairro: json['bairro'],
			cidade: json['localidade'],
			estado: json['uf'],
			logradouro: json['logradouro'],
			complemento: json['complemento'],
		);
	}
}