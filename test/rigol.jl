using scopehal

t = scopehal.CreateTransport("lan", "192.168.1.224:5555")
@assert scopehal.IsConnected(t)
o = scopehal.CreateOscilloscope("rigol", t)

scopehal.SetSampleDepth(o, 1000)
ch = scopehal.GetChannel(o, 0)
# scopehal.ForceTrigger(o)
println("acquiring data")
scopehal.PollTrigger(o)
scopehal.AcquireData(o)

while scopehal.HasPendingWaveforms(o)
    scopehal.PopPendingWaveform(o)
end

println("ready to get data")
d = scopehal.AnalogWaveformData(scopehal.GetData(ch, 0))
println(d)