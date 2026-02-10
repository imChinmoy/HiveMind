import { createChannel, findAllChannels } from "./channel.repository.js";

export const getAllChannelsService = async ({
  serverId,
  serverName,
}: {
  serverId: string;
  serverName: string;
}) => {
  const channels = await findAllChannels({ serverId, serverName });
  return channels;
};

export const createChannelService = async ({
  name,
  serverId,
  description,
}: {
  name: string;
  serverId: string;
  description?: string;
}) => {
  const channel = await createChannel({ name, serverId, description });
  return channel;
};
