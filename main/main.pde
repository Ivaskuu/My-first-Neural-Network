void setup()
{
  // Example : { 3, 2, 1} °°° - °° - °
  int[] topology = {3, 2, 1};
  NeuralNetwork myNet = new NeuralNetwork(topology);
  
  double[] inputValues = {};
  myNet.feedForward(inputValues);
  
  double[] targetValues = {};
  myNet.backProp(targetValues);
  
  double[] outputValues = {};
  myNet.getResults(outputValues);
}