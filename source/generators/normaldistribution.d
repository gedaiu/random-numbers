module generators.normaldistribution;

public import std.range;

import tested;
import israndomgenerator;
import std.random;
import std.algorithm.comparison;
import std.math;
import std.stdio;

double z0, z1;
bool shouldGenerate;

auto normal(double mu, double sigma)() {
  const double epsilon = double.min_normal;
  const double tau = 2 * PI;

  shouldGenerate = !shouldGenerate;

  if (!shouldGenerate)
  {
    return z1 * sigma + mu;
  }

  double u1, u2;
  do
  {
    u1 = uniform!("[]", double, double)(0,1);
    u2 = uniform!("[]", double, double)(0,1);
  }
  while( u1 <= epsilon);

  z0 = sqrt(-2.0 * log(u1)) * cos(tau * u2);
  z1 = sqrt(-2.0 * log(u1)) * sin(tau * u2);
  return z0 * sigma + mu;

}

@name("it should return true for a normal distribution random generator")
unittest {
  alias normalDistribution = normal!(0.5, 0.15);

  auto generator = generate!normalDistribution();

  auto result = isRandomGenerator(generator);
  assert(result == true);
}
