# Agentic RAG Approach: Graph Memory and Cognitive Processing

## Core Ideologies from the Author's Approach (CrabRAG)
In the presentation **"CrabRAG: Why Automated Assistants Need Graph Memory, Not More Tokens,"** Stephen Chin from Neo4j explores the limitations of current AI agent memory systems and proposes Graph Retrieval-Augmented Generation (GraphRAG) as a far more effective solution.

### 1. The "Bad Memory" Problem in AI Agents
Current agents (like OpenClaw or Goose) often treat memory as a collection of markdown files injected straight into the context window. 
* **Token Waste & Context Limits:** Stuffing all available memory into the context window is repetitive and wastes tokens. While this brute-force method might work at a small scale, it completely fails at scale when navigating large enterprise environments that demand highly specialized knowledge.
* **Amnesia:** Without an effective memory architecture, agents often "forget" yesterday's interactions, forcing users to continuously re-teach the agent the same context. 

### 2. Limitations of Standard Vector Databases
While vector databases allow for similarity searches via embeddings, they fall short in executing complex, domain-specific tasks:
* **Similarity Does Not Equal Relationship:** Vector databases return data that is similar in vector space but may not share actual logical relationships. This frequently leads to hallucinations and pulling irrelevant context.
* **Failure in Multi-hop Reasoning:** Standard vector searches struggle to connect the dots across complex, multi-hop reasoning chains (e.g., trying to trace an outdated OS vulnerability across a nested network topology to see if it's exposed to the WAN). 

### 3. The Power of Graph Memory
Graph memory remedies these flaws by constructing a connected knowledge structure using first-class nodes and edges to mathematically represent relationships.
* **Hybrid Search Architecture:** The ideal Agentic RAG approach couples Vector Search with Graph Search. Vector search quickly locates initial "seed nodes," and the Graph traverses the edges to reliably pull the nearest neighbors based on exact real-world relationships.
* **Accuracy and Explainability:** Graph databases provide precise, auditable, and explainable context. Because the memory is represented as nodes and edges, developers can trace the precise graph path an agent took to arrive at its answer.

---

## Compatibility with Human Brain Processing: Episodic vs. Semantic Memory

The transition from flat file storage to connected graph architectures strongly mirrors how the human brain processes and stores information through distinct yet integrated memory systems.

### Semantic Memory (The Graph)
In cognitive psychology, *semantic memory* is responsible for storing general world knowledge, hard facts, concepts, and relationships (e.g., "Paris is the capital of France"). 
* **Agentic Equivalent:** The Knowledge Graph acts as the agent's semantic memory. It maps out entities, definitions, and strict relationships (e.g., `[Server_A] -> [RUNS] -> [Outdated_OS]`). It provides the agent with structured "world knowledge" of its environment without needing to relearn it from scratch every time it encounters a related task.

### Episodic Memory (The Context/Interaction Log)
*Episodic memory* stores personal experiences, contextual events, and specific instances tied to a time and place (e.g., "I drank a coffee in Paris yesterday").
* **Agentic Equivalent:** For an agent to avoid waking up with a "flipped memory file," it requires episodic memory—a chronological, stateful ledger of its past interactions, chain-of-thought, user instructions, and previous tool invocations. 

### The Convergence (Agentic RAG)
Just as a human cross-references their past experiences (episodic) with established facts (semantic) to make intelligent decisions, an advanced Agentic RAG system relies on both. It remembers *what happened yesterday* (episodic memory) and grounds those experiences against the *hard facts of the network or domain* (semantic graph). This cognitive synthesis allows an agent to move beyond simple prompt-response interactions, establishing genuine autonomy and continuous, compounded learning.

---

## Complete Video Transcript

```text
[00:00:12] my name's Steven Chin i run the developer relations team here at Neo Forj and I'm excited to talk to
[00:00:22] you about something we've all come to love our our crustaceian friends so we have um um openclaw mascot we
[00:00:33] have a bunch of other crustaceians and we're going to we're going to focus on one member of the crustaceian
[00:00:39] family i I I love crab so our little boy Crab D and I think in the in the journey
[00:00:47] to to figure out how to apply agents how to do things which are more autonomous we're all looking for
[00:00:54] ways where we can get better results more accurate answers and to actually capture all of this but the tools
[00:01:01] kind of work against us so um here's our our friend Crab D he's he's a personal assistant very happy
[00:01:09] very eager he wants to to help us out with our lives maybe to help us to code to help
[00:01:15] us to you know manage our email to do different things but he's got a problem and our poor boy
[00:01:23] Krabby D has a very bad memory he wakes up every day and his memory file flips and now it's
[00:01:31] a new day and he forgets everything from yesterday has this happened to you where you you wake up and
[00:01:35] you're using Open Claw and suddenly it's on a new set of memory files and remembers nothing that you actually
[00:01:40] did the previous day
[00:01:44] he's got a lot of tools at his disposal i mean we love giving our agents tools but sometimes he
[00:01:49] doesn't pick the right tool for the job i don't think either of these are going to help him drink
[00:01:55] his his bowl of soup so that's not the tool which he was looking to to reach for
[00:02:03] and a little bit forgetful at times so you know I think I don't remember everybody I meet but I'm
[00:02:09] pretty good at faces like if I've if I've met you before I recognize faces it's like pleased to meet
[00:02:14] you um Crab D is not as good at that so very forgetful it's like you're retaching it every day
[00:02:21] to do the same sort of tasks and we want agents which are more helpful which are able to do
[00:02:25] more for us so let's dig into how CrabD actually works so it's basically a a memory loop right so
[00:02:34] we're we're prompting we're thinking about the response maybe calling tools observing what happens but the hard part is the
[00:02:43] memory the hard part is what you put in context what you're recalling from and the way you have memory
[00:02:51] structured in most tools this is an example of um how open cloth structures things is you have a sol
[00:02:57] for your agents memory you have maybe um memory files you have different tool files you have daily memory files
[00:03:04] now if you look at this there's one thing which is in common with all of these they're just markdown
[00:03:09] files so markdown files are great that's easy for us to read like we can we can look through it
[00:03:15] we can quickly figure out what's not needed and compact them um they're intentionally small for agents because you have
[00:03:23] a limited context window and also you need to keep the right things at the top of the context but
[00:03:29] if your whole memory is a bunch of markdown files you're wasting a lot of tokens so um my my
[00:03:37] average agents are are loading up at least 100k in tokens for each round um they're doing a a lot
[00:03:44] of skills they're adding a lot of things into the context constantly it's very repetitive because they they basically load
[00:03:51] up everything in the hopes that something will be useful in the context at small scale that works where you
[00:03:58] get the results you want with a high quality model it doesn't work at large scale and I'm going to
[00:04:03] show a demo of large scale where we take open claw and we let it run loose on my home
[00:04:09] lab so um high demo risk but a lot of fun and um a classic digital twin scenario so I
[00:04:17] think we'll have we'll have a lot of fun here um anybody use Hermes agent at all okay i'm I'm
[00:04:24] a big fan of Hermes agent um I think it's got a much better memory system it kind of at
[00:04:30] the end of each task it goes and it reflects and it adds back in new skills or new things
[00:04:35] which it needs so um it's a really powerful system and um you know again we're relying a lot on
[00:04:45] markdown files skills are just basically markdown files but we can teach the agent to do a lot of things
[00:04:50] with skills and it can it can get the right skill if it gets loaded up and then good things
[00:04:54] happen but sometimes we don't get the right skill loaded up so our our poor boy crabd here is not
[00:05:03] going to get that clam he just doesn't have the open clamshell skill lots of shrimp no clams maybe you
[00:05:11] picked the wrong skill for the job and suddenly you're you're jet skiing on the on the beach right this
[00:05:16] this is not this is not going to get him very far and sometimes you you might get that clam
[00:05:25] open but then you don't have the skill to eat them so skills you need to have the right skills
[00:05:32] the right chain of skills um actually we have an awesome project by one of the neo forj folks which
[00:05:38] is just bananas as an arvix paper which is a graph for skills so that's an exciting way of like
[00:05:45] like figuring out what the right skills are but maybe we can do better so um goose is a project
[00:05:52] that's part of the um agentic AI foundation is a new foundation which MCP is part of um anthropic is
[00:06:00] backing this we're we're also a member of this so it's a it's a great automation tool for a lot
[00:06:06] of enterprise workflows you can also use it kind of like a personal assistant it relies heavily on MCP as
[00:06:12] the layer over 70 MCP extensions and what it does is it treats memory just like another MCP server so
[00:06:23] this is great right it's it's pluggable you can call different commands on it to retrieve memories remember memories um
[00:06:30] forget memories memories are just plain files on disks so now you can manipulate them so same great idea same
[00:06:39] fundamental problem we're storing the memory we're storing the memory of agents as markdown files on disks and again you
[00:06:48] end up with what if what if you pick the wrong tool for the job the wrong paddle now in
[00:06:55] this case if you pick the wrong paddle you're a genius because you've invented the most the fastest rising sport
[00:07:01] in the US which is pickle ball um actually the origin of pickle ball was was um a family wanted
[00:07:09] to create a new game and they just took what they had around the house a bad men court and
[00:07:14] um made up the rules along the way so creation can be good when you have the wrong tools maybe
[00:07:20] you remember everything but it's too much is too much weight because you can't actually solve the problem so our
[00:07:26] poor friend Goose here is encumbered by too many notes too many memories or most dangerously now you have MCP
[00:07:37] tools you're one step away from calling the forget command and just wiping out your own memory okay so we
[00:07:45] want to be able to do better than this so vector databases right so we can store everything we can
[00:07:53] create embeddings for it now we actually have a d a database we can store it in a vector database
[00:07:59] so this is great i mean you have to pick the right vector database um and then now you can
[00:08:05] do similarity searches so you can pull back information which is which is relevant so we're doing much better we
[00:08:11] have a larger repository of knowledge we can pull back related information um open claw comes with pg vector out
[00:08:18] of the box given embedding you can just start using this um lance DB is a great option i'm going
[00:08:23] to use both of those in my demo but the challenge here is similar what what vectors give you which
[00:08:31] is similarity in vector space is not the same as actual relationships and so you get hallucinations you get a
[00:08:39] lot of problems when you're relying solely on vector lookup as the answer and it compounds with more complex scenarios
[00:08:46] when you're doing things like like I'm going to show you an example of a digital twin when you're doing
[00:08:51] things which are very complex they they just don't scale and you make silly mistakes like this obviously is not
[00:08:59] what poor Crab D wanted to munch into and it's a very expensive lunch for him
[00:09:06] also it's sometimes impossible to get to the answer even though you have all the facts because those large multihop
[00:09:14] reasoning chains don't work on similarity searches they're also very expensive on traditional relational databases
[00:09:25] and often things look similar but they're not exactly the same and this is one of the problems with the
[00:09:33] responses you get from a vector database is you suffer from getting facts which are related in some way and
[00:09:41] they're not your shell and you don't you don't want to take the wrong shell out of the locker room
[00:09:45] that's that's very unfortunate so enter graphs graphs are a great way of finding the relationships finding those identities bu
[00:09:52] mapping out the paths getting that full chain and they're built for this sort of connected data so now that
[00:10:01] you have first class nodes which are the the circles edges those are the relationships between different objects and then
[00:10:08] you can put properties on top of graphs to store information you can also store embeddings in your graph and
[00:10:14] that gives you a way to both use vectors and graphs together um architecturally the demo I'm going to show
[00:10:21] you is um both a vector search and a graph search so it uses the vector search to get the
[00:10:28] seed nodes where it starts the traversal and then it uses a graph search pulling the the nearest neighbors and
[00:10:35] then ranking those by how related they are and this gives you this complex multihop queries to solve more difficult
[00:10:43] more domain specific problems and to figure out where that where that reef is that we want to get to
[00:10:49] with all the the tasty um the tasty junk food across the ocean
[00:10:56] and graphs are they're accurate so they give you very precise information explainable because you can look at the graph
[00:11:04] which got returned and auditable because now you can actually say these are the this is the context this is
[00:11:11] the part of the graph which resulted in that answer so it's very powerful and it gives you more tools
[00:11:18] as a developer where if you're not getting the right answer you know where it's coming from you can actually
[00:11:24] see and introspect the graph and you can change how you're doing extraction you can reduce duplicate nodes in the
[00:11:31] graph and then you can get to and converge very quickly on a great answer if you're not a graph
[00:11:36] expert guess what Claude is claude can write cipher better than I can claude can extract build entity extractors and
[00:11:44] it can do pretty much everything you need to do to get started with graphs today as long as you
[00:11:49] know the the basic kind of model for what you want to accomplish that's what I'm going to cover in
[00:11:53] the demo so we're going to do have Claud action into the graph as he works we're going to follow
[00:11:59] up by traversing not rereading it and then in a fresh session we will get the results we want to
[00:12:05] get out now what I did for this um high stakes demo is I over the past week or two
[00:12:12] I took my home lab as the demo environment did a full digital twin as a graph and I have
[00:12:18] two separate environments built off the same original markdown files one is a vector database store that's our our A
[00:12:26] test and the second is a graph store that's our B test and the graph store is built on top
[00:12:33] of um Cognite so I'm using Cogni which is a startup um they do amazing stuff in the memory space
[00:12:41] they have a Neo Forj backend this is my the structure so we have a bunch of Proxmox servers in
[00:12:48] my my home lab it's really a couple computers around my desk and I built a separate VLAN for the
[00:12:56] demo so it's segmented off my real network so it was trained on real network for my network but now
[00:13:02] it's it's cut off it can only answer from memory it can't actually look up the hosts and get dynamic
[00:13:08] information so let's see how it does
[00:13:15] in a live demo okay so
[00:13:23] all right here we have our our crab rag cockpit um and I have five different questions queued up with
[00:13:32] schematics you can see this is the same home lab schematic that you saw earlier in the slides and um
[00:13:39] let's let's start with this one so WR exposed end of life soft WAN exposed end of life software so
[00:13:45] we're going to basically we're going to try to find out if there's anything on my network which is exposed
[00:13:50] to the network the the internet the WAN that's running out ofdate software which put my home lab at risk
[00:13:56] right so if if somebody can attack the home lab and um you can see here that there there is
[00:14:03] some servers um Tsterland which is my daughter's Minecraft server it's running oh my god dbna Jesse and let's see
[00:14:12] how the the two agents did in looking this up Okay so we got the vector response back couldn't find
[00:14:18] specific details excluded by policy for more precise information yada yada yada source it separately okay that's that's not very
[00:14:26] helpful now on the graph side it's done a bunch of cipher queries here are the cipher queries it's fired
[00:14:32] off um this is the graph traversal and the the color coding on the graph traversal is these blue guys
[00:14:41] these are the seed nodes so this came from a a vector lookup and a ranking but it didn't stop
[00:14:46] there it does the one hop traversals those are all the gray nodes some of the nodes get highlighted in
[00:14:53] green and those are the ones which which won and got into context and you can see the answer here
[00:15:00] so guest name tinsterland exactly as expected um OS version out of date and it's flagging so so it gives
[00:15:08] us very precise actionable information and so that's the difference between same same exact data one is a vector store
[00:15:17] one is a graph store and you can see the difference where the the vector store is having a lot
[00:15:22] of trouble pulling the information out the relevant information out okay let's try another one just for fun um let's
[00:15:30] see expose 0.0.0.0 management ports that's that's bad so um basically you don't want your management ports on the network
[00:15:41] exposed to the you know the world and there's a bunch of these so I have a new matrix server
[00:15:47] I set up and also hroxy which are exposed to the internet that's bad the rest of these like my
[00:15:53] Cognney demo my openclaw instance those are inside the LAN you need to get into the LAN to access them
[00:15:58] that's that's what you want okay and let's see how the two agents did in identifying this so the memory
[00:16:07] search returns some information and it's telling me check services configuration expect PFSense rule so it told me to go
[00:16:15] do the job for it um okay and then the graph memory side found an open port exposed to WAN
[00:16:23] haroxy and openVPN which are the are the two we expected now this you can see the shape of this
[00:16:28] graph is entirely different from the previous one and what it did is it it actually found the node for
[00:16:34] for my router the PFSense router and it was able to follow that directly to all of the results which
[00:16:40] related to it and then give us like a very precise answer
[00:16:49] all right so um
[00:17:00] so now so now we've seen our little boy Crab D with his certified Neo Forj developer t-shirt is able
[00:17:08] to do a lot more right now he's able to follow that full chain crack eat do the next thing
[00:17:14] so he's getting his he's getting his clams he's helping me fix all the security holes in my network um
[00:17:20] oh by the way I I patched all those security holes after the demo um so this was good for
[00:17:25] me too it found a bunch of security holes in my home lab and then I I went and patched
[00:17:29] them later and um now we have an agent which actually can do interesting things now if you can imagine
[00:17:35] like I have a three or four node home lab at home if if you have a big enterprise which
[00:17:41] has a huge data center if you're doing things in financial services where you have like a huge set of
[00:17:47] companies and customer records you're trying to do if you're doing anything at at large scale where it doesn't fit
[00:17:53] into the 1 million context window of the modern models you really need a better memory system than just throwing
[00:18:00] things in markdown files our little boy Krabby knows his whole crew all the Crustaceian friends
[00:18:10] and he's read the book um so we just finished my my co-authors and I Michael Hunger and Osus Barasa
[00:18:18] finished Graph Ragg the definitive guide the full book is out on on early release it'll be published um in
[00:18:24] a couple months once they finish the editorial process but super excited about this it's got information not only on
[00:18:31] graph rag but also on building memory on on different industry vertical use cases on agents so it's kind of
[00:18:38] the the whole umbrella if you're building on top of graph solutions how you need to build applications the technologies
[00:18:45] you need end to end
[00:18:49] and then finally a great free resource which everybody in this room can take advantage of is Neo Forj um's
[00:18:59] graph academy so it's free online training um dev.ne.com-rag
[00:19:05] or the QR code below there and um we have courses on doing agent memory doing context graphs and everything
[00:19:14] you need to get know to get started and to do some of the amazing stuff which I showed you
[00:19:19] on stage today so thank you so much for coming to the the kickoff talk for the graph track
[00:19:30] you're in the right place for all of the content from graph experts andreas Colliger my colleague and I crafted
[00:19:38] a great set of speakers from industry experts people who really know about graph technology so hang out here find
[00:19:44] out more and then you can see me in the Neo Forj booth thank you
```
