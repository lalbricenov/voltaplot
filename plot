#!/usr/bin/env python3
# -*- coding: utf-8 -*-


# Program that receives the name of a data file and makes a histogram.
import matplotlib.pyplot as plt
from math import sqrt, floor


def printError():
  print("ERROR: el número de intervalos debe ser un número entero positivo.")

while True:
  try:
    fileName = input("Ingrese el nombre del archivo con los datos (Enter para usar datos.txt): ")
    if fileName == "":
      fileName = "datos.txt"
    dataFile = open(fileName, 'r')
    break
  except IOError:
    print("ERROR: Imposible abrir el archivo. Intente de nuevo")

# Storing data in a list as floating point numbers
data = dataFile.read().split('\n')
dataFile.close()
data = list(map(float, data))
print(f"{len(data)} datos importados")
# Receiving the number of intervals
# Ideal number of intervals
idealN = floor(sqrt(len(data)))
while True:
  try:
    n = input("Ingrese el número de intervalos (Enter para usar predeterminado): ")
    if n == "":
      n = idealN
      print(f"Usando {n} intervalos.")

    # Convert from string to int
    n = int(n)

    # Ask the user for n again if it is less than 1
    if n < 1:
      printError()
      continue

    # If none of the previous instructions have raised an exception exit the loop
    break
  except ValueError:
    printError()

if n < 4 or n > 2 * idealN:
  print(f"ADVERTENCIA: se recomienda usar un número de intervalos entre 4 y {2*idealN}")

plt.hist(data, bins=n)  # arguments are passed to np.histogram
#plt.title("Histogram with 'auto' bins")

# Axis labels
xlab = input("Ingrese el nombre del eje horizontal (enter para predeterminado): ")
ylab = input("Ingrese el nombre del eje vertical (enter para predeterminado): ")

if xlab == "":
  xlab = "Valor"
if ylab == "":
  ylab = "Frecuencia"

plt.xlabel(xlab)
plt.ylabel(ylab)
histFileName = "histograms/Histograma.png"
plt.savefig(histFileName)
print("Histograma guardado como: " + histFileName)