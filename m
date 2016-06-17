From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Fri, 17 Jun 2016 14:41:51 -0700
Message-ID: <20160617214151.GA1400@roeck-us.net>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 17, 2016 at 12:58:12PM -0700, Brian Norris wrote:
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> So that callers of cros_ec_cmd_xfer don't have to repeat boilerplate
> code when checking for errors from the EC side.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> v3:
>  * successfully spell success
> 
> v2:
>  * no change
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 15 +++++++++++++++
>  include/linux/mfd/cros_ec.h             | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b6e161f71b26..ecc544c728f0 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -380,3 +380,18 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> +
> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> +			    struct cros_ec_command *msg)
> +{
> +	int ret;
> +
> +	ret = cros_ec_cmd_xfer(ec_dev, msg);
> +	if (ret < 0)
> +		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> +	else if (msg->result != EC_RES_SUCCESS)
> +		return -EECRESULT - msg->result;

I have been wondering about the error return codes here, and if they should be
converted to standard Linux error codes. For example, I just hit error -1003
with a driver I am working on. This translates to EC_RES_INVALID_PARAM, or,
in Linux terms, -EINVAL. I think it would be better to use standard error
codes, especially since some of the errors are logged.

Guenter
