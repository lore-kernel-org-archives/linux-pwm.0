From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 16:35:16 +0200
Message-ID: <20140409143516.GW29751@pengutronix.de>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408175904.GT29751@pengutronix.de>
 <20140408234243.GB13898@piout.net>
 <20140409082341.GV29751@pengutronix.de>
 <20140409100313.GA20704@piout.net>
 <20140409104652.GC9527@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44031 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbaDIOfU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 10:35:20 -0400
Content-Disposition: inline
In-Reply-To: <20140409104652.GC9527@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Wed, Apr 09, 2014 at 12:46:53PM +0200, Thierry Reding wrote:
> On Wed, Apr 09, 2014 at 12:03:13PM +0200, Alexandre Belloni wrote:
> > On 09/04/2014 at 10:23:41 +0200, Uwe Kleine-K=F6nig wrote :
> > > > While I had exactly the same issue back in september and wrote =
the exact
> > > > same patch that got rejected. I would agree with Thierry here t=
aht we
> > > > need to keep the pwm_disable() there as it potentially allows t=
o save
> > > > power.
> > > >
> > > > However, it seems to not work quite well with PWMs from Freesca=
le (see
> > > > the thread from Russell). Or I would say with PWM with an undef=
ined
> > > > state when disabled and I believe we are soon to find more.
> > > >=20
> > > > We could either:
> > > >  - add a flag like can_sleep that would allow driver to know th=
at the
> > > >    pwm always has to be enable to get sane results.
> > > >
> > > >  - or introduce functions like prepare/unprepare to be called f=
rom probe
> > > >    and remove in the leds-pwm driver and that will enable/disab=
le the
> > > > channel in pwm-mxs. pwm_enable/pwm_disable not doing anything.
> > > There are a few more options. I repeat your's to get a single lis=
t:
> > >=20
> > >  a) Somehow tell the API users that pwm_disable might not result =
in a
> > >     flat zero after set_duty(0).
> > >  a') Anchor in the API that users must not expect anything from t=
he pwm
> > >     pin after pwm_disable.
> > >  b) Make pwm_enable/pwm_disable noops on i.MX28
> > >  c) Make set_duty only return when the new value reached the pin.
> > >  d) Make pwm_disable wait to yield the expected result
> > >  d') Make pwm_disable wait if the last programmed duty cycle is 0=
 or
> > >     full period.
> > >  e) Introduce a new callback that does the waiting, e.g. a .commi=
t
> > >     callback
> > >  e') Introduce a new callback pwm_config_sync that does wait
> > >     appropriatly, keep pwm_config as is.
> > >  f) Make the i.MX28 driver switch the pin the gpio mode with the
> > >     expected output level in pwm_disable.
> > > [...]
> > > My series implemented a'), but Thierry didn't like it. I think my
> > > favorite is e').
> > >=20
> >=20
> > I think I would actually prefer d'. Doing the synchronisation in d'=
 is
> > abstracting it for the user.
>=20
> My preference would be simply d). Mostly because I don't like special
> cases and especially because I don't see an advantage in special casi=
ng
> 0 and full period duty cycles. That doesn't mean of course that drive=
rs
> can't special case if they really want or have to.
Well d' is just an optimisation, because if you have a duty cycle
between 0 and full (exclusive) and no other means of syncronisation
you cannot influence where pwm_disable stops the output, at low or high=
=2E

Do we have cases where pwm_disable makes the pin high-z? Or something
else which violates the assumption "pwm_config(pwm, 0, period);
pwm_disable(pwm); makes the pin 0"?
=20
> That said I've also been thinking about adding support for e), which
> would allow atomically changing the duty cycle, period and polarity o=
f a
> channel. This might become necessary at some point.
On i.MX28 you cannot change atomically, only program atomically. The
current period will end regularily anyhow as programmed before. But
maybe that's what you mean?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
