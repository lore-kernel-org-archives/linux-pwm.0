Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 15 Nov 2018 09:42:31 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: is pwm_put supposed to stop a PWM?
Message-ID: <20181115084231.4ydw3kn5anzpsawl@pengutronix.de>
References: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
 <20181029114835.GB9500@ulmo>
 <20181103144920.aa5u6rwtggariwvn@pengutronix.de>
 <20181114093007.bsatgncq5uqzdjve@pengutronix.de>
 <20181114115025.GC2620@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181114115025.GC2620@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>, kernel@pengutronix.de, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Wed, Nov 14, 2018 at 12:50:25PM +0100, Thierry Reding wrote:
> On Wed, Nov 14, 2018 at 10:30:07AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sat, Nov 03, 2018 at 03:49:20PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Oct 29, 2018 at 12:48:35PM +0100, Thierry Reding wrote:
> > > > On Thu, Oct 25, 2018 at 09:45:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > while digging around in the pwm drivers I found
> > > > > drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
> > > > > pwm_disable() and pwm_set_duty_cycle(pwm, 0).
> > > > >=20
> > > > > I think calling pwm_disable is wrong for two reasons:
> > > > >=20
> > > > >  a) pwm_disable is for PWM users, not for drivers
> > > >=20
> > > > PWM controller drivers can still call pwm_disable(), though they sh=
ould
> > > > do so very carefully and not behind consumers' backs.
> > >=20
> > > I'd say this is a bad idea because the driver knows in which callback
> > > this results and so there is complexity for no real benefit. When the
> > > core implemented some locking this could easily deadlock.
> >=20
> > I think it would be beneficial to get rid of these calls. Would you
> > agree to document calling pwm-API calls as forbidden as a first step and
> > then work on fixing these?
>=20
> I'm not a big fan of documenting anything as being forbidden. People can
> do whatever they want when nobody's checking and we don't have a way of
> enforcing anything either because they could just as well remove those
> enforcement measures. Remember, they have access to all the code, so the
> best we can do is discourage people from doing potentially stupid things
> by documenting expectations, requirements and limitations.

In my eyes the purpose of the PWM framework (and similar all other
frameworks, too) is to abstract a common set of functions for a certain
type of hardware. As such it is beneficial to all affected parties if
the hardware drivers have a tight policy what is expected. This makes
implementing stuff in the hardware driver easier, because people know
what should be done and what not in a given callback. It makes pwm
consumers' work easier, because they know what to expect from calling a
certain API function and so increases the chances that a backlight
driver that was only tested with say a rockchip PWM also works the same
way when another machine makes use of the same backlight driver with an
imx PWM.
This increases overall code quality.

Sure we cannot protect people from doing stupid things by patching
stuff. But we can improve the situation for people who have to patch to
actually fix broken stuff by documenting for them in the above scenario
where the backlight driver doesn't work with the imx pwm if it's the
backlight driver or the pwm driver that needs adaption to converge to a
state where all pwm consumers work with all pwm backends.

> > > > So perhaps a good compromise would be to document that users are
> > > > supposed to disable the PWM before they release it and then drivers=
 (or
> > > > the core) could go and check that they're really disabled when the =
chip
> > > > is being removed and WARN() if not. That way we can flag all consum=
ers
> > > > that don't behave and fix them.
> > >=20
> > > Yeah, I'd say documenting is a good idea, too. And then check in the
> > > core (and WARN there) and remove the code from hardware drivers.
> >=20
> > Thinking about this, I'd not require that a consumer disables a pwm
> > before calling pwm_put. Eventually it might have good reasons to keep
> > the PWM running (e.g. to keep a led in its state). So I'd restrict the
> > documentation to the undisputed part that the hw driver should only
> > touch the configuration in .apply (respectively .config, .set_polarity,
> > .enable, .disable for legacy drivers).
>=20
> What would you consider good reasons for keeping a PWM running when the
> consumer no longer needs it? I can't come up with any sane reason why we
> would want to allow that. It's normal to turn things off when you no
> longer need them. I do that with a computer, an oven and a shower, too.
> Why would a PWM be different?

I'm not sure I have a good use case. But I'm not certain enough that
there is none and so I'd just say---keeping legacy drivers out of the
discussion for simplicity:

	A hardware driver should only modify the behaviour of the output
	pin in the .apply callback.

instead of:

	The PWM consumer must disable the PWM before calling pwm_put.
	The backend driver can assume the PWM to be off when its .free
	callback is entered.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
