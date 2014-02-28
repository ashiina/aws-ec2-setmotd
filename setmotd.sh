instance_id=`ec2-metadata | sed -n 's/^instance-id: //p'`
tag_name=`ec2-describe-instances --region $region $instance_id | sed -n '/^TAG/{s/.*\tName\t\([^\t]*\).*/\1/p}'`

echo "set hostname: $tag_name ($instance_id)"
if [ -z $tag_name ]; then
	echo "Could not get ec2 Name-tag."
	exit 1;
fi

hostname $tag_name
sed -i 's/^HOSTNAME=.*/HOSTNAME='$tag_name'/' /etc/sysconfig/network
figlet $tag_name > /etc/motd


