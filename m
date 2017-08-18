From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value
 of pwm_config
Date: Fri, 18 Aug 2017 17:32:55 +0200
Message-ID: <20170818153255.GC18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37152 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdHRPc6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2017 11:32:58 -0400
Content-Disposition: inline
In-Reply-To: <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:38:30PM +0800, David Wu wrote:
> It seems the rockchip_pwm_config always returns the result 0,
> so remove the judge.
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

I don't understand what the "judge" is supposed to be, but I've applied
this to for-4.14/drivers anyway. Thanks.

Thierry

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXCKcACgkQ3SOs138+
s6G86xAAglfoLi0BXXtHUNBnnYqktkKYCxP7IiV/Uq2gz4I8WhaKBK248LOetd6T
bSfhrAsdnSnnIxZ6AYp42G5pwRSjZJCaR4j/v5yTuLtCEa/Y3IJlk83hFP6Qrqwd
m8oLhAQxiXq11HyGLildTfjqxhHl0UfMJJAO6H1ez7igXBuBCop7/BLmP4KEniWU
dySFrY8lcLVOUFvdLypN2SPuBV4DdK9dh7mgR5uaB6BF1tFUkALM/Kd8EuSVjh3m
GT6B1i5vdxa2064+LGWN/sUGh5azSLg6iIUSnrECKbEOFHsL78a5lC4lPeLB8SSv
FQmn4mGvVQdoGEWRtN4EcCPDlxNp8O83DcL/N+Z0xASLUwZyKAo/QZIPkaWgpcby
kE0rHafOEqXQcxMVCFEf5gHz7UlD5Q9UHQedabrnpiwBCSiiBoUOJIoVzpt555Cj
hQRRygj4eMf7iOMwWL1D7C0yBexurxBVx4hZt+nVdivz46PnxcG7/Oj5LfOqhLDP
Tqeq6romBV4nE3BkUzBguAF+tFSlEm2I2ZdlCVmpJtipscSI9Ql4XqwAvwbi1dz3
a3OH5IGRpyZrb/jrzPnwsE1SFJt8ZJBRMe4nt3tgg3PkWFvLv0jYRDhBbiJn7AtI
dROG7KBido1Scptm+7UqP0hDBBcuXxndfX32IsoPWm6zaji7bIM=
=s4Km
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
