From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata
 handling
Date: Thu, 4 Dec 2014 14:12:31 +0100
Message-ID: <20141204131229.GA7262@ulmo.nvidia.com>
References: <1416407589-8157-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64048 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaLDNMg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Dec 2014 08:12:36 -0500
Content-Disposition: inline
In-Reply-To: <1416407589-8157-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2014 at 03:33:09PM +0100, Boris Brezillon wrote:
> at91sam9x5 has an errata forbidding the use of slow clk as a clk source a=
nd
> sama5d3 SoCs has another errata forbidding the use of div1 prescaler.
>=20
> Take both of these erratas into account.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Hi Thierry,
>=20
> I've addressed the "erratas stored in of_device_id data" part, but still
> haven't modified the compatible strings of the HLCDC subdevices.
>=20
> Please let me know if you really want to handle erratas through pwm
> compatibles instead of parent device compatibles.
>=20
> Regards,
>=20
> Boris
>=20
> Changes since v1:
> - use data field in of_device_id to attach erratas to an IP revision
>=20
>  drivers/pwm/pwm-atmel-hlcdc.c | 50 +++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 45 insertions(+), 5 deletions(-)

I applied this, but this was really much more difficult than I would've
wanted. Since the MFD driver hasn't been merged into Linus' tree yet I
wasn't able to actually build test this driver at all without manually
pulling in the patches that add the MFD support. I went through this
trouble this time because it's what we had agreed upon, but for the
record, next time I'll request a stable branch that I can pull into the
PWM tree to resolve this kind of dependency. Or patches will have to
wait until the next merge window. I don't want to have to jump through
hoops just to make sure the code in my tree actually compiles.

Oh, and it's good that I do compile tests because...

> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
[...]
> +const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_at91sam9x5_erratas =
=3D {
> +	.slow_clk_errata =3D true,
> +};
> +
> +const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_sama5d3_erratas =3D=
 {
> +	.div1_clk_errata =3D true,
> +};

=2E.. these actually should be static.

Also I took the liberty of substituting "erratum" for "errata" and
"errata" for "erratas".

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUgF29AAoJEN0jrNd/PrOhKcgP/0dgcHqwqqQd4EqDZ/CaljKw
5528yQ3XmcxrUR7FILzFzv7KyZjSc5F06B1ZGPd9WxNRJsfcW/nBIaazlH+6K3dq
DbtB+5GAVUekuLvNfpEYKpVMjhLECl+qKjRQKASt3TkZVpWR6dfsf+kwl/0Em6nX
fS+yFgMhaRrh7gbpzUXa6m7bL0Ct92sfbZ5XT0E91fpkd16rZGrBdVgXKvK8w+/h
bsYgIHqw7AjA11Oy0Sbm6F0AfuEjre3/yzT7xZRw987rDBVpNQ7hc/AyeS94VnRk
2R0vbe/bk3TypGB4Ob8zBwCOEfkSRmyKeX+MMc97a47GBQr+0ns3HOXzdlrm774y
sFeTqFdl0XYyKSXPdr7Qt8qHyg1Zv6bbVFcJYAYyb6c0eBE8F9azcjI4UZEgxwu/
HaAjNbeD41HSBMeylt/iBKkiRwV/4Ia/6I9Ud/I1siiHlNT3NkH+WMfQnSYqmZnx
hLmD51+vShzXnyg7NwHS72jR/RMlGd3ND3V+6UfzdodAkDqkS0TbjK9p0wj5YjUO
YiFEG7xdYDvcrwN82fS/0zXXkAnO6NuwBIzaAtNwYRMk4T2XWlmfgtyHk2Akm8qj
ao4LtoPwA7+9UHbwHSAuGr5TgbGGNGUnJVLUN69sHVHc49u/oYEtRNKRPx92EzdW
78PySElGxxVAJ5PEDXOg
=gjQD
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
