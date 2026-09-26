from blockchain import Blockchain


blockchain = Blockchain()

print("Adding Block 1...")
blockchain.add_block("Alice -> Bob : ₹100")

print("\nAdding Block 2...")
blockchain.add_block("Bob -> Charlie : ₹50")

print("\nAdding Block 3...")
blockchain.add_block("Charlie -> David : ₹25")


print("\nBlockchain:")
for block in blockchain.chain:
    print("--------------------------------")
    print("Index:", block.index)
    print("Transaction:", block.transaction)
    print("Previous Hash:", block.previous_hash)
    print("Hash:", block.hash)
    print("Nonce:", block.nonce)


print("\nIs blockchain valid?")
print(blockchain.is_chain_valid())

print("\nTampering with Block 1...")

blockchain.chain[1].transaction = "Alice -> Bob : ₹1000000"

print("Is blockchain valid after tampering?")
print(blockchain.is_chain_valid())