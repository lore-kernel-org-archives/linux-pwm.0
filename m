From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
Date: Tue, 20 Nov 2018 16:42:17 +0100
Message-ID: <20181120154217.GC28796@ulmo>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <20181116100500.GC28631@ulmo>
 <20181119195528.elyioqz36be3ews3@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5658450020073715235=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181119195528.elyioqz36be3ews3@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============5658450020073715235==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 08:55:28PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Nov 16, 2018 at 11:05:00AM +0100, Thierry Reding wrote:
> > Applied, with some minor fixes to the commit message (pwm -> PWM,
> > pwm_release -> pwm_put(), ...).
>=20
> Thanks. I wonder though why the commit didn't make it into next yet.
> Your for-next branch doesn't contain anything that's not already in
> Linus Torvalds' tree. I assume this isn't on purpose and you just didn't
> push your changes out?

Pushed now.

Thierry

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv0K1kACgkQ3SOs138+
s6FRBA//eXx0N0gakUr6YUEiqsOiC7DaGObE3IvuCJPdEUje2I4BVlw5ngoLKm+i
bvqW8+4Kdxo2wSZVoTx5aF949Do5Go68caoSqgrw+ieJdQLZrv5E/v8+k/9rxoZR
SUpUDABeHE4Q8j9mopncQNaUk298hEFflrmo+gLbeFMb6vI6KPRA2otzA3p17MJd
iOlqXw3TLKPRNujYexm+/BTOSDUNS7SKloi4av6D80qPo+CdOslrs9YDSqVtrluG
8sdDiBZCRdXfLPvWfx8al/aVgBlyJ1nSOrFXvLPudcyEcM/1LpgU8ujkynCVjCYz
oZOKagWpkuuL3gUjPsqGwzOmP4Av2gvVT6tsGfUpTMfuXr3KLgDyCF9mHgmZAbQZ
a3MnW2HDLued+Am4UtHXaUEVjG9T88OwuhzAQr0dhMBoCSVlVO9nPpRveBiB76Xv
5pA7m+aZxersbOdbcXvvapD99FkYqpAxulzvqpCZi66l6lREunmRfdo8dqDSXtQK
VedWwsrf98aWA7yyIHPWdby38WWyQpkl0FCn6ujw5XifzroHUzNffAnR6NIyi776
XNDQbGxeNAl+zhbafQ+MCmZPViu2tEnaw/BCqGV1q9TR/LyaS/7NeirmjJQUdN0/
8HUAyrHMR3Oit49KOXlXnJt8/7pvmG6oyfrfm/l7XlB6fjFITEk=
=7GXS
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--


--===============5658450020073715235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5658450020073715235==--
