From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add bindings doc for ZTE ZX PWM
 controller
Date: Mon, 21 Aug 2017 07:50:48 +0200
Message-ID: <20170821055048.GB18996@ulmo>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
 <1501143817-15843-2-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36799 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdHUFuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 01:50:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id f8so10680789wrf.3
        for <linux-pwm@vger.kernel.org>; Sun, 20 Aug 2017 22:50:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501143817-15843-2-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 04:23:36PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
>=20
> It adds bindings document for ZTE ZX PWM controller.  The device
> has two clocks: PCLK and WCLK.  The PCLK is for register access, and
> WCLK is the reference clock for calculating period and duty cycles.
> Also, the device supports polarity configuration, so #pwm-cells should
> be 3.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-zx.txt | 22 ++++++++++++++++++=
++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt

Applied to for-4.14/drivers, thanks.

Thierry

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmadLUACgkQ3SOs138+
s6Gx7g/9HKYu3LR+v+buZ7bdYOk49cpCRyvN9tCXNvPy0tH/FwKQfAOLUYSOX0Wu
4q3XqxQX2ro53Lcsddzmu2Wzos3UkoBeDVV83Klxz4uKXSnDUY2+Zvoevshz+UIJ
76r4tkoBUwlCa1dND2A63i8Nb8dy6QCo1kIeC6/hi6Csk/3SgpA0+n0JXGsxcNv0
ocHKr73TiAXbdA84PIkLeevGJM7z3OuQxmdW4kZW/akeYsmTiuHrIfW7UQLyOANq
0nvvpt9AfYCsYLctsnegrw1p1yD1y/3l+BGfvOQfT/uP7gM5bkdGFWtoDfLniUen
GFj/MBfxGcVBn0ECAaxNEStfpjPdlovMCX7fU+BbIbZFJ6lDUk9hpoF99Uui5wyN
C5Z88O2GOy7eHvG3Gxg4xLMEu3g9oIAVq4wIonPxzp/KFsWw/io3UwSjPF3RUupm
Yk7podljohhcuY8f3mkO+r4XqZGJ7tUPb5F7OzE595f4AdlLbPo55cMl2YgtG/z/
VEh153T15JLWZV4YvVLh7gFmJ/9qGvH1qcy/YZA8RpzPmk5gQ9Bc5aeGkPjwli34
3kHL90HuhUj2U5Q9cVxtFARawSy6cPvIhZdj3qKOrIs/XG9d52ZA4W63Xclg+2DE
8N4Vd6vTiNT36KOXhaDlvLx8gMlP7a6ey06j8hyWB7Y/BjywOl4=
=hn7v
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
