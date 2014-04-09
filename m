From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 10:23:41 +0200
Message-ID: <20140409082341.GV29751@pengutronix.de>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408175904.GT29751@pengutronix.de>
 <20140408234243.GB13898@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557AbaDIIXo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 04:23:44 -0400
Content-Disposition: inline
In-Reply-To: <20140408234243.GB13898@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Wed, Apr 09, 2014 at 01:42:43AM +0200, Alexandre Belloni wrote:
> On 08/04/2014 at 19:59:04 +0200, Uwe Kleine-K=F6nig wrote :
> > On Tue, Apr 08, 2014 at 03:46:59PM +0200, Stefan Wahren wrote:
> > > Am 08.04.2014 13:29, schrieb Shawn Guo:
> > > Unfortunately the led still don't behave as expected. If i set th=
e led
> > > trigger to heartbeat the led goes on and stays in this state.
> > >=20
> > > May be this has something to do with the following discussion
> > >=20
> > > http://comments.gmane.org/gmane.linux.leds/208
> > I guess that's your problem, yes. Does patch 2 of my series (i.e.
> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D=
282596)
> > help you?
> >=20
>=20
> While I had exactly the same issue back in september and wrote the ex=
act
> same patch that got rejected. I would agree with Thierry here taht we
> need to keep the pwm_disable() there as it potentially allows to save
> power.
>
> However, it seems to not work quite well with PWMs from Freescale (se=
e
> the thread from Russell). Or I would say with PWM with an undefined
> state when disabled and I believe we are soon to find more.
>=20
> We could either:
>  - add a flag like can_sleep that would allow driver to know that the
>    pwm always has to be enable to get sane results.
>
>  - or introduce functions like prepare/unprepare to be called from pr=
obe
>    and remove in the leds-pwm driver and that will enable/disable the
> channel in pwm-mxs. pwm_enable/pwm_disable not doing anything.
There are a few more options. I repeat your's to get a single list:

 a) Somehow tell the API users that pwm_disable might not result in a
    flat zero after set_duty(0).
 a') Anchor in the API that users must not expect anything from the pwm
    pin after pwm_disable.
 b) Make pwm_enable/pwm_disable noops on i.MX28
 c) Make set_duty only return when the new value reached the pin.
 d) Make pwm_disable wait to yield the expected result
 d') Make pwm_disable wait if the last programmed duty cycle is 0 or
    full period.
 e) Introduce a new callback that does the waiting, e.g. a .commit
    callback
 e') Introduce a new callback pwm_config_sync that does wait
    appropriatly, keep pwm_config as is.
 f) Make the i.MX28 driver switch the pin the gpio mode with the
    expected output level in pwm_disable.

a') is a special case of a); d') is a special case of d), ditto for e')
and e).

a) and e) would result in changes in the pwm API. For c) I'd like to
make the API docs more explicit, too. (i.e. demand that the new
configuration is already active after pwm_config returns)

Both e) and a) have the drawback that the API becomes more complicated
and users will get it wrong. a) and b) are bad from a power management
POV. Maybe c) is what most users expect, but d) and d') are more
effective as they result in less waiting and still are good enough. f)
is more complicated to implement, also it depends on a gpio being
available in hardware. So if we choose f) we still might need a fallbac=
k
implementation from the other options.

My series implemented a'), but Thierry didn't like it. I think my
favorite is e').

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
