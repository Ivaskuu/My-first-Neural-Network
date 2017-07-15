import java.lang.Math;

class Neuron
{
  private double outputValue;
  
  int index;
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
  
  public void setOutputValue(double value) {outputValue = value;}
  public double getOutputValue() {return outputValue;}
  
  private double getRandomWeight()
  {
    return random(0, 1); // /!\ Processing method /!\
  }
}