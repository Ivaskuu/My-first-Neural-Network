class NeuralNetwork
{
  Layer[] layers;
  double overallError;
  
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
    // Calculate the overall neural network error (rooted mean square of the outputs neurons values, so a larger error is a lot worse)
    Layer outputLayer = layers[layers.length - 1];
    overallError = 0;
    
    for(int i = 0; i < outputLayer.neurons.length - 1; i++) // Not including the bias
    {
      double delta = targetValues[i] - outputLayer.neurons[i].getOutputValue();
      overallError += delta * delta;
    }
    
    overallError /= outputLayer.neurons.length - 1; // Get average error squared
    overallError = Math.sqrt(overallError);
    
    // Calculate output layer gradients
    for(int i = 0; i < outputLayer.neurons.length - 1; i++) // Not including the bias
    {
      outputLayer.neurons[i].calcOutputGradients(targetValues[i]);
    }
    
    // Calculate gradients on hidden layers
    for(int i = layers.length - 2; i > 0; i--) // Loop through each hidden layer
    {
      for(int j = 0; j < layers[i].neurons.length - 1; j++) // Loop through each neuron of the hidden layer
      {
        layers[i].neurons[j].calcHiddenGradients(layers[i+1]);
      }
    }
    
    // Update connection weights
    for(int i = layers.length - 1; i > 0; i--)
    {
      for(int j = 0; j < layers[i].neurons.length; i++)
      {
        layers[i].neurons[j].updateInputWeights(layers[i-1]);
      }
    }
  }
  
  void getResults(double[] resultValues)
  {
    Layer outputLayer = layers[layers.length - 1];
    resultValues = new double[outputLayer.neurons.length - 1]; // Minus the bias
    
    for(int i = 0; i < outputLayer.neurons.length; i++)
    {
      resultValues[i] = outputLayer.neurons[i].getOutputValue();
    }
  }
}