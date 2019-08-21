// Origem do CPF
// O terceiro dígito da direita para a esquerda identifica a unidade federativa na qual a pessoa foi registrada, observando o dígito final antes do traço pode-se descobrir a origem da pessoa. Veja o código para cada Estado:
//
// No exemplo CPF nº 000.000.006-00
//
// 0 - Rio Grande do Sul
// 1 - Distrito Federal, Goiás, Mato Grosso do Sul e Tocantins
// 2 - Pará, Amazonas, Acre, Amapá, Rondônia e Roraima
// 3 - Ceará, Maranhão e Piauí
// 4 - Pernambuco, Rio Grande do Norte, Paraíba e Alagoas
// 5 - Bahia e Sergipe
// 6 - Minas Gerais
// 7 - Rio de Janeiro e Espírito Santo
// 8 - São Paulo
// 9 - Paraná e Santa Catarina

let x
do {
  x = cpf(true)
} while (x[10] !== '9')
console.log(x)

function randomiza(n) {
    var ranNum = Math.round(Math.random() * n);
    return ranNum;
}

function mod(dividendo, divisor) {
    return Math.round(dividendo - (Math.floor(dividendo / divisor) * divisor));
}

function cpf(comPontos) {
    var n = 9;
    var n1 = randomiza(n);
    var n2 = randomiza(n);
    var n3 = randomiza(n);
    var n4 = randomiza(n);
    var n5 = randomiza(n);
    var n6 = randomiza(n);
    var n7 = randomiza(n);
    var n8 = randomiza(n);
    var n9 = randomiza(n);
    var d1 = n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10;
    d1 = 11 - (mod(d1, 11));
    if (d1 >= 10) d1 = 0;
    var d2 = d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
    d2 = 11 - (mod(d2, 11));
    if (d2 >= 10) d2 = 0;
    retorno = '';
    if (comPontos) retorno = '' + n1 + n2 + n3 + '.' + n4 + n5 + n6 + '.' + n7 + n8 + n9 + '-' + d1 + d2;
    else retorno = '' + n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + d1 + d2;
    return retorno;
}

function validacpf() {
    var cpf = document.form1.numero.value;
    cpf = cpf.replace('.', '');
    cpf = cpf.replace('.', '');
    cpf = cpf.replace('-', '');
    var numeros, digitos, soma, i, resultado, digitos_iguais;
    digitos_iguais = 1;
    if (cpf.length < 11)
        return false;
    for (i = 0; i < cpf.length - 1; i++)
        if (cpf.charAt(i) != cpf.charAt(i + 1)) {
            digitos_iguais = 0;
            break;
        }
    if (!digitos_iguais) {
        numeros = cpf.substring(0, 9);
        digitos = cpf.substring(9);
        soma = 0;
        for (i = 10; i > 1; i--)
            soma += numeros.charAt(10 - i) * i;
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado != digitos.charAt(0))
            return false;
        numeros = cpf.substring(0, 10);
        soma = 0;
        for (i = 11; i > 1; i--)
            soma += numeros.charAt(11 - i) * i;
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado != digitos.charAt(1))
            return false;
        return true;
    } else
        return false;
}
