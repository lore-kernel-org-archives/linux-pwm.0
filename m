From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
Date: Mon, 29 Oct 2018 12:33:37 +0100
Message-ID: <20181029113337.GA9500@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8146336263204914940=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Krzysztof Kozlowski <krzk@kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--===============8146336263204914940==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This helps to convert drivers from the legacy API to pwm_apply_state with=
out
> having to make the aware of the configured polarity (and in some cases ev=
en
> period).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/linux/pwm.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

You're going to have to at least Cc me on patches 2 & 3 so that I can
see how you intend this to be used.

Thierry

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvW8A4ACgkQ3SOs138+
s6HQ+xAAmc64VFrMB+cnfuwv+8dupQroVprblMQ7Z9CBqLqo5YcWKHEjjAUVDL6c
T40GrZxXsxz16aaF/TfmUT4B4GP6WmNply162E7E8kDIWD3kT8n1zIgV7J5FYROU
MchUTfnqWchiZ5TnW3pjpZaCAIIzSJdA5fK47iWbSTqLKTwNEVfpv+lkCE0h707y
F2nXgQFTS9K6v8zpDnMhGWx/5Q1wLxJGoMscecZKI920dj5MjrweAWOAF9vETBRq
z9rmfWWH5I1TjFDP1sJ+YtreL55QeQQevnz8S07hopkKLYr85yycuf5TV53Fedsx
FwszcTDp18gu277dGJPXIySsjDuOx+Nr4pNYITA0pzIMzDpjr80WYYZZOi3ibY5n
k1PquHYRirsmZC1dHER/IDg3lpnKQVHDqBm2We+gVv98z3rpFHhPoiNQmLdHxAgV
WwVpmP3nGQoHnOtkNUX6cITzTlvnUI1eFkfJo/jMuDAWPI5OSLbAzrnUYCZro9hA
CNRJ3FZMSj/MeSJ8WcFsGaQ/l1xLNcpiwGyvNfRGhhdTNT1zYUqEyZuwTAvPPGlk
/PDUorRELfz5ERRaDMAc7EP7FgQ/YsExOw3xXHDopqn0uEWNV3JT2OZYyeD1NuXv
yuKhoAIPq6ulu6PCUens4PYURSFSwFhmfgMWZCmw5uSIeU7Vc/c=
=Km+y
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============8146336263204914940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8146336263204914940==--
