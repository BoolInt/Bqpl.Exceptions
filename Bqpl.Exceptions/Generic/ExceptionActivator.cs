using System;

namespace Bqpl.Exceptions.Generic
{
  public static partial class ExceptionActivator
  {
    public static T Create<T>(string message)
      where T : Exception
    {
      return Create<T>((object)message);
    }

    private static T Create<T>(params object[] args)
              where T : Exception
    {
      return (T)Activator.CreateInstance(typeof(T), args);
    }
  }
}