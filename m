Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 29 Oct 2018 12:48:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181029114835.GB9500@ulmo>
References: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20181025194524.2xdhqni666zfgfzp@pengutronix.de>
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


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 09:45:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> while digging around in the pwm drivers I found
> drivers/pwm/pwm-lpc18xx-sct.c which in its .free callback calls
> pwm_disable() and pwm_set_duty_cycle(pwm, 0).
>=20
> I think calling pwm_disable is wrong for two reasons:
>=20
>  a) pwm_disable is for PWM users, not for drivers

PWM controller drivers can still call pwm_disable(), though they should
do so very carefully and not behind consumers' backs.

>  b) .free isn't supposed to stop the pwm.

That's a bit of a gray area. I still think we need a way of stopping the
PWM at some point. Some drivers do this on ->remove() and it was in fact
discussed at one point that this should be moved to the core, so that
all channels would be automatically disabled when the PWM chip is
removed.

Disabling in ->free() should not have any effect, because users should
already have disabled it before they even call pwm_put() on it.

So perhaps a good compromise would be to document that users are
supposed to disable the PWM before they release it and then drivers (or
the core) could go and check that they're really disabled when the chip
is being removed and WARN() if not. That way we can flag all consumers
that don't behave and fix them.

> Also I'm surprised that .request calls pwm_get_duty_cycle() and writes
> the result into hardware. Still more as I think pwm_get_duty_cycle()
> always returns 0 in .request.
>=20
> BTW, this is the only caller of pwm_set_duty_cycle(), so if the driver
> is simplified/fixed to not care about the duty cycle in .free and
> .request, this function can go away.
>=20
> What do you think?

Yeah, it looks as if pwm_get_duty_cycle() would always return 0 because
the driver doesn't implement hardware readout. pwm_set_duty_cycle() was
introduced back at the time when sysfs support was added, but it seems
to have otherwise been unused ever since. I think it no longer makes
sense to keep it around once all consumers have adopted the atomic API.

Thierry

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW85AACgkQ3SOs138+
s6HkUxAAwRLXBwPP1+9zxQ71dEZX2J1ii1dt9ePewRtD0pGio3+yGM15arOa3MOl
6s+l8nauCA+GULX/yZRUBvkkNUSRqcTtw8u/vpErKoXfc4IUfP/9n9OOK3jpnsSy
+4rcz9VDfLIeR1hhvZXqIkuMUqopkZdljsTlz+/xQI0MfMJYYBuupzJLsyPCqnpZ
QrOZ/8LPLnZL/Y9EW6h8417BxWZ4o3wuwfRhjrgB3xQgoyi4fTM8y665EHOjBKUh
Ae6/5wJLBEzAbQeXZorsOBVa2TyB/R6TRJ+JvRHRS+zgOSmtaAgBjRQFWpBu3wSX
N2JAHdqpSNmt3yQMV+ML83PrllPP2LhjdI6ZVrIF3FYSIACowHYPH36p4cf7tAtz
QerxgbjEp5kKFnmI5wCbpMNR7PbWaomEk4GGy3vluslbJh1vng8E28+N3w2cpHnA
kCWyHeMO2DFffrVlWoC1BYIPRH+CwTribNXQP25c0OKpipotwjRTII9RCkWxcXPp
JyaxVoavRI15WE/15W0wv82zYGTYnucxOtXdEIU1g7nyHBIEqv8qIft3Y4M1SJZ9
i+yh1wXjnRWI91d4yRWUA220wu2UY4dCB9eqh7tNok25sLJtPxzCmDkcs4gL3Dyc
A89bZccXkH6WiocS5Jrga/j13rY5Dq7QIWx1/8s+E/6ab06SIwM=
=KqPM
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
