# Bug Description
The bug description should be clear and concise, but being clear is the most important part. You should put yourself in the shoes of the project team and ask yourself the question: Am I describing the vulnerability and its impact clearly, accurately, and without any unnecessary assumptions? 

# Brief/Intro
Provide a very short and concise (one paragraph) statement on what the problem is, and what the consequences would be if the bug were exploited in the wild. 

# Details
Offer a detailed explanation of the vulnerability itself. Do not leave out any relevant information. Code snippets should be supplied whenever helpful, as long as they don’t overcrowd the report with unnecessary details. This section should make it obvious that you understand exactly what you’re talking about, and more importantly, it should be clear by this point that the vulnerability does exist. 

# Impact
This section is where you provide a detailed breakdown of possible losses from an exploit, especially if there are funds at risk. This illustrates the severity of the vulnerability, but it also provides the best possible case for you to be paid your fair share. Make sure the selected impact is within the project’s list of in-scope impacts.

# Risk Breakdown
You should assess how difficult it is to exploit the disclosed vulnerability. The NIST’s Common Vulnerability Scoring System Calculator is not well-suited for addressing a blockchain/DLT bug. We recommend using the Immunefi Vulnerability Severity Classification System instead.

# Recommendation
You should include a recommendation on how to fix the bug (or mitigate the impact) in this section. Once again, this actually helps make the case for a good payout, as it illustrates your expertise and further explains the underlying vulnerability.

# References
In this section, you are welcome to add any relevant links to documentation or smart contracts. But most importantly, this is where you write the Proof of Concept (when required).

# Proof of Concept
This section is crucial, because it makes the vulnerability “real” in a way that nothing else can. Unfortunately, this is also the section that whitehats most often fail to fill out correctly. The first and most important component of a successful proof of concept (PoC) is that it should be runnable exploit code…

* not a list of steps (even though this can exist somewhere in the report)
* not pseudo-code
* not just the project’s smart contracts
* …but an actual, runnable attack vector. A valid PoC might be an attack script (a Hardhat/Foundry test file, for example), a smart contract with functions that can trigger the exploit, or any code that manages to somehow exploit the project’s vulnerability. 