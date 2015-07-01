From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 01/12] device: property: delay device-driver matches
Date: Thu, 02 Jul 2015 01:29:59 +0200
Message-ID: <17310138.6IxCgARibq@vostro.rjw.lan>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com> <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59183 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752625AbbGAXDk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 19:03:40 -0400
In-Reply-To: <1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wednesday, July 01, 2015 11:40:56 AM Tomeu Vizoso wrote:
> Delay matches of platform devices until late_initcall, when we are sure
> that all built-in drivers have been registered already. This is needed
> to prevent deferred probes because of some dependencies' drivers not
> having registered yet.
> 
> This reduces the total amount of work that the kernel does during boot
> because it won't try to match devices to drivers when built-in drivers
> are still registering but also reduces some parallelism, so total boot
> time might slightly increase or decrease depending on the platform and
> kernel configuration.
> 
> This change will make make possible to prevent any deferred probes once
> devices are probed in dependency order.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
> Changes in v2:
> - Instead of delaying all probes until late_initcall, only delay matches
>   of platform devices that have a firmware node attached.
> 
>  drivers/base/property.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8528eb9..8ead1ba 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -16,8 +16,11 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> +static bool fwnode_match_enable = false;
> +
>  /**
>   * device_add_property_set - Add a collection of properties to a device object.
>   * @dev: Device to add properties to.
> @@ -604,6 +607,15 @@ EXPORT_SYMBOL_GPL(fwnode_is_compatible);
>  bool fwnode_driver_match_device(struct device *dev,
>  				const struct device_driver *drv)
>  {
> +	/*
> +	 * Delay matches of platform devices until late_initcall, when we are
> +	 * sure that all built-in drivers have been registered already. This
> +	 * is needed to prevent deferred probes because of some drivers
> +	 * not having registered yet.
> +	 */
> +	if(dev->bus == &platform_bus_type && !fwnode_match_enable)
> +		return false;

I'm not particularly enthusiastic about referring to specific bus types in
generic code like that.

What about having a special version of fwnode_driver_match_device() specifically
for the platform bus type that will do the check?

> +
>  	if (is_of_node(dev->fwnode))
>  		return of_driver_match_device(dev, drv);
>  	else if (is_acpi_node(dev->fwnode))
> @@ -612,3 +624,20 @@ bool fwnode_driver_match_device(struct device *dev,
>  	return false;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_driver_match_device);
> +
> +static int __device_attach(struct device *dev, void *data)
> +{
> +	device_initial_probe(dev);
> +
> +	return 0;
> +}
> +
> +static int fwnode_match_initcall(void)
> +{
> +	fwnode_match_enable = true;
> +
> +	bus_for_each_dev(&platform_bus_type, NULL, NULL, __device_attach);
> +
> +	return 0;
> +}
> +late_initcall(fwnode_match_initcall);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
