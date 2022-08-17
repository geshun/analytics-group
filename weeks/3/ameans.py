def product(x):
    """computes the product of numbers in an iterable object

    Args:
        x (list or tuple): an iterable object containing numbers

    Returns:
        float: product of the numbers
    """
    result = 1
    for val in x:
        result *= val
    return result


def arithmetic_mean(x):
    """computes arithmetic mean of numbers in an iterable object

    Args:
        x (list or tuple): an iterable object containing numbers

    Returns:
        float: arithmetic mean of the numbers
    """
    result = sum(x) / len(x)
    return result


def geometric_mean(x):
    """computes geometric mean of numbers in an iterable object

    Args:
        x (list or tuple): an iterable object containing numbers

    Returns:
        float: geometric mean of the numbers
    """
    result = product(x) ** (1 / len(x))
    return result


def harmonic_mean(x):
    """computes harmonic mean of numbers in an iterable object

    Args:
        x (list or tuple): an iterable object containing numbers

    Returns:
        float: harmonic mean of the numbers
    """
    x = [1 / val for val in x]
    result = len(x) / sum(x)
    return result


class Means:
    """common means of numbers in an iterable object
    """

    def __init__(self, x):
        """initiates an iterable object to the Means class

        Args:
            x (list or tuple): an iterable object containing numbers
        """
        self.x = x

    def product(self):
        """finds product of items in the list

        Returns:
            float: product of the items
        """
        result = 1
        for val in self.x:
            result *= val
        return result

    def arithmetic_mean(self):
        """finds arithmetic mean of items in the list

        Returns:
            float: arithmetic mean of the items
        """
        result = sum(self.x) / len(self.x)
        return result

    def geometric_mean(self):
        """finds geometric mean of items in the list

        Returns:
            float: geometric mean of the items
        """
        result = Means.product(self) ** (1 / len(self.x))
        return result

    def harmonic_mean(self):
        """finds harmonic mean of the items in the list

        Returns:
            float: harmonic mean of the items
        """
        x_ = [1 / val for val in self.x]
        result = len(x_) / sum(x_)
        return result
