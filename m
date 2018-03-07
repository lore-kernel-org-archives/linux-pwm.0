From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 1/5] pwm: sun4i: drop unused .has_rdy member
Date: Wed, 7 Mar 2018 08:40:58 +0100
Message-ID: <20180307074058.yvnayz7zywk24jt3@flea.lan>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-2-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3893909859571066365=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180307020719.6675-2-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============3893909859571066365==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54ilskwua3nbnhf2"
Content-Disposition: inline


--54ilskwua3nbnhf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 02:07:15AM +0000, Andre Przywara wrote:
> Commit a054c4d68408 ("pwm: sun4i: Drop legacy callbacks") dropped the
> only user of the .has_rdy member in our sun4i_pwm_data struct.
> Consequently we don't need to store this anymore for the various SoCs,
> which paves the way for further simplifications.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--54ilskwua3nbnhf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqfl3cACgkQ0rTAlCFN
r3RDIA/+J28ErDXVI4PdDfYmPYP6Nj4zaLGUFnvoCDOdJ5b2nXhSbwrL6EBLAaUT
oQ4dF6yRuip3bBbLhX+Aj3lsH6G/1JrSvpeFIVehDOrrifzf0dEPCqn19lp0jZw2
FEtFeWRToSAl0eg87uparGb3yBq1SN/2T+Bx3whWNfxLhHLSXyFqmNStG9i7gND8
WXeZmUao4LRGuXoYposo07KdE0xs09tDHnTDVQ8rif6sXrqRAyO9Gmf4XSmcIBqx
PaUTyISbJbEp90jYp6y+aF8kad/C/WIGOrKMY2QWNMnm5tnDfCmcfYsYUIQ0rzP+
Mf7jYz6kT6nvwOIQshUrMBY5kWU7UVfePaAlwucbl2yJ5NNs3KMXCzqUIccNQWPX
WwlIOzZPIKerYBXXKD9ZeUBsi4nKXPqjDRtGMXRLYD+nOp3Yua9ab/ypsg+FVv2a
AGfSgzqSMMTK8Hhd85JN72Rg+zAPFvpgYklFw8vKfkeSLqOIFs612OKFeaeEQMWy
Ecc5hKAK4g4eTkMqSKopuxDw0/X0/O7jp5BD4XgWAOpmqBNdg8uur0wy/VTTsDos
wnWHYbVQRLwlisxQm3g8fr+isGqgFchCFnMv2Q5B/cx2hoFTzHAD839AmcmUP3wC
YgIvv8QKORtJfAe4p0rMlMSIYU2BRDO6Or/QQy1brtRqI/Zwbcg=
=whpa
-----END PGP SIGNATURE-----

--54ilskwua3nbnhf2--


--===============3893909859571066365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3893909859571066365==--
