Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 15 Nov 2018 16:43:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181115154345.GB8611@ulmo>
References: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
 <20181029114835.GB9500@ulmo>
 <20181103144920.aa5u6rwtggariwvn@pengutronix.de>
 <20181114093007.bsatgncq5uqzdjve@pengutronix.de>
 <20181114115025.GC2620@ulmo>
 <20181115084231.4ydw3kn5anzpsawl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20181115084231.4ydw3kn5anzpsawl@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>, kernel@pengutronix.de, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
List-ID: <linux-pwm.vger.kernel.org>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 09:42:31AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Nov 14, 2018 at 12:50:25PM +0100, Thierry Reding wrote:
> > On Wed, Nov 14, 2018 at 10:30:07AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Sat, Nov 03, 2018 at 03:49:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Mon, Oct 29, 2018 at 12:48:35PM +0100, Thierry Reding wrote:
> > > > > On Thu, Oct 25, 2018 at 09:45:24PM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > while digging around in the pwm drivers I found
> > > > > > drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
> > > > > > pwm_disable() and pwm_set_duty_cycle(pwm, 0).
> > > > > >=20
> > > > > > I think calling pwm_disable is wrong for two reasons:
> > > > > >=20
> > > > > >  a) pwm_disable is for PWM users, not for drivers
> > > > >=20
> > > > > PWM controller drivers can still call pwm_disable(), though they =
should
> > > > > do so very carefully and not behind consumers' backs.
> > > >=20
> > > > I'd say this is a bad idea because the driver knows in which callba=
ck
> > > > this results and so there is complexity for no real benefit. When t=
he
> > > > core implemented some locking this could easily deadlock.
> > >=20
> > > I think it would be beneficial to get rid of these calls. Would you
> > > agree to document calling pwm-API calls as forbidden as a first step =
and
> > > then work on fixing these?
> >=20
> > I'm not a big fan of documenting anything as being forbidden. People can
> > do whatever they want when nobody's checking and we don't have a way of
> > enforcing anything either because they could just as well remove those
> > enforcement measures. Remember, they have access to all the code, so the
> > best we can do is discourage people from doing potentially stupid things
> > by documenting expectations, requirements and limitations.
>=20
> In my eyes the purpose of the PWM framework (and similar all other
> frameworks, too) is to abstract a common set of functions for a certain
> type of hardware. As such it is beneficial to all affected parties if
> the hardware drivers have a tight policy what is expected. This makes
> implementing stuff in the hardware driver easier, because people know
> what should be done and what not in a given callback. It makes pwm
> consumers' work easier, because they know what to expect from calling a
> certain API function and so increases the chances that a backlight
> driver that was only tested with say a rockchip PWM also works the same
> way when another machine makes use of the same backlight driver with an
> imx PWM.
> This increases overall code quality.
>=20
> Sure we cannot protect people from doing stupid things by patching
> stuff. But we can improve the situation for people who have to patch to
> actually fix broken stuff by documenting for them in the above scenario
> where the backlight driver doesn't work with the imx pwm if it's the
> backlight driver or the pwm driver that needs adaption to converge to a
> state where all pwm consumers work with all pwm backends.

I agree with the above. But I don't see how it is relevant to this
particular discussion. I'm merely pointing out that we can't prevent
people from using pwm_disable() in drivers if they choose to do so.
Yes, we should avoid doing that in the upstream kernel if we consider
it to be bad practice, and we can enforce it during review or reject
patches that do so. If this is currently not clear, then by all means
let's document it.

However, we have no means of controlling what people do when they work
outside of upstream and we also have no way of prosecuting people, so
"forbidding" something is pointless.

> > > > > So perhaps a good compromise would be to document that users are
> > > > > supposed to disable the PWM before they release it and then drive=
rs (or
> > > > > the core) could go and check that they're really disabled when th=
e chip
> > > > > is being removed and WARN() if not. That way we can flag all cons=
umers
> > > > > that don't behave and fix them.
> > > >=20
> > > > Yeah, I'd say documenting is a good idea, too. And then check in the
> > > > core (and WARN there) and remove the code from hardware drivers.
> > >=20
> > > Thinking about this, I'd not require that a consumer disables a pwm
> > > before calling pwm_put. Eventually it might have good reasons to keep
> > > the PWM running (e.g. to keep a led in its state). So I'd restrict the
> > > documentation to the undisputed part that the hw driver should only
> > > touch the configuration in .apply (respectively .config, .set_polarit=
y,
> > > .enable, .disable for legacy drivers).
> >=20
> > What would you consider good reasons for keeping a PWM running when the
> > consumer no longer needs it? I can't come up with any sane reason why we
> > would want to allow that. It's normal to turn things off when you no
> > longer need them. I do that with a computer, an oven and a shower, too.
> > Why would a PWM be different?
>=20
> I'm not sure I have a good use case. But I'm not certain enough that
> there is none and so I'd just say---keeping legacy drivers out of the
> discussion for simplicity:
>=20
> 	A hardware driver should only modify the behaviour of the output
> 	pin in the .apply callback.
>=20
> instead of:
>=20
> 	The PWM consumer must disable the PWM before calling pwm_put.
> 	The backend driver can assume the PWM to be off when its .free
> 	callback is entered.

I don't get it. On one hand you're arguing that we should put stricter
rules into place so that consumers know what to expect and then you walk
that back and say we shouldn't have stricter rules.

To reiterate my point: there's no reason to keep anything enabled after
you're done using it. If you need to keep it enabled it means that you
still use it. In terms of drivers this means that as long as a device is
actively being used (backlight, fan, motor, ...), the consumer of the
PWM should stay around. You don't unload a backlight driver if you want
to keep using the backlight, right? The same is true for fans and any
number of things. Once you no longer use the device the natural action
is to turn it off. Consequently when you unload the PWM consumer driver
the PWM should be disabled.

So I do think we should require consumers to disable a PWM before they
release the PWM using pwm_put() and warn about it on pwmchip_remove().

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvtlCwACgkQ3SOs138+
s6FVpxAAm/7bfYPj8bQJmZcnPKyloI6g2rzrA5ScFIlYSaep8JlvsDxBXVryb8gs
o4JOD6pB4DDR3SJ2gPWbmMmznnYa11gqlb9Qi678LHftFlj8y1O8YPcLr/lxA9V5
JgLzyh6e2oNsIXlOGcQBYgb8um9VRICuDhPVy5fw6ZXKveoJZ2+feky7dJrWbGso
duXYdjJa3UP3Ch+nkFrxc8UaXVoDnHfgGFs3IQRGwJ9YaSCM/eURL0ewIl9376UD
/Ihb12M8G3ardFH9HG0ZFFQezFkcJzN3B23xFqdEurgGoafU7EfpWvFuv+gl93ao
SnHshi5DZaF68uxMNWARhhUt+e6+0gB6kyGU6kSvuR0QA7zC3Y2XbdWEgduH3A9B
qwT1FHIT2GXEkXKT2km0nwJNAUiLD4ZP8AhcJ3/HG2ZhOsV9XNAoc1IG3hKCNqw1
o+S+L+qekwKen7Kc1dxI00dXloTF2y57nG0Ipf8wbr3JniFjix/gJ+ovDCGuVDHG
4EdPpzItoWWSoZ+w9lU7CAK73qt3LFJ3p0dk/m4GOuiwypqkSqRUAcFcPYhuEKA+
imMwx+0Ee4TlxnheHozvxtzGXpap/H/YjVDH1ESp2BU1Cs4vsHCRMJNsm7LxPpBk
MtzuEiiIslYVPZ8QE1jElhjEknhdKqOvwyNxZ+8KYPlxblwOMc4=
=8s+X
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
