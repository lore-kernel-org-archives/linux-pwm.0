From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
Date: Fri, 4 Mar 2016 16:01:06 +0100
Message-ID: <20160304150106.GA26400@ulmo.nvidia.com>
References: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0401651494617076072=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-pwm@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============0401651494617076072==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 11:57:09PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The clk API may return 0 on clk_get_rate, so we should check the result b=
efore
> using it as a divisor.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

Thierry

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW2aMyAAoJEN0jrNd/PrOhkxgP/iTt9FNmS6N8Ml2QARkvRJbG
15xtuYJAcnE/UbpSp/6mS68Ejf5Fs2R9wVoamOxt+IHPptl+us0Ys80t9+pSK94+
5d8+C3QTOjKSwoAZm/h9omgOAVy3VjAEvGXuN+CZqX0kd2dBtB55h2/Fu8r51kL2
r7+os+ggpvENOoSTXilpXi7XO8TiD7eDyPPG8xmsqyUGYB+HfgXkmzqQLsSYeC1b
+5iFYOId6WS7Kb075mkZR4UF+ckOoxmXQTESAhBJftA0zQkvb2O2koeI/q0xODV1
12ede+TSwuWwVIfljJK8qu7SwhNbmk2BnQUxIar1DKrNyKmFMPBjACWa5dIvHepJ
v3zWEUnQtszEahnQJZikkXsoBVojMbNHtWGUGBCJRP8Z0zl9ZPvzWtJBWYsyJOlZ
48TXFBaKohntcZ9cohVwDftFn9JVZRbp7JJADNyhsdgA32qV/VxraDBQ4fMqjAsO
aQMnzLW7Q1Lxf+/TCtkrpkHbbkZSuYyaCMVaL5UaRDJIZUW9WWZ5HgMPUsRqWt//
gIZTsySYpCGJHcjQKTpJn47maw4NsDfv6NbvNxBdh1CEqExVSLNNL5XPvpAfElr1
w72q43rpqvmfBJuUgulliQWwSswhdbTn/yatg+1x+ygP3NpXUxDr9bLa1E3Ukign
xGMNloPGE8itKEub2hhB
=dC7Y
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


--===============0401651494617076072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0401651494617076072==--
