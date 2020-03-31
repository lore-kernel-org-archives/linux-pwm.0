From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Tue, 31 Mar 2020 14:09:37 +0200
Message-ID: <452f4e03cc2a998c7a903251f99931935b1f872f.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
         <20200330130757.GC2431644@ulmo> <20200330133450.GA1530@workstation.tuxnet>
         <20200330154036.GB2817345@ulmo> <20200330160744.GA777@workstation.tuxnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.tq-group.com ([62.157.118.193]:25824 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbgCaMJr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:47 -0400
In-Reply-To: <20200330160744.GA777@workstation.tuxnet>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com

On Mon, 2020-03-30 at 18:07 +0200, Clemens Gruber wrote:
> On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> > On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > > Hi,
> > > 
> > > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer
> > > > wrote:
> > > > > The interaction of the ALL_LED PWM channel with the other
> > > > > channels was
> > > > > not well-defined. As the ALL_LED feature does not seem very
> > > > > useful and
> > > > > it was making the code significantly more complex, simply
> > > > > remove it.
> > > > > 
> > > > > Signed-off-by: Matthias Schiffer <
> > > > > matthias.schiffer@ew.tq-group.com>
> > > > > ---
> > > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------
> > > > > ------------
> > > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > > > 
> > > > Applied, thanks.
> > > > 
> > > > Thierry
> > > 
> > > I was not reading the mailing list in the last weeks, so I only
> > > saw the
> > > patch today.
> > > 
> > > We are using the ALL_LED channel in production to reduce the
> > > delay when
> > > all 16 PWM outputs need to be set to the same duty cycle.
> > > 
> > > I am not sure it is a good idea to remove this feature.
> > 
> > Can you specify what platform this is and where the code is that
> > does
> > this. I can't really find any device tree users of this and I don't
> > know
> > if there's a good way to find out what other users there are, but
> > this
> > isn't the first time this driver has created confusion, so please
> > help
> > collect some more information about it's use so we can avoid this
> > in the
> > future.
> 
> The platform is ARM, it's a custom board with an NXP i.MX6. The
> device
> tree is not upstreamed. As there are multiple companies involved
> in changes to this driver, I assume that it is in use, even though
> there
> are no in-tree users.
> Also: As you can set the ALL channel from userspace, it will be very
> difficult to find out how often the ALL feature is being used
> somewhere.
> 
> > 
> > I'll back out this particular patch since you're using it. Can you
> > give
> > the other three patches a try to see if they work for you?
> 
> Thanks! I saw your other mail. Patch 1 looks good to me. I will look
> at
> the new version of patches 3 and 4 and test them when they appear on
> the
> list.
> 
> Clemens

Thanks for the feedback, I'll have to respin my cleanup patches without
removing this feature.

I wonder if we can come up with a sane semantics of how ALL_LED is
supposed to interact with the individual channels? Optimally, changes
made via ALL_LED should be reflected in the state of the other channels
including their sysfs files, but I'm not sure if current APIs can
support this cleanly. It might make sense to make requesting/exporting
individual channels and ALL_LED mutually exclusive, so the state of a
requested PWM can't change when it's supposed to be under exclusive
control of one user. Of course, such a change can break existing users
as well...

And what about state propagation in the other direction - how should
the ALL_LED state reflect changes made to the other channels' settings?
On the hardware side, the ALL_LED registers are write-only, as there
aren't any sane values that could be returned.

Matthias
