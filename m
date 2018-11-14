Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 14 Nov 2018 10:30:07 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: is pwm_put supposed to stop a PWM?
Message-ID: <20181114093007.bsatgncq5uqzdjve@pengutronix.de>
References: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
 <20181029114835.GB9500@ulmo>
 <20181103144920.aa5u6rwtggariwvn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181103144920.aa5u6rwtggariwvn@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, kernel@pengutronix.de, Boris Brezillon <boris.brezillon@bootlin.com>
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Sat, Nov 03, 2018 at 03:49:20PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Oct 29, 2018 at 12:48:35PM +0100, Thierry Reding wrote:
> > On Thu, Oct 25, 2018 at 09:45:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > > while digging around in the pwm drivers I found
> > > drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
> > > pwm_disable() and pwm_set_duty_cycle(pwm, 0).
> > >=20
> > > I think calling pwm_disable is wrong for two reasons:
> > >=20
> > >  a) pwm_disable is for PWM users, not for drivers
> >=20
> > PWM controller drivers can still call pwm_disable(), though they should
> > do so very carefully and not behind consumers' backs.
>=20
> I'd say this is a bad idea because the driver knows in which callback
> this results and so there is complexity for no real benefit. When the
> core implemented some locking this could easily deadlock.

I think it would be beneficial to get rid of these calls. Would you
agree to document calling pwm-API calls as forbidden as a first step and
then work on fixing these?

> > >  b) .free isn't supposed to stop the pwm.
> >=20
> > That's a bit of a gray area. I still think we need a way of stopping the
> > PWM at some point. Some drivers do this on ->remove() and it was in fact
> > discussed at one point that this should be moved to the core, so that
> > all channels would be automatically disabled when the PWM chip is
> > removed.
> >=20
> > Disabling in ->free() should not have any effect, because users should
> > already have disabled it before they even call pwm_put() on it.
>=20
> Then I recommend to remove this from the driver. There is no benefit and
> so it's code that is "dead", a bad example to copy from and keeping the
> code more complex than needed.
>
> > So perhaps a good compromise would be to document that users are
> > supposed to disable the PWM before they release it and then drivers (or
> > the core) could go and check that they're really disabled when the chip
> > is being removed and WARN() if not. That way we can flag all consumers
> > that don't behave and fix them.
>=20
> Yeah, I'd say documenting is a good idea, too. And then check in the
> core (and WARN there) and remove the code from hardware drivers.

Thinking about this, I'd not require that a consumer disables a pwm
before calling pwm_put. Eventually it might have good reasons to keep
the PWM running (e.g. to keep a led in its state). So I'd restrict the
documentation to the undisputed part that the hw driver should only
touch the configuration in .apply (respectively .config, .set_polarity,
.enable, .disable for legacy drivers).
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
