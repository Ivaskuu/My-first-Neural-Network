class Layer
{
  Neuron[] neurons;

  Layer(int neuronsNum, int nextLayerNeuronsNum)
  {
    neurons = new Neuron[neuronsNum + 1]; // Initialize the array of neurons (+1 for the bias neuron)
    for(int i = 0; i <= neuronsNum; i++)
    {
      println("New neuron created");
      neurons[i] = new Neuron(nextLayerNeuronsNum, i);
    }
  }
}