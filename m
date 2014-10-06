From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 01/11] mfd: add atmel-hlcdc driver
Date: Mon, 6 Oct 2014 12:49:17 +0200
Message-ID: <20141006104917.GF25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0756251155=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412175188-28278-2-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--===============0756251155==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 04:52:58PM +0200, Boris Brezillon wrote:
[...]
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
[...]
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (C) 2014 Free Electrons
> + * Copyright (C) 2014 Atmel
> + *
> + * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
[...]
> +MODULE_LICENSE("GPL");

Should be "GPL v2" according to the header comment.

Thierry

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMnOtAAoJEN0jrNd/PrOhGW4P/jXfxgQLWe1g0LYFNcrokYOs
upOvspDWjmRuM+o3oEgM1NqmUuilnhbPU6kMtmVKyJbPrnWa0PXrz4h6ooM+KHBM
t9KgsuP5Yrk2yWf+LDTklawEgUj7tNkyvF3wXOgV3CU6Ko4Yir8ZzoSoccUMNqpQ
mgzHDWJ+P/CdoMyNFBJGX7Hmmkou/LngrKu2fg4/KQaCu+iYsbreVQp7NMkbiqqQ
iqZgBIrqmQgYgbAWdLRoAk+1IerWWZBPXoYIisrBWsc5QsJXNw3fqRKYAUivUiuv
vl4v5lhQD7J65agYR9kECTR/OBRIMhv8bWM4eNjF7WCdUiYzKO45HDUsVvOucMQu
tihj5pdJgpKBnNL9g1PaJXhuNJ+Ae9CqIJlwt94qCMabNRQZMwKXIk3eXGrijEtt
otUfwD23cZOTtjGn35ZyLmcrbS7Lv7KgaDDPSyn/uE7G/4tDi6vp0vq74HA5ElQn
+OQzvMBh2W/qP+MhywtnUbH7aSrH6P+zuk869U7yR8GWp94rbGHSvzEAwyJBq4rT
3NBGtit2er18ejzLgxvc/f9AGGaXbYewC+Uja/v4w7fa2p5/Ji6xL/GTNYJoAVl2
gPsTbypToLC40E0gsIvVK865yI76fywuLvh9AfhVvx/GxQ7TWNePau5cX+qZrPBh
NWnYvZA9CEETUrzZmdoj
=ZLAW
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

--===============0756251155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0756251155==--
