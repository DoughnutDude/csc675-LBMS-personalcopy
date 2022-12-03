# imports
import os
import discord
import database as db
import cmdparser as bot

# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']
#server_id = os.environ['SERVER_ID']  # optional
channel_id = os.environ['CHANNEL_ID']  # optional

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
db_conn = db.connect()
# bot events
intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)  # added intents=discord.Intents.all()


@client.event
async def on_ready():
  """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
  print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
  """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
  response = None  # will save the response from the bot
  if message.author == client.user:
    return  # the message was sent by the bot
  if message.type is discord.MessageType.new_member:
    response = "Welcome {}".format(
      message.author)  # a new member joined the server. Welcome him.
  else:
    # A message was send by the user.
    msg = message.content.lower()
    print(msg)
    #print(msg[0])
    if (msg[0] == '!'):
      response = bot.response(msg)

  if response:
    # bot sends response to the Discord API and the response is show
    # on the channel from your Discord server that triggered this method.
    embed = discord.Embed(description=response)
    await message.channel.send(embed=embed)


try:
  # start the bot and keep the above methods listening for new events
  client.run(token)
except:
  print(
    "Bot is offline because your secret environment variables are not set. Head to the left panel, "
    +
    "find the lock icon, and set your environment variables. For more details, read the README file in your "
    + "milestone 3 repository")
