From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: imx-pwm: add explicit compatible strings and
 required clock properties
Date: Wed, 11 Mar 2015 09:48:29 +0100
Message-ID: <20150311084827.GA19577@ulmo.nvidia.com>
References: <1425907461-13538-1-git-send-email-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43195 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbCKIse (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 04:48:34 -0400
Content-Disposition: inline
In-Reply-To: <1425907461-13538-1-git-send-email-mporter@konsulko.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matt Porter <mporter@konsulko.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 09:24:21AM -0400, Matt Porter wrote:
> The imx-pwm binding contains language indicating compatible
> strings to be used that is not valid for all supported parts
> e.g. Should be "fsl,<soc>-pwm". Fix this by enumerating the
> valid compatible strings that represent the two versions of
> this peripheral in use.
>=20
> The binding is also missing the clocks/clock-names properties
> so document these,the two required ipg and per clocks, and add
> add these properties to the example.
>=20
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> ---
> Changes since v1:
> - compatible strings include the actual soc and one of the two specific
>   compatible parts.
>=20
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAAFbAAoJEN0jrNd/PrOhMNoP/3JyxyEn5C9Wbw3ptB0UtP6l
4vby7bL03bFVSmbNc2umt9TwDRQ2Zmpa19xUQkfusUt2rG0Fkzza/EpyYrxRJm4I
iOit03ja5Kdw/d2lumR1Au7N4qWYwGv5W7ttbdF51WhzApIT7lRcEutXFFA6VpPU
dbhVborqRWkT3jBL5zkVXeYW94CuQ1YTHtPBspgar7BMF3SLAC37mT00z9LQ9H/Q
uYNtywFpPx4b6NwCUsl15dL5IJjTmzKCpdrCHSux1RKmbqDpoaRjBwhvltasZ3xW
kHUGPDiIGwqvm7BP/WBn6x4zCrHefeffpxqXZzdEXep5eYLR20wEsJeABUBk0MJR
Kafwc2+gD+gjM/dOBeYm6cx5KeoLrxzlTJHylcqgyuHTyeCbrqBT23wKYonnItDG
QrSkwpWApcL1pUMr4pKKARW6q4Hd2x52wm5pgrKYi36LLqlijuYzKcVUTk6B0dxd
vr0SYS1AZbjLzPEdHEBtYBc4EN9+Msao27sTj6sQUfWLW+8suC2sVxVgt6muxir4
OQgUVd83XSwZYPcJiMDM1r+069ld7jSougoFzKI+BR/8gS9SmbFItgWd5mBqKvki
nGMfaSTudrqK36S9nrvggMm1tLBZB4dITERGQ19Ap/3Rmfoqaf5r6C2fYkJIKI+t
p2V7+XjMNgdkDr14kq4a
=YykB
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
