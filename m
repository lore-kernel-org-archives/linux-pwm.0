From: Brian Norris <briannorris@chromium.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Fri, 17 Jun 2016 18:08:55 -0700
Message-ID: <20160618010855.GA67034@google.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160617214151.GA1400@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 17, 2016 at 02:41:51PM -0700, Guenter Roeck wrote:
> On Fri, Jun 17, 2016 at 12:58:12PM -0700, Brian Norris wrote:
> > +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > +			    struct cros_ec_command *msg)
> > +{
> > +	int ret;
> > +
> > +	ret = cros_ec_cmd_xfer(ec_dev, msg);
> > +	if (ret < 0)
> > +		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> > +	else if (msg->result != EC_RES_SUCCESS)
> > +		return -EECRESULT - msg->result;
> 
> I have been wondering about the error return codes here, and if they should be
> converted to standard Linux error codes. For example, I just hit error -1003
> with a driver I am working on. This translates to EC_RES_INVALID_PARAM, or,
> in Linux terms, -EINVAL. I think it would be better to use standard error
> codes, especially since some of the errors are logged.

How do you propose we do that? Do all of the following become EINVAL?

        EC_RES_INVALID_COMMAND
        EC_RES_INVALID_PARAM
        EC_RES_INVALID_VERSION
        EC_RES_INVALID_HEADER

We lose a lot of information that way. And particularly, cros_ec_num_pwms()
won't be able to count as accurately. But I can just go back to not using this
API if that's what you'd like...

Brian
