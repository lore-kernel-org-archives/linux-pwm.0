From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Wed, 6 Feb 2019 13:55:45 +0100
Message-ID: <20190206125545.GI21676@ulmo>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com, Tomasz Duszynski <tduszyns@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:54:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
> > If you agree with the current approach, I can send a V2 with Tomasz's
> > suggestion to remove the ifdefs and use __maybe_unused instead.
>=20
> I think the suspend callback should have something like:
>=20
> 	if (is_still_enabled) {
> 		/*
> 		 * The consumer didn't stop us, so refuse to suspend.
> 		 */
> 		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
> 		return -EBUSY;
> 	}
>=20
> This way there are no bad surprises if the pwm is suspended before its
> consumer and it's obvious what is missing.

Something that just occurred to me: perhaps as part of pwm_get() we
should track where we were being requested from so that we could give
hints in situations like this as to where the consumer is that forgot
to suspend the PWM.

I suppose we already have pwm_device.label to help with this, but
perhaps we could improve things if we stored __builtin_return_address
during pwm_get() to help users pinpoint where they need to look.

Thierry

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa2VEACgkQ3SOs138+
s6EMtQ/+NuYEI6bg9mbWLyhJ3zRbtXrmiV+D2Rr3AvfBXKYks4TF9pGSJFk3f/L+
GLjT4DXZqqCHlnZkHRkvUe/FVjwkSvusTwcQE6TPYZ9ikPG1pXoaA8mFAR9NS4Yf
E0RWwnoMkIpnvF82peQf1zb1ZIlaSwidvFYTA3XYXjdRXzjipix2qkYy55K9FBU7
X9z6uJlAk7UgoTNXKmt+C6VPLTKdQ0TGcN7j/mVIv9cBeYaRzqrUicTqDqMU+Qw1
2kZDJwaXqD4wB0ai8631f2sdruSlIREg8+M4HydMZxiwuqZ0zuX2I3Gm2ihdUQ3P
fFkslyeUouUJ0IWGtZMY1Y5HexCKD3iN837g7Iugpo4rvr2ububpfiCuG1o7v/W4
n3jO7/K0SmjBO+iMiaFgmoaJeEIvg+F+64n54F5ZNdnk1+dVWwJJhHFTtpsGq1c8
bK+MNRdVlwGRug61fIXKQSKPqkr+Flx6xYv+y0AZZ/fGV5Lujx4vJgydUdnfKrqV
OWivKy6KysxAMbgmyyxfDkx06GPlSPk/g7iJ37I5SeHwuie9HWi7M1iycPYIdo+x
hlYJOJOfhXQ+WxaBQ8u6xGW7a4SBJbOKdup60mkVftOJT7yl0ydHtWdOyXpJ92xX
RxWJVBo7WifuGP/40vv6Kz9XFYXBvlCOO1xvvbkismhJjAqVFHo=
=Re92
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
