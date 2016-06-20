From: Brian Norris <briannorris@chromium.org>
Subject: Re: [v3,1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Mon, 20 Jun 2016 11:10:22 -0700
Message-ID: <20160620181020.GA46079@google.com>
References: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
 <20160617214151.GA1400@roeck-us.net>
 <20160618010855.GA67034@google.com>
 <5765805A.5070407@roeck-us.net>
 <3eac0aed-58ed-8376-dc29-ab374c67ebc0@osg.samsung.com>
 <20160620174455.GB40678@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35595 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcFTSPe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jun 2016 14:15:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id c2so56493537pfa.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jun 2016 11:15:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160620174455.GB40678@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hi,

On Mon, Jun 20, 2016 at 10:44:55AM -0700, Brian Norris wrote:
> On Mon, Jun 20, 2016 at 09:46:57AM -0400, Javier Martinez Canillas wrote:
> > On 06/18/2016 01:09 PM, Guenter Roeck wrote:
> > > On 06/17/2016 06:08 PM, Brian Norris wrote:
> > >> How do you propose we do that? Do all of the following become EINVAL?
> > >>
> > 
> > Yes, I would just do that.
> > 
> > The idea of this helper is to remove duplicated code and AFAICT what most EC
> > drivers do is something similar to the following:
> > 
> >         ret = cros_ec_cmd_xfer(ec, msg);
> >         if (ret < 0)
> > 	   	return ret;
> > 
> >         if (msg->result != EC_RES_SUCCESS) {
> >                 dev_dbg(ec->dev, "EC result %d\n", msg->result);
> >                 return -EINVAL;
> >         }
> > 
> > So in practice what most drivers really care is if the result was successful
> > or not, I don't see specific EC error handling in the EC drivers.  The real
> > EC error code is still in the message anyways so drivers that do cares about
> > the real EC error can look at msg->result instead.
[...]
> > >>          EC_RES_INVALID_COMMAND
> > > 
> > >     -EOPNOTSUPP
> > > 
> > >>          EC_RES_INVALID_PARAM
> > > 
> > >     -EINVAL or -EBADMSG
> > > 
> > >>          EC_RES_INVALID_VERSION
> > > 
> > >     -EPROTO or -EBADR or -EBADE or -EBADRQC or -EPROTOOPT
> > > 
> > >>          EC_RES_INVALID_HEADER
> > > 
> > >     -EPROTO or -EBADR or -EBADE
> > > 
> > > Doesn't look that bad to me. Also, the raw error could still be logged,
> > > for example with dev_dbg().
> > >
> > 
> > Yes, I think that adding a dev_dbg() with the real EC error code should
> > be enough, that's basically what drivers do since they can't propagate
> > the EC error to higher layers anyways.
> 
> I'll take a look at adding an error code translation table when I get a
> chance. Hopefully that doesn't delay the others who are planning to use
> this API shortly...

Actually, I had some second thoughts, and others brought similar
concerns up to me:

What do we really win by doing the translation? It'll be difficult to do
a 1:1 translation, and any time the EC adds additional error types,
we'll have to update the translation. What's more, AFAICT, no one will
really be looking at the translated error codes now, and will just be
blindly passing them on. So maybe it makes more sense to just pick a
single error code and pass that on instead. Possibly just -EPROTO (or
nominate your favorite) for all EC error results, and if someone cares,
they decode msg->result in their driver, or check the dev_dbg() log?

Brian
