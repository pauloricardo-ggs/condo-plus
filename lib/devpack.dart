// ignore_for_file: public_member_api_docs, sort_constructors_first

final conectores = ['da', 'das', 'do', 'dos', 'de', 'e'];

String formatarParaTresNomes(String nome) {
  var nomeCompleto = nome.split(' ');
  var nomeSelecionado = [];

  if (nomeCompleto.length <= 3) {
    return nomeCompleto.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
  }

  nomeSelecionado.add(nomeCompleto.first);
  nomeSelecionado.add(nomeCompleto[1]);
  if (conectores.contains(nomeCompleto[1])) {
    nomeSelecionado.add(nomeCompleto[2]);
  }

  if (conectores.contains(nomeCompleto[nomeCompleto.length - 2])) {
    nomeSelecionado.add(nomeCompleto[nomeCompleto.length - 2]);
  }
  nomeSelecionado.add(nomeCompleto.last);

  return nomeSelecionado.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
}

String formatarParaDoisNomes(String nome) {
  var nomeCompleto = nome.split(' ');
  var nomeSelecionado = [];

  if (nomeCompleto.length < 3) {
    return nomeCompleto.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
  }

  nomeSelecionado.add(nomeCompleto.first);

  if (conectores.contains(nomeCompleto[nomeCompleto.length - 2])) {
    nomeSelecionado.add(nomeCompleto[nomeCompleto.length - 2]);
  }
  nomeSelecionado.add(nomeCompleto.last);

  return nomeSelecionado.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
}
