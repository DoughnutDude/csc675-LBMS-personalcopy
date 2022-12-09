# imports
import os
import discord
import database as db
import cmdparser as bot

# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']
#server_id = os.environ['SERVER_ID']  # optional
channel_id = os.environ['CHANNEL_ID']  # general text chat

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
db_conn = db.connect()
# bot events
intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)


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
      message.author)  # a new member joined the server. Welcome them.
  elif (str(message.channel.id) == channel_id):
    # A message was send by the user in the general channel.
    msg = message.content.lower()
    print(msg)
    #print(msg[0])
    if (msg[0] == '!'):
      response = bot.response(msg)

  if response:
    # bot sends response to the Discord API and the response is show
    # on the channel from your Discord server that triggered this method.
    embed = discord.Embed(title=f"**{message.content[1:]}**")

    if isinstance(response, str):
      print(response)
      embed.description = f"{response}"
    else:
      values = ""
      for index, row in enumerate(response):
        #print(row.items())
        values = ""
        for key, value in row.items():
          #print(key, value)
          values = f"{values}> {key}: {value}\n"
        embed.add_field(name=f"result {index+1}:", value=f"{values}", inline=False)


    await message.reply(embed=embed, mention_author=False)


try:
  # start the bot and keep the above methods listening for new events
  client.run(token)
except:
  print(
    "Bot is offline because your secret environment variables are not set. Head to the left panel, "
    +
    "find the lock icon, and set your environment variables. For more details, read the README file in your "
    + "milestone 3 repository")
