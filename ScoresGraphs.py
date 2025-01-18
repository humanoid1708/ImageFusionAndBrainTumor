import matplotlib.pyplot as graph
import pandas as pd

data = pd.read_csv('Values.csv')

graph.figure(1)
graph.plot(data['Images'], data['Initial Entropy CT'], color = 'orange', linestyle = '--', label = 'Initial Entropy CT')
graph.plot(data['Images'], data['Initial Entropy MRI'], color = 'blue', linestyle = '--', label = 'Initial Entropy MRI')
graph.plot(data['Images'], data['Entropy after Preprocessing CT'], color = 'orange', label = 'Entropy after Preprocessing CT')
graph.plot(data['Images'], data['Entropy after Preprocessing MRI'], color = 'blue', label = 'Entropy after Preprocessing MRI')
graph.plot(data['Images'], data['Entropy after Fusion'], color = 'green', label = 'Entropy after Fusion')
graph.plot(data['Images'], data['Final Entropy after Postprocessing'], color = 'red', label = 'Final Entropy after Postprocessing')
graph.xlabel('Images')
graph.ylabel('Entropy')
graph.legend()

graph.figure(2)
graph.plot(data['Images'], data['Initial NIQE CT'], color = 'orange', linestyle = '--', label = 'Initial NIQE CT')
graph.plot(data['Images'], data['Initial NIQE MRI'], color = 'blue', linestyle = '--', label = 'Initial NIQE MRI')
graph.plot(data['Images'], data['NIQE after Preprocessing CT'], color = 'orange', label = 'NIQE after Preprocessing CT')
graph.plot(data['Images'], data['NIQE after Preprocessing MRI'], color = 'blue', label = 'NIQE after Preprocessing MRI')
graph.plot(data['Images'], data['NIQE after Fusion'], color = 'green', label = 'NIQE after Fusion')
graph.plot(data['Images'], data['Final NIQE after Postprocessing'], color = 'red', label = 'Final NIQE after Postprocessing')
graph.xlabel('Images')
graph.ylabel('NIQE Score')
graph.legend()

graph.figure(3)
graph.plot(data['Images'], data['Initial BRISQUE CT'], color = 'orange', linestyle = '--', label = 'Initial BRISQUE CT')
graph.plot(data['Images'], data['Initial BRISQUE MRI'], color = 'blue', linestyle = '--', label = 'Initial BRISQUE MRI')
graph.plot(data['Images'], data['BRISQUE after Preprocessing CT'], color = 'orange', label = 'BRISQUE after Preprocessing CT')
graph.plot(data['Images'], data['BRISQUE after Preprocessing MRI'], color = 'blue', label = 'BRISQUE after Preprocessing MRI')
graph.plot(data['Images'], data['BRISQUE after Fusion'], color = 'green', label = 'BRISQUE after Fusion')
graph.plot(data['Images'], data['Final BRISQUE after Postprocessing'], color = 'red', label = 'Final BRISQUE after Postprocessing')
graph.xlabel('Images')
graph.ylabel('BRISQUE Score')
graph.legend()

graph.show()