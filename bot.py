import discord

client = discord.Client()

@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))

@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.content.startswith('$hello'):
        await message.channel.send('Hello!')

client.run('ODI0NDMxMTQzODE3NTc2NTU5.YFvRVQ.5X0yfYCPuCZ6SsefUf-LN6tNs8A')