# Single-pixel-ptychography (SPY)
This repository contains the MATLAB code for the paper Single-pixel ptychography by Meng Li, Liheng Bian, Guoan Zheng, Andrew Maiden, Yang Liu, Yiming Li, Qionghai Dai, and Jun Zhang. 


# Usage

## Download the single-pixel-ptychography repository

Download this repository via git

    git clone https://github.com/bianlab/single-pixel-ptychography

or download the zip file manually.

## Run SPY

Simulate the complete process of single-pixel-ptychography and test the single-pixel phase retrieval algorithm via

    SPY.m

This Demo gives the reconstruction of a simulated complex-field object.


# Structure of directories

    data: images used for reconstruction (simulated)
    GoldsteinUnwrap2D_r1: Goldstein's branch cut method of 2D phase unwrapping (https://www.mathworks.com/matlabcentral/fileexchange/29497-goldsteinunwrap2d_r1)


# Platform

The test platform is MATLAB(R) 2016a operating on Windows 10 (x64) with a 3.6 GHz Intel Core i7 processor and 16 GB RAM. It can run on any machine with MATLAB(R), operating on Windows(R), Linux, or Mac OS. No GPU is needed to run this code.
