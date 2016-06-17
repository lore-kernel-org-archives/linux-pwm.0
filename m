From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Fri, 17 Jun 2016 12:13:30 -0700
Message-ID: <20160617191329.GA5679@google.com>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell>
 <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
 <20160617080635.GG21702@dell>
 <20160617155552.GB27475@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32950 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcFQTNf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2016 15:13:35 -0400
Received: by mail-pf0-f182.google.com with SMTP id i123so29623052pfg.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jun 2016 12:13:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160617155552.GB27475@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Fri, Jun 17, 2016 at 05:55:52PM +0200, Thierry Reding wrote:
> On Fri, Jun 17, 2016 at 09:06:35AM +0100, Lee Jones wrote:
> > On Thu, 16 Jun 2016, Doug Anderson wrote:
> > > On Thu, Jun 16, 2016 at 8:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
[...]

> > > > Please use kerneldoc format.

[...]

> > > Probably the reason for all of these non-kernel-isms is that this
> > > isn't a kernel file.  From the top of the file:
> > > 
> > >  * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
> > >  * project in an attempt to make future updates easy to make.
> > > 
> > > So the source of truth for this file is
> > > <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h>.
> > > 
> > > Someone could probably submit a CL to that project to make it a little
> > > more kernel-ish and then we'd have to see if the EC team would accept
> > > such changes...
> > 
> > Hmmm... that kinda puts me in a difficult position.  Do I except
> > non-kernel code, which does not conform to our stands?

I could have sworn that there was an exception for existing code;
changing styles just for the sake of changing styles can hurt more than
help (e.g., in this instance, in comparing this file with the source of
truth -- the Chrome OS EC firmware sources). But I can't find an
explicit reference to this right now...

> I think usually code that doesn't adhere to kernel coding style ends up
> in the staging tree until it's been cleaned up enough.
> 
> The rule doesn't quite apply here because cleaning up isn't the issue.
> But I don't know if we have any best practices for this kind of thing.
> 
> One thing that I've seen done in the past is to have this kind of
> cross-OS header generated from some sort of definition file (XML, ...)
> with an output filter for all supported OSes. Is that something that
> could perhaps be done here?

I think I can safely say that rewriting this in XML is out of the
question for us.

> That said, this might not even be worth it in this case. While I see how
> it makes sense to avoid work updating this file for various coding
> styles, the content in this file defines an ABI, so really the only
> changes will be additions, and once they're merged they become set in
> stone anyway. The amount of work updating the header, even taking into
> account different coding styles should be very low.

IMO, there is value in being able to compare the two sources, and there
is little (but non-zero) value in making these rather minor suggested
changes. Additionally, reformatting this particular change to use
kerneldoc, when the rest of the file doesn't, seems inconsistent. How
does the following sound instead?

(1) Keep the existing patch as-is (perhaps modulo one or two of Lee's
    non-kerneldoc-related comments)
(2) I send a follow-up patch, to help synchronize the out-of-tree EC
    header with the kernel header, after we've considered converting it
    to better match kernel styles. BTW, we've filed a bug for this
    discussion [1], to ensure it doesn't get dropped on the floor.

Brian

[1] https://bugs.chromium.org/p/chromium/issues/detail?id=621123
