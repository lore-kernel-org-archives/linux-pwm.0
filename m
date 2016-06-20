From: Brian Norris <briannorris@chromium.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Mon, 20 Jun 2016 10:44:55 -0700
Message-ID: <20160620174455.GB40678@google.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net>
 <20160618010855.GA67034@google.com>
 <5765805A.5070407@roeck-us.net>
 <3eac0aed-58ed-8376-dc29-ab374c67ebc0@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3eac0aed-58ed-8376-dc29-ab374c67ebc0@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, Jun 20, 2016 at 09:46:57AM -0400, Javier Martinez Canillas wrote:
> On 06/18/2016 01:09 PM, Guenter Roeck wrote:
> > On 06/17/2016 06:08 PM, Brian Norris wrote:
> >> On Fri, Jun 17, 2016 at 02:41:51PM -0700, Guenter Roeck wrote:
> >>> On Fri, Jun 17, 2016 at 12:58:12PM -0700, Brian Norris wrote:
> >>>> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >>>> +                struct cros_ec_command *msg)
> >>>> +{
> >>>> +    int ret;
> >>>> +
> >>>> +    ret = cros_ec_cmd_xfer(ec_dev, msg);
> >>>> +    if (ret < 0)
> >>>> +        dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> >>>> +    else if (msg->result != EC_RES_SUCCESS)
> >>>> +        return -EECRESULT - msg->result;
> >>>
> >>> I have been wondering about the error return codes here, and if they should be
> >>> converted to standard Linux error codes. For example, I just hit error -1003
> >>> with a driver I am working on. This translates to EC_RES_INVALID_PARAM, or,
> >>> in Linux terms, -EINVAL. I think it would be better to use standard error
> >>> codes, especially since some of the errors are logged.
> >>
> 
> Agreed, specially since drivers may (wrongly) propagate whatever is returned
> by this function to higher layers where the ChromeOS EC firmware error codes
> makes no sense. So that will be a bug and can increase the cognitive load of
> getting some weird error codes in core kernel code and developers may wonder
> from where those came from until finally find that a EC driver returned that.

Agreed, I suppose. It's probably best to make it unlikely other that
"client" drivers of cros-ec will blindly propagate nonstandard error
codes.

> >> How do you propose we do that? Do all of the following become EINVAL?
> >>
> 
> Yes, I would just do that.
> 
> The idea of this helper is to remove duplicated code and AFAICT what most EC
> drivers do is something similar to the following:
> 
>         ret = cros_ec_cmd_xfer(ec, msg);
>         if (ret < 0)
> 	   	return ret;
> 
>         if (msg->result != EC_RES_SUCCESS) {
>                 dev_dbg(ec->dev, "EC result %d\n", msg->result);
>                 return -EINVAL;
>         }
> 
> So in practice what most drivers really care is if the result was successful
> or not, I don't see specific EC error handling in the EC drivers.  The real
> EC error code is still in the message anyways so drivers that do cares about
> the real EC error can look at msg->result instead.

Ah, well that last point is a nice reminder I guess, although that still
doesn't fit the way cros_ec_num_pwms() uses this API. But I can try to
refactor it to fit; cros_ec_num_pwms() will need to get two return
codes from cros_ec_pwm_get_duty() -- uglier, IMO, but doable.

> >>          EC_RES_INVALID_COMMAND
> > 
> >     -EOPNOTSUPP
> > 
> >>          EC_RES_INVALID_PARAM
> > 
> >     -EINVAL or -EBADMSG
> > 
> >>          EC_RES_INVALID_VERSION
> > 
> >     -EPROTO or -EBADR or -EBADE or -EBADRQC or -EPROTOOPT
> > 
> >>          EC_RES_INVALID_HEADER
> > 
> >     -EPROTO or -EBADR or -EBADE
> > 
> > Doesn't look that bad to me. Also, the raw error could still be logged,
> > for example with dev_dbg().
> >
> 
> Yes, I think that adding a dev_dbg() with the real EC error code should
> be enough, that's basically what drivers do since they can't propagate
> the EC error to higher layers anyways.

I'll take a look at adding an error code translation table when I get a
chance. Hopefully that doesn't delay the others who are planning to use
this API shortly...

Brian
