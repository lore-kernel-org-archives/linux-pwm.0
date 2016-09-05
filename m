From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Mon, 5 Sep 2016 11:53:21 +0200
Message-ID: <20160905095321.GB31424@ulmo.ba.sec>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34883 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbcIEJxZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 05:53:25 -0400
Content-Disposition: inline
In-Reply-To: <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 28, 2016 at 06:33:03PM +0200, Martin Blumenstingl wrote:
> On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> > Add support for the PWM controller found in the Amlogic SoCs.
> > This driver supports the Meson8b and GXBB SoCs.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I could enable the AP6330 SDIO wifi module with this on my
> meson-gxbb-vega-s95-meta clone, which uses pwm_e to generate the LPO
> clock for the wifi module (see [0] for the corresponding patches).
> So thank you Neil, and:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Hi Martin,

As mentioned in another reply in this thread I ended up restructuring
the driver a little before applying it to the PWM tree. I don't /think/
there are any functional changes, so I left your Tested-by in place, but
it would be great if you could retest and confirm, just to make sure.

The driver is in the for-4.9/drivers branch of the PWM tree:

	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-4.9/drivers

Thanks,
Thierry

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUCPAAoJEN0jrNd/PrOhgxIP/1THwKk+Jaxe24mVdRa2+STl
9hN7/K1Nl1UNuu6CcfUDn9bpEDxf2ZtmUxWOPCzH76lNqhwaEo8DooE/WJhCpbVG
QuBBa3lnP/f/GZQquaqaEc135i8KVw7kiDsrK8QuQVCRYrQvmO0VLjaRCIUPK0E7
rUkS5mYiE35xWeXHkGlb8x12COpMxnvUf5MlMQvqzH5yVVPZbDXc/hQFmkhuKk/O
aSW16SztQxcSjkUGaiB3+gNGgPSTzN98d1LNoBsSuFuAYDqlQMc8OCP/qbSBe2Py
e2Dnngd4bbOAyxkAPi6CMnbSlGXmTdRxbh2RWjaMj+V9NWYpqIKjR2L+Mx5yTm1m
Uf94R7UqtaPTD5G9jTpkBMUCB+XrJdeFlwq+UjRkaVTVaygm6VNCZoOlNlwKTezP
VYj+JmvZDE3K1/ypoYnthGZZJWl+P1a/5nDpCE+vXab1M5jgd+BOoyfRQJYEPPGl
Egx2Ft4j1IGqmwUsRH388+LYuDFGll841PY1AO4JCzfUtSbF9gfZh/v5dkm1ESI4
nfLGuzkpRLnAsbeKZO4qjb0F5Jq75Y0aTEy+/q8sJXLDrndCQmtYCf2d6ADxEbK0
7xgEBPiLhIkPF/Y6/foNMZae2CgjeZGNCU59ZFRnJsI04R/DZ6/xC805Eo93tHDv
dgDjoZbWhiU2AUQjuwSa
=UOTc
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
