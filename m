From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/4] bus: ts-nbus: weaken driver dependency to allow
 broader compile testing
Date: Wed, 14 Nov 2018 13:18:38 +0100
Message-ID: <20181114121838.GF2620@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5602112271536719647=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--===============5602112271536719647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:41:58PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> There is nothing specific for the i.MX28 SoC in the ts-nbus driver and
> it compiles just fine with an ARM/s3c24xx configuration.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/bus/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks like Sebastien's email no longer exists. Seeing that this driver
was merged a year ago and doesn't have any in-kernel users I wonder if
there's any use in keeping it.

Arnd, this looks completely dead at this point and it doesn't seem like
this ever had any users, should we remove it?

Thierry

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsEp4ACgkQ3SOs138+
s6HrDxAAiDp7aevU4WHM+oWrk0sF8UYS7jwGFElskq0XdmhEPEgvT8SmkUvXgI4v
88S9mVIvwf6jeGHo2p/SuHnet169jN3N2Io7uMf0hpEy4vYgYjfuN0WLzHqFOArz
VdiA/zr+a9mbqCQQvdlYO2GfVPZH+BZuSKjXgQ+A/RqT7XCN674+79nZsjy7h/Af
pJ/zBsd5TnA1gGy8reY5PzzuJcrM1G0xcmF1wV4ZEtGZ3wgnRoM2GJgvqTK9BhPv
s07BTDybcPxM/O3qmP3EQWEU+E7Bms9LKBNmgL+TVZUgtgk73zO9bZSgAO96CFn1
Q6Jz0ZJIGVIzKjWj44f9QCmgmPisQNGhvSoSZT6BqNyZ8U7/1yOEM/w9pgnwmHO1
lCzM/uDbep56ULu4jQC0kBQ/VR/W7wa58r4zWlsDFILfTs/wEozDvyGkQsAlwYl+
DP1Dmssn/MGqNyN3E1R6HEp6/9C5RVmRUEQ36WVLjsQQE4BGQiO/ZG3r6SLDT2fl
jo4l4k8Eq471UISVUJRF5qTglSzQ5cfDnkIyFR/GEOKNqOLrd8/lzM+LsdHUxKiL
P+coVOcARtKmEtsE4s9FK8uWTpo3BFwjsYXDAI49LQTG5JbxtpEPGHaygdA7+A1d
4VjgkkfdT4tYMhWH8BZEGlWs4hP9QSuxM8+0RvUQE2Jp9yFmkT0=
=KCU3
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--


--===============5602112271536719647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5602112271536719647==--
