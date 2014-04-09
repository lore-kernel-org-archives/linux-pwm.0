From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 12:03:13 +0200
Message-ID: <20140409100313.GA20704@piout.net>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408175904.GT29751@pengutronix.de>
 <20140408234243.GB13898@piout.net>
 <20140409082341.GV29751@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59676 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932694AbaDIKDP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 06:03:15 -0400
Content-Disposition: inline
In-Reply-To: <20140409082341.GV29751@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org

On 09/04/2014 at 10:23:41 +0200, Uwe Kleine-K=F6nig wrote :
> > While I had exactly the same issue back in september and wrote the =
exact
> > same patch that got rejected. I would agree with Thierry here taht =
we
> > need to keep the pwm_disable() there as it potentially allows to sa=
ve
> > power.
> >
> > However, it seems to not work quite well with PWMs from Freescale (=
see
> > the thread from Russell). Or I would say with PWM with an undefined
> > state when disabled and I believe we are soon to find more.
> >=20
> > We could either:
> >  - add a flag like can_sleep that would allow driver to know that t=
he
> >    pwm always has to be enable to get sane results.
> >
> >  - or introduce functions like prepare/unprepare to be called from =
probe
> >    and remove in the leds-pwm driver and that will enable/disable t=
he
> > channel in pwm-mxs. pwm_enable/pwm_disable not doing anything.
> There are a few more options. I repeat your's to get a single list:
>=20
>  a) Somehow tell the API users that pwm_disable might not result in a
>     flat zero after set_duty(0).
>  a') Anchor in the API that users must not expect anything from the p=
wm
>     pin after pwm_disable.
>  b) Make pwm_enable/pwm_disable noops on i.MX28
>  c) Make set_duty only return when the new value reached the pin.
>  d) Make pwm_disable wait to yield the expected result
>  d') Make pwm_disable wait if the last programmed duty cycle is 0 or
>     full period.
>  e) Introduce a new callback that does the waiting, e.g. a .commit
>     callback
>  e') Introduce a new callback pwm_config_sync that does wait
>     appropriatly, keep pwm_config as is.
>  f) Make the i.MX28 driver switch the pin the gpio mode with the
>     expected output level in pwm_disable.
>=20
> a') is a special case of a); d') is a special case of d), ditto for e=
')
> and e).
>=20
> a) and e) would result in changes in the pwm API. For c) I'd like to
> make the API docs more explicit, too. (i.e. demand that the new
> configuration is already active after pwm_config returns)
>=20
> Both e) and a) have the drawback that the API becomes more complicate=
d
> and users will get it wrong. a) and b) are bad from a power managemen=
t
> POV. Maybe c) is what most users expect, but d) and d') are more
> effective as they result in less waiting and still are good enough. f=
)
> is more complicated to implement, also it depends on a gpio being
> available in hardware. So if we choose f) we still might need a fallb=
ack
> implementation from the other options.
>=20
> My series implemented a'), but Thierry didn't like it. I think my
> favorite is e').
>=20

I think I would actually prefer d'. Doing the synchronisation in d' is
abstracting it for the user.
But e' is also fine as long as we manage to educate users of when to us=
e
pwm_config() or pwm_config_sync(). I believe your idea for leds-pwm
would be to call pwm_config_sync() instead of pwm_config() before
pwm_disable().

I actually had to implement d' for pwm-atmel, to wait that the last
update got through before disabling the pwm, see
http://thread.gmane.org/gmane.linux.pwm/451 but doing that in
pwm_config_sync() would probably also work.


=46or a and a' I think that Thierry intended that a user could expect
pwm_disable() to not change the output of the PWM when the duty cycle i=
s
0.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
