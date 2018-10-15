Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 15 Oct 2018 11:22:13 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181015092213.GB12357@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
 <20181012101143.GC9162@ulmo>
 <20181014113400.nm6ajbjnju2h6dz3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20181014113400.nm6ajbjnju2h6dz3@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
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
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 01:34:00PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Oct 12, 2018 at 12:11:43PM +0200, Thierry Reding wrote:
> > On Fri, Oct 12, 2018 at 11:45:57AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> > [...]
> > > > >> Sidenote: With the current capabilities of the pwm framework the=
re is no
> > > > >> technical reason to expose to the hardware drivers that the pwm =
user uses
> > > > >> inverted logic. The framework could just apply
> > > > >>
> > > > >> 	duty =3D period - duty;
> > > > >>
> > > >=20
> > > > I prefer to utilize as much HW capabilities as possible. And it see=
ms
> > > > like most PWM chips support HW output inversion (to some extent) so=
 to
> > > > me it seems perfectly OK that that information can be propagated fr=
om
> > > > the upper SW levels to the lowest one.
> > >=20
> > > If the hardware capability is useful I fully agree. But if inversion =
can
> > > be accomplished by a chip that doesn't support inversion in hardware =
by
> > > just using duty =3D period - duty (and so can be accomplished by a ch=
ip
> > > that has inversion support without making use of it) then the drivers
> > > shouldn't be confronted with it.
> >=20
> > These two are orthogonal problems. If all you care about is the power
> > output of the PWM (as is the case for backlights, LEDs or fans, for
> > example), then inverted polarity has the same effect as duty =3D period=
 -
> > duty.
> >=20
> > However, the two don't result in identical waveforms.
>=20
> OK, let's find the difference then. Consider a pwm that is off at start,
> then it's configured to run at 66% duty cycle at time A and then it's
> disabled again at time B.
>=20
> The resulting wave form is:
>=20
> ______________       __       __       __       _____________________
>               \_____/  \_____/  \_____/  \_____/
>             A                                B
>               ^        ^        ^        ^
>=20
> With the ^ markers pointing out where the periods started.
>=20
> Correct?
>=20
> Now with the duty =3D period - duty trick the wave would look as follows:
>=20
>=20
> _________________       __       __       __       __________________
>                  \_____/  \_____/  \_____/  \_____/
>             A                                B
>               ^        ^        ^        ^
>=20
> Apart from a shift I cannot see any difference. I confirm that this
> might be bad if there are two (or more) PWMs that are expected to run in
> sync, but given that the current API doesn't provide the possibility to
> map such a use case this is irrelevant.
>=20
> Another difference I confirm there might be is that this might result in
> one more (or less) periods depending on timing and the capabilities of
> the hardware. Is this bad? I'd say it isn't.
>=20
> What am I missing?

I don't think that's entirely correct. For normal PWM with 66% duty
cycle you'd get something like this:

     ____    ____    ____
    /    \__/    \__/    \__   (1)
    ^       ^       ^

For "emulated" inversion (duty cycle =3D period - duty cycle, i.e. 33%
duty cycle) you'd get this:

     __      __      __
    /  \____/  \____/  \____   (2)
    ^       ^       ^

For a truly inversed PWM (duty cycle =3D 33%), it would look like this:

          __      __      __
    \____/  \____/  \____/     (3)
    ^       ^       ^

If you emulate inversion of the truly inversed PWM, you'd get this:

        ____    ____    ____
    \__/    \__/    \__/       (4)
    ^       ^       ^

As you can see, all of the above are slightly different. As you can see,
and you already noted that, the emulated inversion (2) and the true
inversion (3) are almost identical, except that they have a phase shift
that is equivalent to the duty cycle. The same is true of (1) and (4).
The phase shift doesn't affect the power output of the signal, so (1)
and (4) as well as (2) and (3) have the same power output. This is the
reason why the difference doesn't matter for backlight or LEDs, because
brightness is proportional to the power output.

However, you can also see that (2) and (3) are different in how the
period starts. (2) starts with a rising edge while (3) starts with a
falling edge.

Now, for any use-cases where the only thing we care about is the power
output, my opinion is that consumers should implement the inversion. If
the hardware is capable of inversion, then by all means they should use
that in the implementation. But, a lot of hardware is not capable of
doing the inversion, so they can still fall back to emulating the
inversion. Either way, the important point here is that the consumer
driver (pwm-backlight, leds-pwm, ...) knows that only power output is
relevant, so it is the consumer drivers that should make the decision.

On the other hand, other use-cases may rely on the exact shape of the
PWM signal, so if the edges are important, then they need to rely on the
hardware inversion for proper functionality. My understanding is that we
don't have any of those users in the kernel, but my recollection is that
people use the sysfs interfaces to make use of this. Like I said
elsewhere, if I remember correctly, people use this as a way of
synchronizing motors using PWM pulses. My knowledge of those use-cases
stops there because I've never used PWMs like that.

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvEXEMACgkQ3SOs138+
s6HkYxAAi1VrCsqnQ3xzD6+43ECS/BLaumOMrIZETe7/Wxi863qYNjGkSp+Uq8nE
zXL8GqPtNrkprSTfXLynlPU2kUefM3oFXzhNgHzaggRpLNefJLrRX9pQcF/rncph
fC9aXJTVqyYAFMZZn5EtJ1NZs05fnrpTwn5vqLSAgltRLSeNoclp0rPinXWmkBxc
bBFkDlgyuPFwdnwmqU0YScSHHTuKX1dC4JpC8v8pO7IlTXSvcmD5TnS0JhTZmhNg
Os1L2O3tuzfnMldbSuBNueQjWqN+X2/rEscPZpn3U2abmq37rXHkHrKE3pD6mfyg
rxbxDj1ZZ7Pw3+LBZNkfNuT5KBw/98d/RHBNP30VH0k8MIdE/XWPStQZoaCRPhXK
/iniu0CsYcsdE+b4BwazeB9D5kCyffyOu1t96GHUewHK8FEVTeN3IUulKnukGseQ
uQ5ga9OZlwU9sb/84FvvQMlhw5GAv8N5DDuPzFJnIlIbGX17FagcKGv7o3e1bN7t
nc5CDTOub/2H+e6xubYgDc/MznHj3yvijhg/t9/Zh0XQRE9qgvOCIcJcCPcOic8w
w2F5P2XDvVz2OtQ/HGfy36X/Xt69fDhnuxHojj2t4vx/yekBFAdelHxxgSu512n5
lCubZ3fyqzR7sXl+C1XP+ZWfuUCW03kxmLpQLAB504XdBJnuMw0=
=mWse
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
