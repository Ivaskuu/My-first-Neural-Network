class NeuralNetwork
{
  Layer[] layers;
  
  NeuralNetwork(int[] topology)
  {
    int layersNum = topology.length;
    layers = new Layer[layersNum];
    
    for(int i = 0; i < layersNum; i++) // Fill the layer with new Neurons
    {
      println("New layer created");
      layers[i] = new Layer(topology[i]); // The Layer constructor creates n neurons + the bias neuron
    }
  }
  
  void feedForward(final double[] inputValues)
  {
    
  }
  
  void backProp(final double[] targetValues)
  {
  
  }
  
  void getResults(double[] resultValues)
  {
  
  }
}