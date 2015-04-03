class fftAudio {

  private Minim minim;
  private AudioRecordingStream stream;
  private FFT fft;
  private MultiChannelBuffer buffer;


  private int fftBufferSize;
  private int samples;
  private int blocks;

  private float blockLength;
  private float spectrumRange;
  private float[][] spectrum;

  private String fileName;

  fftAudio(PApplet _this, String _fileName, int _fftBufferSize)
  {
    minim = new Minim(_this);
    fftBufferSize = _fftBufferSize;
    fileName = _fileName;
  }

  //Returns the buffer size being used for the FFT
  public int getFftBufferSize()
  {
    return fftBufferSize;
  }

  //Returns the total samples in the audio file (song length * sample rate)
  public int getSamples()
  {
    return samples;
  }

  //Return how many blocks the song was divided into for ffting
  public int getBlocks()
  {
    return blocks;
  }

  //Returns the duration, in miliseconds, represented by each block
  public float getBlockLength()
  {
    return blockLength;
  }

  //Return the frequency range represented by each spectrum ray of each block
  public float getSpectrumRange()
  {
    return spectrumRange;
  }

  //Runs the FFT and return the matrix with the spectru
  public float[][] getSpectrum()
  {
    run();
    return spectrum;
  }

  private void run()
  {

    //Creates a recording stream that will record from the file
    //When it is played, it will only read from the source file
    AudioRecordingStream stream = minim.loadFileStream(fileName, fftBufferSize, false);
    stream.play();

    //Initiate FFT on the "recorded" stream
    fft = new FFT(fftBufferSize, stream.getFormat().getSampleRate());

    //The stream will be read into the following buffer
    buffer = new MultiChannelBuffer(fftBufferSize, stream.getFormat().getChannels());

    //Usually each second of audio is sampled at 44100hz, so it is able to reproduce up to 22050hz with fidelity (nyquist frequency)
    samples = int((stream.getMillisecondLength() / 1000.0) * stream.getFormat().getSampleRate());

    //Samples are now split into blocks, each block with "fftBufferSize" samples
    blocks = (samples / fftBufferSize) + 1;

    //Calculating the time length of each block
    blockLength = (fftBufferSize / stream.getFormat().getSampleRate()) * 1000;

    //Create an array which will store the fft data for each block
    //The spectrum size is always half the samples, although it represents the entire range of the sample rate
    //Values must be scaled back to the original frequency
    spectrum = new float[blocks][fftBufferSize/2];

    //Calculating the spectrum range.
    //For example, using blocks of 1024 samples would gives us 512 spectrum rays
    //But the 512 values represent the entire frequency sampled (samplefrequency/2)
    //So we need to map the range [0,512] to [0,22050]
    spectrumRange = (stream.getFormat().getSampleRate() / 2) / (fftBufferSize / 2);

    //Printing some nice data
    println(samples + " samples divided into " + blocks + " blocks, of " + fftBufferSize + " samples each.");
    println("Each block represents " + blockLength + " miliseconds of the song");
    println("Each spectrum ray represents roughly " + spectrumRange + "hz");

    for (int i = 0; i < blocks; i++)
    {
      //Reading the file to our buffer
      stream.read( buffer );

      //Mixing all channels of the song in channel 0
      float temp;
      //Iterates over each buffer sample
      for (int p = 0; p < buffer.getBufferSize (); p++)
      {
        temp = 0;
        //For each sample, iterate over all channels
        for (int q = 0; q < stream.getFormat ().getChannels(); q++)
        {
          //Store the channel values in a temp variable
          temp += buffer.getSample(q, p);
        }
        //Set the mean value of channels in channel 0 (mixing channels in channel 0)
        buffer.setSample(0, p, (temp / stream.getFormat().getChannels()));
      }

      //FFTing the mixed channel
      fft.forward( buffer.getChannel(0) );

      //Save the band value in our multi-dimensional array
      //s
  
      for (int j = 0; j < fftBufferSize/2; j++)
      {
        spectrum[i][j] = fft.getBand(j);
      }
    }
  }
}

