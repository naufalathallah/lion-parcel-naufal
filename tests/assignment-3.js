function sortEvenOddDesc(arr) {
    // Separate even and odd numbers
    const evens = arr.filter(num => num % 2 === 0).sort((a, b) => b - a);
    const odds = arr.filter(num => num % 2 !== 0).sort((a, b) => b - a);

    // Combine
    return [...evens, ...odds];
}

const inputArray = [3, 2, 5, 1, 8, 9, 6];
const sortedArray = sortEvenOddDesc(inputArray);

console.log("Input:", inputArray);
console.log("Output:", sortedArray);
