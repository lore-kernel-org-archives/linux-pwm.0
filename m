From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm_bl: Fix overflow condition
Date: Wed, 30 Aug 2017 16:27:41 +0200
Message-ID: <20170830142741.GD1361@ulmo>
References: <20170829203434.6826-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829203434.6826-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, jingoohan1@gmail.com, lee.jones@linaro.org, briannorris@chromium.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 01:34:34PM -0700, Derek Basehore wrote:
> This fixes an overflow condition that can happen with high max
> brightness and period values in compute_duty_cycle. This fixes it by
> using a 64 bit variable for computing the duty cycle.
>=20
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I'm still confused by the brightness-levels-scale comment in the other
thread, but this looks like a good fix for a potential overflow so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmmy10ACgkQ3SOs138+
s6HBpw/9HbRgU+ihpX3o+CY2jSC1xkUohNax/cVdQwLAIBYjGH5G0zGf5LBF1sSI
VufS0wEWub6Q9lwxg4yD3uUm4/mYa1uhpI80/0+gDJ1g8tFUV00hKlX7gP2PoriF
BBNEL67YILNzFSvabuzC3CHTHcdsgOFmrl8boejIYOt0MW+JU4l/IV5FknwIZ3wm
jaj99gXj6oGWpU+fUmm32gdxdOBtuqlpYtXEK2yhYsEgf57IFyNgl3SWaUFx4/lX
xDo7TPF53a9Zy1GTrP9z94lNJ+lvYbxEmyymeOmbqDKGiV1i2udLPf54iVF3iL49
Hyx7G9/l3eG4jJ2sXEfMS5mL2u19a/Xc7WUDQglXVxDTkRjRSyU6DWnsyqePLug3
4mwZtZzstvrnsAU52L0b7bAw8KAfvyiCbPFqZy6jPrRp4NXXAelUvFHGzqVRJNwm
2vm4yuYASVorG1xE74H0uj1N5soZ3v/HzQAFhtuliywyk0cLR5CZcFrg9WT2uYbz
1OMeo/8mjfgVvPpDBvvglDuXgn7wVJB1H/cyhJFePeNQtRPCPTyJLj+nb9fc1i4q
DiuzONK+hO967iPH5yVdP94zwx4+mop8Uv91asZPzHxlPDtJ2P6z8iL/r1ppol4B
lKS6Ow0ziNoWTHVFUYSoRGPAOno5p5S+b+7afN38pxzSJMkzUms=
=3rT2
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
