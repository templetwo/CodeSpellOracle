import Foundation

struct LevelDefinitions {
    static let allLevels: [Level] = [
        // LEVEL 1
        Level(
            number: 1,
            title: "The Measuring Charm",
            difficulty: .beginner,
            concept: .functions,
            story: "In the dusty archives of the Great Library, you discover your first spell.\nThis ancient charm can measure the length of any magical word.",
            oracleSays: "Every word has power, but first you must learn to measure it.",
            description: "Create a function 'get_length' that returns the length of a string.",
            functionName: "get_length",
            example: "def get_length(word):\n    return len(word)",
            testCases: [
                TestCase(inputs: ["Magic"], expectedOutput: "5"),
                TestCase(inputs: [""], expectedOutput: "0"),
                TestCase(inputs: ["Pythoria"], expectedOutput: "8")
            ],
            hints: [
                "Use the len() function",
                "Remember: len(word) not len(5)"
            ],
            solution: "def get_length(word):\n    return len(word)",
            xpReward: 10,
            manaReward: 5
        ),
        
        // LEVEL 2
        Level(
            number: 2,
            title: "The Binding Spell",
            difficulty: .beginner,
            concept: .functions,
            story: "Two ancient trees speak in whispers. Bind their words to hear their wisdom.",
            oracleSays: "Two become one, with space between.",
            description: "Create 'combine_words' that joins two words with a space.",
            functionName: "combine_words",
            example: "def combine_words(word1, word2):\n    return word1 + \" \" + word2",
            testCases: [
                TestCase(inputs: ["Hello", "World"], expectedOutput: "Hello World"),
                TestCase(inputs: ["Python", "Magic"], expectedOutput: "Python Magic")
            ],
            hints: [
                "Use + to join strings",
                "Don't forget the space: \" \""
            ],
            solution: "def combine_words(word1, word2):\n    return word1 + \" \" + word2",
            xpReward: 10,
            manaReward: 5
        ),
        
        // LEVEL 3
        Level(
            number: 3,
            title: "The Summoning",
            difficulty: .beginner,
            concept: .functions,
            story: "Numbers float like fireflies. Summon their combined strength!",
            oracleSays: "Mathematics is the purest magic.",
            description: "Create 'add_numbers' that adds two numbers.",
            functionName: "add_numbers",
            example: "def add_numbers(a, b):\n    return a + b",
            testCases: [
                TestCase(inputs: ["2", "3"], expectedOutput: "5"),
                TestCase(inputs: ["10", "-5"], expectedOutput: "5"),
                TestCase(inputs: ["0", "0"], expectedOutput: "0")
            ],
            hints: ["Use the + operator"],
            solution: "def add_numbers(a, b):\n    return a + b",
            xpReward: 10,
            manaReward: 5
        ),
        
        // LEVEL 4
        Level(
            number: 4,
            title: "The Echo Enchantment",
            difficulty: .beginner,
            concept: .strings,
            story: "In the Valley of Echoes, control the repetition of sounds.",
            oracleSays: "Repetition is the mother of mastery.",
            description: "Create 'repeat_string' that repeats a string n times.",
            functionName: "repeat_string",
            example: "def repeat_string(text, times):\n    return text * times",
            testCases: [
                TestCase(inputs: ["Ha", "3"], expectedOutput: "HaHaHa"),
                TestCase(inputs: ["!", "5"], expectedOutput: "!!!!!"),
                TestCase(inputs: ["", "10"], expectedOutput: "")
            ],
            hints: ["String * number repeats it"],
            solution: "def repeat_string(text, times):\n    return text * int(times)",
            xpReward: 15,
            manaReward: 7
        ),
        
        // LEVEL 5
        Level(
            number: 5,
            title: "The Decision Gate",
            difficulty: .intermediate,
            concept: .conditionals,
            story: "At the Gate of Decisions, paths diverge based on even and odd.",
            oracleSays: "Every choice creates a different destiny.",
            description: "Create 'check_even_odd' that returns 'even' or 'odd'.",
            functionName: "check_even_odd",
            example: "def check_even_odd(num):\n    if int(num) % 2 == 0:\n        return \"even\"\n    else:\n        return \"odd\"",
            testCases: [
                TestCase(inputs: ["4"], expectedOutput: "even"),
                TestCase(inputs: ["7"], expectedOutput: "odd"),
                TestCase(inputs: ["0"], expectedOutput: "even")
            ],
            hints: [
                "Use % for modulo",
                "num % 2 == 0 means even"
            ],
            solution: "def check_even_odd(num):\n    if int(num) % 2 == 0:\n        return \"even\"\n    else:\n        return \"odd\"",
            xpReward: 20,
            manaReward: 10
        ),
        
        // LEVEL 6
        Level(
            number: 6,
            title: "The Gathering",
            difficulty: .intermediate,
            concept: .lists,
            story: "In the Tournament of Numbers, find the mightiest.",
            oracleSays: "In any gathering, one rises above.",
            description: "Create 'find_max' that finds the maximum in a list.",
            functionName: "find_max",
            example: "def find_max(numbers):\n    return max([int(n) for n in numbers])",
            testCases: [
                TestCase(inputs: ["1", "5", "3", "9", "2"], expectedOutput: "9"),
                TestCase(inputs: ["-5", "-2", "-10"], expectedOutput: "-2")
            ],
            hints: ["Use max() function"],
            solution: "def find_max(*numbers):\n    return str(max([int(n) for n in numbers]))",
            xpReward: 20,
            manaReward: 10
        ),
        
        // LEVEL 7
        Level(
            number: 7,
            title: "The Transformation",
            difficulty: .intermediate,
            concept: .strings,
            story: "Words can change form. Master the art of transformation!",
            oracleSays: "True power lies in transformation.",
            description: "Create 'title_case' that capitalizes first letters of each word.",
            functionName: "title_case",
            example: "def title_case(text):\n    return text.title()",
            testCases: [
                TestCase(inputs: ["hello world"], expectedOutput: "Hello World"),
                TestCase(inputs: ["python programming"], expectedOutput: "Python Programming"),
                TestCase(inputs: ["code spell oracle"], expectedOutput: "Code Spell Oracle")
            ],
            hints: ["Use .title() method", "String methods are your friends"],
            solution: "def title_case(text):\n    return text.title()",
            xpReward: 20,
            manaReward: 10
        ),
        
        // LEVEL 8
        Level(
            number: 8,
            title: "The Multiplication Ritual",
            difficulty: .intermediate,
            concept: .lists,
            story: "The Doubling Ceremony requires mass enchantment.",
            oracleSays: "Transform the many as easily as the one.",
            description: "Create 'double_all' that doubles all numbers in a list.",
            functionName: "double_all",
            example: "def double_all(numbers):\n    return [int(n) * 2 for n in numbers]",
            testCases: [
                TestCase(inputs: ["1", "2", "3"], expectedOutput: "[2, 4, 6]"),
                TestCase(inputs: ["0", "-1", "5"], expectedOutput: "[0, -2, 10]"),
                TestCase(inputs: [], expectedOutput: "[]")
            ],
            hints: ["Use list comprehension", "[n * 2 for n in numbers]"],
            solution: "def double_all(*numbers):\n    return [int(n) * 2 for n in numbers]",
            xpReward: 25,
            manaReward: 12
        ),
        
        // LEVEL 9
        Level(
            number: 9,
            title: "The Keeper of Secrets",
            difficulty: .advanced,
            concept: .dictionaries,
            story: "Count the frequencies of letters to reveal hidden patterns.",
            oracleSays: "To truly know something, count its every part.",
            description: "Create 'count_letters' that counts character frequency.",
            functionName: "count_letters",
            example: "def count_letters(text):\n    counts = {}\n    for char in text:\n        counts[char] = counts.get(char, 0) + 1\n    return counts",
            testCases: [
                TestCase(inputs: ["hello"], expectedOutput: "{'h': 1, 'e': 1, 'l': 2, 'o': 1}"),
                TestCase(inputs: [""], expectedOutput: "{}"),
                TestCase(inputs: ["aaa"], expectedOutput: "{'a': 3}")
            ],
            hints: ["Use a dictionary", "dict.get(key, 0) for safe access"],
            solution: "def count_letters(text):\n    counts = {}\n    for char in text:\n        counts[char] = counts.get(char, 0) + 1\n    return counts",
            xpReward: 30,
            manaReward: 15
        ),
        
        // LEVEL 10
        Level(
            number: 10,
            title: "The Grand Reversal",
            difficulty: .advanced,
            concept: .strings,
            story: "At Mirror Lake, identify palindromes - perfect symmetry.",
            oracleSays: "In perfect symmetry lies ultimate mastery.",
            description: "Create 'is_palindrome' that checks for palindromes.",
            functionName: "is_palindrome",
            example: "def is_palindrome(text):\n    cleaned = text.replace(' ', '').lower()\n    return cleaned == cleaned[::-1]",
            testCases: [
                TestCase(inputs: ["racecar"], expectedOutput: "True"),
                TestCase(inputs: ["hello"], expectedOutput: "False"),
                TestCase(inputs: ["A man a plan a canal Panama"], expectedOutput: "True")
            ],
            hints: ["Remove spaces and lowercase", "Use [::-1] to reverse"],
            solution: "def is_palindrome(text):\n    cleaned = text.replace(' ', '').lower()\n    return str(cleaned == cleaned[::-1])",
            xpReward: 35,
            manaReward: 17
        ),
        
        // LEVEL 11
        Level(
            number: 11,
            title: "The Filter of Truth",
            difficulty: .advanced,
            concept: .loops,
            story: "Filter the worthy from the unworthy with your spell.",
            oracleSays: "Not all who apply shall pass the test.",
            description: "Create 'filter_evens' that returns only even numbers.",
            functionName: "filter_evens",
            example: "def filter_evens(numbers):\n    return [int(n) for n in numbers if int(n) % 2 == 0]",
            testCases: [
                TestCase(inputs: ["1", "2", "3", "4", "5"], expectedOutput: "[2, 4]"),
                TestCase(inputs: ["1", "3", "5"], expectedOutput: "[]"),
                TestCase(inputs: ["2", "4", "6"], expectedOutput: "[2, 4, 6]")
            ],
            hints: ["Use list comprehension with condition", "[n for n in numbers if condition]"],
            solution: "def filter_evens(*numbers):\n    return [int(n) for n in numbers if int(n) % 2 == 0]",
            xpReward: 40,
            manaReward: 20
        ),
        
        // LEVEL 12
        Level(
            number: 12,
            title: "The Sum of All",
            difficulty: .advanced,
            concept: .loops,
            story: "Combine the power of all numbers into one.",
            oracleSays: "Unity brings strength.",
            description: "Create 'sum_list' that returns the sum of all numbers.",
            functionName: "sum_list",
            example: "def sum_list(numbers):\n    return sum([int(n) for n in numbers])",
            testCases: [
                TestCase(inputs: ["1", "2", "3"], expectedOutput: "6"),
                TestCase(inputs: [], expectedOutput: "0"),
                TestCase(inputs: ["-1", "-2", "3"], expectedOutput: "0")
            ],
            hints: ["Python has a sum() function"],
            solution: "def sum_list(*numbers):\n    return sum([int(n) for n in numbers])",
            xpReward: 40,
            manaReward: 20
        ),
        
        // LEVEL 13
        Level(
            number: 13,
            title: "The Fibonacci Sequence",
            difficulty: .expert,
            concept: .loops,
            story: "The ancient sequence holds the key to natural harmony.",
            oracleSays: "Each number is born from its ancestors.",
            description: "Create 'fibonacci' that returns the nth Fibonacci number.",
            functionName: "fibonacci",
            example: "def fibonacci(n):\n    if int(n) <= 1:\n        return int(n)\n    a, b = 0, 1\n    for _ in range(2, int(n) + 1):\n        a, b = b, a + b\n    return b",
            testCases: [
                TestCase(inputs: ["0"], expectedOutput: "0"),
                TestCase(inputs: ["1"], expectedOutput: "1"),
                TestCase(inputs: ["5"], expectedOutput: "5"),
                TestCase(inputs: ["10"], expectedOutput: "55")
            ],
            hints: ["Start with 0, 1", "Each number = sum of previous two"],
            solution: "def fibonacci(n):\n    n = int(n)\n    if n <= 1:\n        return n\n    a, b = 0, 1\n    for _ in range(2, n + 1):\n        a, b = b, a + b\n    return b",
            xpReward: 50,
            manaReward: 25
        ),
        
        // LEVEL 14
        Level(
            number: 14,
            title: "The Sorting Hat",
            difficulty: .expert,
            concept: .lists,
            story: "Order brings clarity. Sort the chaos into harmony.",
            oracleSays: "From chaos, create order.",
            description: "Create 'sort_numbers' that returns a sorted list.",
            functionName: "sort_numbers",
            example: "def sort_numbers(numbers):\n    return sorted([int(n) for n in numbers])",
            testCases: [
                TestCase(inputs: ["3", "1", "2"], expectedOutput: "[1, 2, 3]"),
                TestCase(inputs: ["5", "2", "8", "1"], expectedOutput: "[1, 2, 5, 8]"),
                TestCase(inputs: [], expectedOutput: "[]")
            ],
            hints: ["Use sorted() function"],
            solution: "def sort_numbers(*numbers):\n    return sorted([int(n) for n in numbers])",
            xpReward: 50,
            manaReward: 25
        ),
        
        // LEVEL 15
        Level(
            number: 15,
            title: "The Prime Detective",
            difficulty: .expert,
            concept: .loops,
            story: "Identify the prime numbers - the fundamental building blocks.",
            oracleSays: "Some numbers are indivisible, pure.",
            description: "Create 'is_prime' that checks if a number is prime.",
            functionName: "is_prime",
            example: "def is_prime(n):\n    n = int(n)\n    if n < 2:\n        return False\n    for i in range(2, int(n**0.5) + 1):\n        if n % i == 0:\n            return False\n    return True",
            testCases: [
                TestCase(inputs: ["2"], expectedOutput: "True"),
                TestCase(inputs: ["4"], expectedOutput: "False"),
                TestCase(inputs: ["17"], expectedOutput: "True"),
                TestCase(inputs: ["1"], expectedOutput: "False")
            ],
            hints: ["Check divisibility up to sqrt(n)", "2 is the smallest prime"],
            solution: "def is_prime(n):\n    n = int(n)\n    if n < 2:\n        return False\n    for i in range(2, int(n**0.5) + 1):\n        if n % i == 0:\n            return False\n    return True",
            xpReward: 60,
            manaReward: 30
        ),
        
        // LEVEL 16
        Level(
            number: 16,
            title: "The Factorial Force",
            difficulty: .master,
            concept: .functions,
            story: "Calculate the factorial - the product of all ancestors.",
            oracleSays: "Every number carries the weight of its predecessors.",
            description: "Create 'factorial' that calculates n!",
            functionName: "factorial",
            example: "def factorial(n):\n    n = int(n)\n    if n <= 1:\n        return 1\n    result = 1\n    for i in range(2, n + 1):\n        result *= i\n    return result",
            testCases: [
                TestCase(inputs: ["0"], expectedOutput: "1"),
                TestCase(inputs: ["1"], expectedOutput: "1"),
                TestCase(inputs: ["5"], expectedOutput: "120"),
                TestCase(inputs: ["10"], expectedOutput: "3628800")
            ],
            hints: ["5! = 5*4*3*2*1", "0! = 1 by definition"],
            solution: "def factorial(n):\n    n = int(n)\n    if n <= 1:\n        return 1\n    result = 1\n    for i in range(2, n + 1):\n        result *= i\n    return result",
            xpReward: 70,
            manaReward: 35
        ),
        
        // LEVEL 17
        Level(
            number: 17,
            title: "The Binary Converter",
            difficulty: .master,
            concept: .functions,
            story: "Convert numbers to their binary essence.",
            oracleSays: "All complexity reduces to ones and zeros.",
            description: "Create 'to_binary' that converts a number to binary string.",
            functionName: "to_binary",
            example: "def to_binary(n):\n    return bin(int(n))[2:]",
            testCases: [
                TestCase(inputs: ["5"], expectedOutput: "101"),
                TestCase(inputs: ["10"], expectedOutput: "1010"),
                TestCase(inputs: ["0"], expectedOutput: "0"),
                TestCase(inputs: ["255"], expectedOutput: "11111111")
            ],
            hints: ["Use bin() function", "Remove '0b' prefix"],
            solution: "def to_binary(n):\n    return bin(int(n))[2:]",
            xpReward: 70,
            manaReward: 35
        ),
        
        // LEVEL 18
        Level(
            number: 18,
            title: "The Anagram Alchemist",
            difficulty: .master,
            concept: .strings,
            story: "Detect if two words are anagrams - same letters, different order.",
            oracleSays: "Same elements, different arrangement.",
            description: "Create 'are_anagrams' that checks if two strings are anagrams.",
            functionName: "are_anagrams",
            example: "def are_anagrams(str1, str2):\n    return sorted(str1.lower()) == sorted(str2.lower())",
            testCases: [
                TestCase(inputs: ["listen", "silent"], expectedOutput: "True"),
                TestCase(inputs: ["hello", "world"], expectedOutput: "False"),
                TestCase(inputs: ["Dormitory", "dirtyroom"], expectedOutput: "True")
            ],
            hints: ["Sort both strings", "Ignore case and spaces"],
            solution: "def are_anagrams(str1, str2):\n    s1 = str1.replace(' ', '').lower()\n    s2 = str2.replace(' ', '').lower()\n    return str(sorted(s1) == sorted(s2))",
            xpReward: 80,
            manaReward: 40
        ),
        
        // LEVEL 19
        Level(
            number: 19,
            title: "The Matrix Multiplier",
            difficulty: .master,
            concept: .lists,
            story: "Multiply a matrix by a scalar - transform all elements.",
            oracleSays: "Transform the whole by transforming each part.",
            description: "Create 'scalar_multiply' that multiplies matrix by scalar.",
            functionName: "scalar_multiply",
            example: "def scalar_multiply(matrix, scalar):\n    # matrix is string representation\n    # return multiplied matrix",
            testCases: [
                TestCase(inputs: ["[[1,2],[3,4]]", "2"], expectedOutput: "[[2, 4], [6, 8]]"),
                TestCase(inputs: ["[[5]]", "3"], expectedOutput: "[[15]]"),
                TestCase(inputs: ["[[1,2,3]]", "0"], expectedOutput: "[[0, 0, 0]]")
            ],
            hints: ["Nested list comprehension", "Process each row, then each cell"],
            solution: "def scalar_multiply(matrix, scalar):\n    import ast\n    m = ast.literal_eval(matrix)\n    return [[cell * int(scalar) for cell in row] for row in m]",
            xpReward: 90,
            manaReward: 45
        ),
        
        // LEVEL 20
        Level(
            number: 20,
            title: "The Ultimate Cipher",
            difficulty: .master,
            concept: .advanced,
            story: "The Caesar cipher - shift letters to encode messages.",
            oracleSays: "Knowledge is power, encryption is protection.",
            description: "Create 'caesar_cipher' that shifts letters by n positions.",
            functionName: "caesar_cipher",
            example: "def caesar_cipher(text, shift):\n    result = []\n    for char in text:\n        if char.isalpha():\n            ascii_offset = 65 if char.isupper() else 97\n            result.append(chr((ord(char) - ascii_offset + int(shift)) % 26 + ascii_offset))\n        else:\n            result.append(char)\n    return ''.join(result)",
            testCases: [
                TestCase(inputs: ["ABC", "1"], expectedOutput: "BCD"),
                TestCase(inputs: ["xyz", "1"], expectedOutput: "yza"),
                TestCase(inputs: ["Hello World", "3"], expectedOutput: "Khoor Zruog")
            ],
            hints: ["Use ord() and chr()", "Handle wrap-around (Z->A)"],
            solution: "def caesar_cipher(text, shift):\n    result = []\n    shift = int(shift)\n    for char in text:\n        if char.isalpha():\n            ascii_offset = 65 if char.isupper() else 97\n            result.append(chr((ord(char) - ascii_offset + shift) % 26 + ascii_offset))\n        else:\n            result.append(char)\n    return ''.join(result)",
            xpReward: 100,
            manaReward: 50
        )
    ]
}
