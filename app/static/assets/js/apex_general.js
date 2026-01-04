 // This isn't strictly necessary, but it's good JavaScript hygiene.
//(function() {

var binding = new Shiny.OutputBinding();

binding.find = function(scope) {
  // For the given scope, return the set of elements that belong to
  // this binding.
  return $(scope).find(".apexchart");
};

//apagando o grfico anterior (17-set-2024, 13:56h)
//var testei = binding.getId();
//testei.empty();

binding.renderValue = function(el, data) {
  // This function will be called every time we receive new output
  // values for a line chart from Shiny. The "el" argument is the
  // div for this particular chart.
  
  // Destroy previous chart if it exists
    if (el.chart) {
      el.chart.destroy();
    };

  var $el = $(el);
  
  $(el).empty(); // para limpar os svg´s anteriores
  //ajustando os dados aos parâmetros do gráfico (01-fev-2019)
  var teste = data;
  console.log(teste);

  var options = data;
 
  var chart = new ApexCharts(el, options);
  
  //ApexCharts.exec('chart');
  chart.render();

   el.chart = chart;
};

// Tell Shiny about our new output binding
Shiny.outputBindings.register(binding, "shinyjs.apexchart");
//}) //endfunction

