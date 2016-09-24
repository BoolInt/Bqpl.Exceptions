using Bqpl.Contracts;
using System;
using System.Diagnostics.Contracts;

namespace Bqpl.Exceptions
{
  public static partial class ExceptionActivator
  {
    [Pure]
    public static ArgumentException CreateArgumentException(string argumentName, MessageText message)
    {
      Argument.NotNullOrEmpty(nameof(argumentName), argumentName);
      Argument.NotNull(nameof(message), message);

      return new ArgumentException(message.Text, argumentName);
    }

    [Pure]
    public static ArgumentException CreateArgumentException(string argumentName)
    {
      Argument.NotNullOrEmpty(nameof(argumentName), argumentName);

      return new ArgumentException(string.Empty, argumentName);
    }

    [Pure]
    public static ArgumentNullException CreateArgumentNullException(string argumentName, MessageText message)
    {
      Argument.NotNullOrEmpty(nameof(argumentName), argumentName);
      Argument.NotNull(nameof(message), message);

      return new ArgumentNullException(argumentName, message.Text);
    }

    [Pure]
    public static ArgumentNullException CreateArgumentNullException(string argumentName)
    {
      return new ArgumentNullException(argumentName);
    }
  }
}