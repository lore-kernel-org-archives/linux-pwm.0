From: Alban Bedel <alban.bedel-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH V3] pwm: lpc32xx - Add a driver for the motor PWM
Date: Tue, 9 Sep 2014 18:05:30 +0200
Message-ID: <20140909180530.635ce6f7@avionic-0020>
References: <1410277361-26848-1-git-send-email-alban.bedel@avionic-design.de>
	<2942175.JkZcLDKfiR@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/qnSqLzvmEtFs1iliWt5Amnf"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2942175.JkZcLDKfiR@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

--Sig_/qnSqLzvmEtFs1iliWt5Amnf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Sep 2014 17:47:53 +0200
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> On Tuesday 09 September 2014 17:42:41 Alban Bedel wrote:
> > +config PWM_LPC32XX_MOTOR
> > +	tristate "LPC32xx Motor PWM support"
> > +	depends on ARCH_LPC32XX
> > +	help
> > +	  Generic PWM framework driver for LPC32xx motor PWM. The LPC32xx SOC
> > +	  has one motor PWM controllers.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-lpc32xx-motor.
> > +
>=20
> Can you change the dependency to ARCH_LPC32XX || COMPILE_TEST and
> add explicit dependencies for the subsystems the driver depends
> on (pwm and clk, I guess)? That would give us better build-time
> coverage with allmodconfig.

I'll add COMPILE_TEST, PWM is already there because this is in an if
PWM block. However I'm not sure for the clk, the LPC32xx use its own
implementation of the clk functions, what should I add in this case?

> > +	/* Write to limit register -> period */
> > +	__raw_writel(period, lpc32xx->base + MCLIM_REG_OFFSET(pwm));
> > +
> > +	/* Write to match register -> duty */
> > +	__raw_writel(period - duty, lpc32xx->base + MCMAT_REG_OFFSET(pwm));
>=20
> Please don't use __raw_{writel,readl} in driver, and change that to use
> readl_relaxed()/writel_relaxed().

Will do.

Alban

--Sig_/qnSqLzvmEtFs1iliWt5Amnf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUDyVKAAoJEHSUmkuduC28jhIP/Ar3A4SeSSsdhn3fCPxfG102
ZHk5+Vl1L3Z8rQhMZHpGY7O3Vkgfdpnt07iIAWRGt1bLsReo11N43Bz4FD0lefNq
fyVu5O1RZrnlfiA+oe3jSHZqoVHbxC0+S2LcKNRGzVN1YWWpOjWYNbPlsbiLEies
79IGPyXgBrIu4kyU7kWfG1WEiE02Q0JzFrEfKimNAEKUHgTycfTyzvk+lCUYOICi
fYtrYB9Lgyl7vtP15tCkbfREHh0KT28WOcTqutkoj8+UokBlwF3AhARaeazIZFcX
RlQcahci5v3NgkpskufW+iYtd5wRUJWccGGuXVIAGKHaJqn7XgwkYo10T1KbRQc8
oEessTQ5xlite6OAinm2KLjIFYKw9YeRETojuggOpPXyNnps3bB+3AtfmaGqcQu4
oonIVYouflQudwtCA8+DeOc4XchQpX2/kj8Fmc03CmpvBMXI+orX5kZBzQAVTt86
KIxyFv6klNeoIudxfVnadB1eceXwc3EKjr4GUmLcOuuDRm9+njK50OxA14RnjujJ
51MBKdL/65u5AWtuQTyz4PKzvDfYdDkkNl1Jd2vT04XKr07b26cHs115I4LjblJx
pXfLAOtlVT9oMmev12rz4N+NVwNNXCu96TNuilF1Y56kgVuGD9sjYm7qIQ6h+KNu
YreJrV3jMinKjSjHXxsO
=HG99
-----END PGP SIGNATURE-----

--Sig_/qnSqLzvmEtFs1iliWt5Amnf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
