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
      int nextLayerNeuronsNum = i == topology.length - 1 ? 0 : topology[i + 1]; // If it is the last layer, 0, else topology[i+1]
      layers[i] = new Layer(topology[i], nextLayerNeuronsNum); // The Layer constructor creates n neurons + the bias neuron
    }
  }
  
  void feedForward(final double[] inputValues)
  {
    assert(inputValues.length == layers[0].neurons.length - 1); // If not true, throws an error
    
    // Feed the input neurons
    for(int i = 0; i < inputValues.length; i++)
    {
      layers[0].neurons[i].setOutputValue(inputValues[i]);
    }
    
    // Do the forward propagation
    for(int i = 1; i < layers.length; i++) // Start with the second layer
    {
      for(int j = 1; j < layers[i].neurons.length; j++) // Start with the second layer
      {
        layers[i].neurons[j].feedForward(layers[i-1]);
      }
    }
  }
  
  void backProp(final double[] targetValues)
  {
  
  }
  
  void getResults(double[] resultValues)
  {
  
  }
}