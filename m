From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: dt: add Broadcom BCM7038 PWM
 controller binding
Date: Mon, 17 Aug 2015 16:49:49 +0200
Message-ID: <20150817144947.GG6891@ulmo.nvidia.com>
References: <1438908959-1578-1-git-send-email-f.fainelli@gmail.com>
 <1438908959-1578-2-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33929 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbHQOuz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 10:50:55 -0400
Content-Disposition: inline
In-Reply-To: <1438908959-1578-2-git-send-email-f.fainelli@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 05:55:57PM -0700, Florian Fainelli wrote:
> Add a binding documentation for the Broadcom BCM7038 PWM controller found=
 in
> BCM7xxx chips.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pw=
m.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b=
/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
> new file mode 100644
> index 000000000000..8b9bc43b561e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
> @@ -0,0 +1,22 @@
> +Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
> +
> +Required properties:
> +
> +- compatible: must be "brcm,bcm7038-pwm"
> +- reg: physical base address and length for this controller
> +- #pwm-cells: should be 2. See pwm.txt in this directory for a descripti=
on
> +  of the cells format.
> +
> +Optional properties:
> +
> +- clocks: a phandle to the reference clock for this block which is fed t=
hrough
> +  its internal variable clock frequency generator

Why is this optional? I would assume that the hardware always needs some
sort of reference clock to properly function.

Thierry

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0fSGAAoJEN0jrNd/PrOhE88P/R7tgeI4Uslv5HwlllHllmCt
Z4lrsTi6ERW0sQ/S2VJy7rDB6fjEzEALcuH5TAPPeZGrxeCOkKQNqu1q53nYodS2
A8+f0l2gnHbkuONM8awZSaYOpR9shEgkHgOYAZaDn8YVTNUOFDUlWnHgOmsYVqLt
UXJ5vLrfT92/dHlE4Rvj8LlpAC0wcgM8vnHQvMuToVfCKRN+s3Vy6Ua4KK4cJ7pV
Ax81GlS1a0AHiTWjb3f0cZ4EQJKHtfp1drCzztlgRnkOQ5rRSkVCBIwdCAYwbIQl
/kh5PNTWopx0ScutdtUASgA7GKru0xcAXRgxz7gEWXLHe9t/ui2l+cCm7leMRXwQ
8soKQjLkwbCpPukfttSird5iI1JZGG9GHkaDx1+VtFfhCEAf+aAnjUgQuRC68OXg
I4WSapXv55Z2xvqeSlIkqinbCw7MzR8KDW365cs2jRjo4iOWwh58yIX2TttXPnbm
61v56+gl5U15YmXoLnNf6Cpw9qHKW3ECUCM0cdZPJsCQ1ZCgHSckY10LoJHmYbDL
KfdisZHLJbNbCUdhZ1dlBXM23Hy14RpOGl6i6eXg/+0avRuwFdnNapPsA+ClJt/E
L27zdUzYVAj9uWs48K5nQJWIY1YcSkjY8DOsgGksH5GPPJVo0vdMLgTUxl7cctkw
7TPwx2O3dvFOQDHy7PBQ
=UMzi
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
