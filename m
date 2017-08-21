From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/6] pwm: mediatek: fix clock control issue
Date: Mon, 21 Aug 2017 09:47:50 +0200
Message-ID: <20170821074750.GM18996@ulmo>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-4-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498802721-32455-4-git-send-email-zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 02:05:18PM +0800, Zhi Mao wrote:
> 1. prepare top/main clk in mtk_pwm_probe() function,
>    it will increase power consumption
>    and in original code these clocks is only prepeare but never enabled.
> 2. pwm clock should be enabled before setting pwm registers
>    in function: mtk_pwm_config().
> 3. delete "pwm_disable" in function:mtk_pwm_remove(),
>    as framework should disable all the pwms, before remove them.
>=20
> Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/pwm-mediatek.c |   69 ++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 47 insertions(+), 22 deletions(-)

I think the commit description could be better. Try to avoid enumerating
changes like you did. Not only is it tedious to read, but this kind of
enumeration is often a sign that you can split the commit up into
multiple logical changes.

Especially the change described in 3) is not related to the clock. It's
also not a quite correct description, because there is no code in the
framework that disables PWMs on chip removal. Users should've disabled
the PWMs that they were using.

The framework could probably warn about misuse, though.

That said, I've left the change as-is, and changed the commit message to
this:

--- >8 ---
pwm: mediatek: Fix clock control issue

In order to save some power, do not prepare the top and main clocks
during mtk_pwm_probe(). Instead, prepare the clocks only when necessary
and also make sure to enable the clocks to match the semantics of the
common clock framework.

While at it, don't explicitly disable all PWM channels in ->remove()
because all users should have done that already.

Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
Signed-off-by: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--- 8< ---

Try to keep this in mind for future patch submissions.

Applied to for-4.14/drivers, thanks.

Thierry

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmakCQACgkQ3SOs138+
s6Fzgg//SimI3CMG0wDFBq5XLzEhPzdCg8WN/YTIQZSb/EHy4R5cI4zAwZuY4Hk+
mjF/dYazJ6oEaVFt7eFPHv6VgFHMUF410rF3SDxTk2hooGtkfcRcvueEgwyPsJLI
d7NjiIaTkvLlDmRmbKM63DhO4sToIPrFcrlSLXuTFVfDTgjTMDft4vrG1IMU3HXf
7D8O+oJ3SsNJdMxaDdx+U8PxpNrex/1pVy8CoOhQmwU7QtbZvJfivpvqMF+QCrR7
IQiSjxQjEpD7Z7UejZtYZmgH92hl7g2AoIJlHgNVIdhjKltZv200RSn7sMoIHHT5
4nKfIML7EEdWwK+CAZUhSP25e/2di8iPMQfjmG8PIBS+PSkPC8do9ywvh+RA4+Uk
klM6op/7bfR9lkika9tF/0OTSqf4smwa1GS6GFZC2i9US1yr6JgHepdc3nB//3fP
Kaklul7lJPPbvt073TCPuw73sKYM1vZEXGV3QSjaFWS28caMdDiG8RNJPsUsy+e9
5zAxU0Gk56Va5tGUKsCBviZgC5eB2EuDpOZSCdotdyLvg903Mtu+OGXOraM+lWAV
DUbZKXjk/aY2BqVw4fsQQDXEVLfenOyTISi3DDFUj90aRPeIO/7CnSHi0eC/7Ycq
24/9VCEXTM7Tab5lOAYdWFCvKiVvDgg9gTWWj07KCMmkSGueV0I=
=7kdD
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
