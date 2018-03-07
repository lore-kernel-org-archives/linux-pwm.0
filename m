From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
Date: Wed, 7 Mar 2018 08:45:16 +0100
Message-ID: <20180307074516.dbak7ztkua4p7mr5@flea.lan>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8868481044358396776=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180307020719.6675-4-andre.przywara@arm.com>
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


--===============8868481044358396776==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="roij5ffbylmqsknx"
Content-Disposition: inline


--roij5ffbylmqsknx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
> used in older SoCs (H3, A64), it features a dedicated reset line which
> needs to be de-asserted.
> Add support for an optional "resets" DT property in our pwm-sun4i probe
> routine, and assert and de-assert the reset line, where needed.
> This allows to enable PWM support on the H6.

This isn't optional then. It's mandatory on the H6, and unneeded on
everything else. This is what we should have.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--roij5ffbylmqsknx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqfmIsACgkQ0rTAlCFN
r3QW8hAAhCxEawf+JYCAUXP2NbkElQSepocwBKYFYf9ypd+RN2kor/xQlE8KuGLf
TigOZCxBbxQkyqjfzEyBKCd0MDJJmv+X2echnDNz7+KBzD19/sfzLQQm9uev71l+
bGLiu/VZ6AUEaQZRxSWQIdbPOvnsqc/HQ9OHNH5vIUeMM/krpy4M0jXRnNRSraaX
cDkOa5A0Pib06RBDz6MlELVLzwx+lShJQuaPJUiuZxPF8KF6F6IIHNXZhNUbbtRq
gYq53EDqUeSDvgAOomiM+ns5+KAoog2X/XZ2pQdD0ubBMA7OIy/HN69MCdFoR4jB
okzlx87gB/9boE1I6/vjMNuvRBDk+Miwa+UEshOmQ81oWTubw2G2PTVOzVKYEzC5
j/GJChQ1s4Mwf2XVGDXuG1GdTVUMWeI1kU8I/iDi3vpOLiduJVD7LOtoZ30nhdBU
KrQuvef4mp+jxCnisyE5JQGOt5HIJCLRi+MdS678knWuysLXC0ZQHplWEM9tKH4K
sJZFpmILpT7RtgK9FVErypQ4/IEoYo+HKlyGfcpJWSetRIR7OqJSV1KZ48VeMoRD
U7q0dnfGDs3/PLnL/GdX2LUbW1TVbn02EjCoWFUfIW6FmAWMDaki/zVMElVxgijZ
vwyM/oiOvEbMrGMMckCrrJipcizor8qQCmivLH+Pq+taEugRPJs=
=Y921
-----END PGP SIGNATURE-----

--roij5ffbylmqsknx--


--===============8868481044358396776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8868481044358396776==--
