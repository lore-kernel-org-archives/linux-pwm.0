From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter
 interface
Date: Mon, 8 Apr 2019 23:55:15 +0200
Message-ID: <20190408215515.GA27592@amd>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-pwm@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +const char *const counter_count_direction_str[2] =3D {
> +	[COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> +	[COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> +
> +const char *const counter_count_mode_str[4] =3D {
> +	[COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> +	[COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> +	[COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> +	[COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> +};
> +EXPORT_SYMBOL_GPL(counter_count_mode_str);

Dunno. Exporting const tables saying "forward" and "backward". Can we
=2E.. somehow make it work without need to export this?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrw0MACgkQMOfwapXb+vI0fQCeOVJVU9FSIbeRA4WSFP7n6OI7
dq8AnR+Ykf6BWrqHixl+oRJ+LYhLlFau
=/6R+
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
