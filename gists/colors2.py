for i in range(256):
    print(f"\x1b[38;5;{i}m {i:>3}", end='')
    if i == 15 or (i > 15 and (i - 15) % 12 == 0):
        print()
