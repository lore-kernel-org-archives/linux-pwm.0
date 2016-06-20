From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Mon, 20 Jun 2016 10:32:53 -0700
Message-ID: <20160620173253.GA40678@google.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net>
 <20160618010855.GA67034@google.com>
 <5764CA24.1080803@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5764CA24.1080803-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 17, 2016 at 09:12:20PM -0700, Guenter Roeck wrote:
> On 06/17/2016 06:08 PM, Brian Norris wrote:
> >On Fri, Jun 17, 2016 at 02:41:51PM -0700, Guenter Roeck wrote:
> >>On Fri, Jun 17, 2016 at 12:58:12PM -0700, Brian Norris wrote:
> >>>+int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >>>+			    struct cros_ec_command *msg)
> >>>+{
> >>>+	int ret;
> >>>+
> >>>+	ret = cros_ec_cmd_xfer(ec_dev, msg);
> >>>+	if (ret < 0)
> >>>+		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> >>>+	else if (msg->result != EC_RES_SUCCESS)
> >>>+		return -EECRESULT - msg->result;
> >>
> >>I have been wondering about the error return codes here, and if they should be
> >>converted to standard Linux error codes. For example, I just hit error -1003
> >>with a driver I am working on. This translates to EC_RES_INVALID_PARAM, or,
> >>in Linux terms, -EINVAL. I think it would be better to use standard error
> >>codes, especially since some of the errors are logged.
> >
> >How do you propose we do that? Do all of the following become EINVAL?
> >
> >         EC_RES_INVALID_COMMAND
> >         EC_RES_INVALID_PARAM
> >         EC_RES_INVALID_VERSION
> >         EC_RES_INVALID_HEADER
> >
> 
> Personal preference, but yes.
> 
> >We lose a lot of information that way. And particularly, cros_ec_num_pwms()
> >won't be able to count as accurately. But I can just go back to not using this
> 
> You lost me there, sorry.

If you look at the currently-proposed user of this API (patch 4), some
of the code in cros_ec_num_pwms() looks like this:

               /*
                * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM responses;
                * everything else is treated as an error
                */
               if (ret == -EECRESULT - EC_RES_INVALID_COMMAND)
                       return -ENODEV;
               else if (ret == -EECRESULT - EC_RES_INVALID_PARAM)
                       return i;
               else if (ret < 0)
                       return ret;

I'd really like to know the difference between EC_RES_INVALID_COMMAND,
EC_RES_INVALID_PARAM, and all other error codes. You're suggesting
aliasing those with generic Linux error codes which could easily be used
for other things (e.g., reporting errors from the I2C or SPI layers,
which I'd want to treat differently). So either I decrease the
preciseness of the above code, or I just use cros_ec_cmd_xfer() instead
of cros_ec_cmd_xfer_status(), and then have to reimplement the error
handling that cros_ec_cmd_xfer_status() was going to (sort of) abstract
away.

But maybe that just means that pwm-cros-ec.c is really the odd-man-out
use case compared to the other users of cros_ec_cmd_xfer_status() in the
Chrome OS kernel tree, and so I should be using cros_ec_cmd_xfer().

> >API if that's what you'd like...
> >
> 
> That isn't what I suggested.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
