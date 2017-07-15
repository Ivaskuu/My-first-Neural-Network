import java.lang.Math;

class Neuron
{
  double outputValue;
  
  double learningRate = 0.15;
  double momentum = 0.25;
  
  int index;
  double gradient;
  Connection[] connections;
  
  Neuron(int outputNum, int num)
  {
    connections = new Connection[outputNum];
    for(int i = 0; i < outputNum; i++)
    {
      connections[i] = new Connection(getRandomWeight(), 0);
    }
    
    index = num;
  }
  
  public void feedForward(final Layer prevLayer)
  {
    double sum = 0;
    
    for(int i = 0; i < prevLayer.neurons.length; i++)
    {
      sum += prevLayer.neurons[i].getOutputValue() * prevLayer.neurons[i].connections[index].weight;
    }
    
    outputValue = activationFunction(sum);
  }
  
  private double activationFunction(double sum)
  {
    // tanh(x) activation function
    return Math.tanh(sum);
  }
  
  private double activationFunctionDerivative(double sum)
  {
    return 1.0 - sum * sum;
  }
  
  public void calcOutputGradients(double targetValue)
  {
    double delta = targetValue - outputValue;
    gradient = delta * activationFunctionDerivative(outputValue);
  }
  
  public void calcHiddenGradients(Layer nextLayer)
  {
    double dow = sumDOW(nextLayer);
    gradient = dow * activationFunctionDerivative(outputValue);
  }
  
  public double sumDOW(Layer nextLayer)
  {
    double sum = 0;
    
    // Sum our contributions of the errors at the nodes we feed
    for(int i = 0; i < nextLayer.neurons.length; i++)
    {
      sum += connections[i].weight * nextLayer.neurons[i].gradient;
    }
    
    return sum;
  }
  
  public void updateInputWeights(Layer prevLayer)
  {
    // The weights to be updated are in the connection container in the neurons in the prevLayer
    for(int i = 0; i < prevLayer.neurons.length; i++)
    {
      Neuron neuron = prevLayer.neurons[i];
      double oldDeltaWeight = neuron.connections[index].deltaWeight;
      
      double newDeltaWeight =
        // Individual input, magnified  by the gradient and train rate:
        learningRate // train rate
        * neuron.getOutputValue()
        * gradient
        // Also add a momentum = a fraction of the previous delta weight
        + momentum
        * oldDeltaWeight;
        
      neuron.connections[index].deltaWeight = newDeltaWeight;
      neuron.connections[index].weight += newDeltaWeight;
    }
  }
  
  public void setOutputValue(double value) {outputValue = value;}
  public double getOutputValue() {return outputValue;}
  
  private double getRandomWeight()
  {
    return random(0, 1); // /!\ Processing method /!\
  }
}