Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 14 Nov 2018 12:50:25 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181114115025.GC2620@ulmo>
References: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
 <20181029114835.GB9500@ulmo>
 <20181103144920.aa5u6rwtggariwvn@pengutronix.de>
 <20181114093007.bsatgncq5uqzdjve@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20181114093007.bsatgncq5uqzdjve@pengutronix.de>
Subject: Re: is pwm_put supposed to stop a PWM?
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, kernel@pengutronix.de, Boris Brezillon <boris.brezillon@bootlin.com>
List-ID: <linux-pwm.vger.kernel.org>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 10:30:07AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Sat, Nov 03, 2018 at 03:49:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Oct 29, 2018 at 12:48:35PM +0100, Thierry Reding wrote:
> > > On Thu, Oct 25, 2018 at 09:45:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > while digging around in the pwm drivers I found
> > > > drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
> > > > pwm_disable() and pwm_set_duty_cycle(pwm, 0).
> > > >=20
> > > > I think calling pwm_disable is wrong for two reasons:
> > > >=20
> > > >  a) pwm_disable is for PWM users, not for drivers
> > >=20
> > > PWM controller drivers can still call pwm_disable(), though they shou=
ld
> > > do so very carefully and not behind consumers' backs.
> >=20
> > I'd say this is a bad idea because the driver knows in which callback
> > this results and so there is complexity for no real benefit. When the
> > core implemented some locking this could easily deadlock.
>=20
> I think it would be beneficial to get rid of these calls. Would you
> agree to document calling pwm-API calls as forbidden as a first step and
> then work on fixing these?

I'm not a big fan of documenting anything as being forbidden. People can
do whatever they want when nobody's checking and we don't have a way of
enforcing anything either because they could just as well remove those
enforcement measures. Remember, they have access to all the code, so the
best we can do is discourage people from doing potentially stupid things
by documenting expectations, requirements and limitations.

> > > >  b) .free isn't supposed to stop the pwm.
> > >=20
> > > That's a bit of a gray area. I still think we need a way of stopping =
the
> > > PWM at some point. Some drivers do this on ->remove() and it was in f=
act
> > > discussed at one point that this should be moved to the core, so that
> > > all channels would be automatically disabled when the PWM chip is
> > > removed.
> > >=20
> > > Disabling in ->free() should not have any effect, because users should
> > > already have disabled it before they even call pwm_put() on it.
> >=20
> > Then I recommend to remove this from the driver. There is no benefit and
> > so it's code that is "dead", a bad example to copy from and keeping the
> > code more complex than needed.

Yeah, that's fair.

> > > So perhaps a good compromise would be to document that users are
> > > supposed to disable the PWM before they release it and then drivers (=
or
> > > the core) could go and check that they're really disabled when the ch=
ip
> > > is being removed and WARN() if not. That way we can flag all consumers
> > > that don't behave and fix them.
> >=20
> > Yeah, I'd say documenting is a good idea, too. And then check in the
> > core (and WARN there) and remove the code from hardware drivers.
>=20
> Thinking about this, I'd not require that a consumer disables a pwm
> before calling pwm_put. Eventually it might have good reasons to keep
> the PWM running (e.g. to keep a led in its state). So I'd restrict the
> documentation to the undisputed part that the hw driver should only
> touch the configuration in .apply (respectively .config, .set_polarity,
> .enable, .disable for legacy drivers).

What would you consider good reasons for keeping a PWM running when the
consumer no longer needs it? I can't come up with any sane reason why we
would want to allow that. It's normal to turn things off when you no
longer need them. I do that with a computer, an oven and a shower, too.
Why would a PWM be different?

Your example of keeping an LED in the current state is actually an
example of where the consumer still needs it. As long as you want to use
the LED you need to keep the LED driver around, and as long as the LED
driver is around you have a consumer for the PWM. When the LED driver is
unloaded, it better turn off that LED. Of course if the LED is supposed
to be on by default, then most likely it will not be driven by a PWM in
the first place, or it would be an inversed polarity PWM (driven by a
pin that has a pull-up by default), in which case the right thing to do
in the LED driver's ->remove() implementation is to disable the PWM and
restore the pull-up on the pin to pull it high while it is not actively
driven.

Thierry

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsC/4ACgkQ3SOs138+
s6HK7A//dO094dKcTM0jsh6ni7jp8nWS19+5HAGLKG6F53RLErYRi1ELvUUWK4wb
KJupoDkurGqiYBEsEuryFMTTKCeFqMxzqMReB5mwnjz6DOnNIYsianUo9FfJYeU7
Jg/qR44B7gy6GiJtaZqqg/mR8ueicToApkpxQQj40kMyXlkGU54/N5FkWIyRzUqZ
hLZd59hBVSePfZGbBSwSTFJHdcY36MG8MWa85DvRHL/R8MAQQ6WBII1/7vn4UlW8
3360HanmYJ4kdNODnkuVBkiBGrZAMY4WDdkYx16ub3+0Onp3Lap0B+9p8zIPhxpq
TnoeAxXDQgBiaTgJjmJv2lXrwgJEuNLZZaXAQB6sLOf1c26Ofbec9siIXqmaGQWz
/QdsL6aVPhWa/FxwrHZK3aL8vHpK+1b+6beGWTIrn8FtHxlphCgUGuXF7Vfe94rv
mk/sDKxWsfhPzwRqPSj70wtjlqYVQwQuiiaKmIp2vye1vya+CPRdDYTPahdVscxY
NE5o3W7lznGoibMN5HE28iAyKIot00MKoe1TolljmnBdoK+6rxu5/RDIboA/48fH
362cv1j0Sz0S5AJJUf0lW7tw4Dl0bXNGbBcT3QIzhRcSlZDz1OwpVVHg005ZLUmN
MfcmjS+bJaVYkWnc32pItYRmVxjz923mq5QxoRowUTTGra9JYFU=
=7ZaL
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
