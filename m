From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 0/2] pwm: bcm2835: Support for polarity setting via DT
Date: Mon, 21 Aug 2017 07:28:21 +0200
Message-ID: <20170821052821.GA18996@ulmo>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34566 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdHUF2Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 01:28:24 -0400
Content-Disposition: inline
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2017 at 12:19:42PM +0200, Stefan Wahren wrote:
> This patch series adds support for the third (optional) pwm cell to speci=
fy the
> polarity.
>=20
> Changes in V2:
> * add ack and review tags
>=20
> Stefan Wahren (2):
>   dt-bindings: pwm-bcm2835: Increase pwm-cells
>   pwm: bcm2835: Support for polarity setting via DT
>=20
>  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
>  drivers/pwm/pwm-bcm2835.c                             | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

Both patches applied to for-4.14/drivers, thanks.

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmab3QACgkQ3SOs138+
s6EBVg//VOQt6/en9WU2H3fVFbd2gw56hqYMrX0DbZVHcZXoJGKRh8M48SrqNvX9
a0KWTg9lupmGAJyYOeJVqCVPwbHZMbrcub4/IrhuJZmNgcPV1OVRx0gJlfyaR2ws
sCKLLFxMV5lFgOrwvB4QM7b9hHCMINslKjwCI8Nd19JeUbPuPPhCyIkcj1bLLJvk
61W8DlM1cMCNYvx5P8aTTQlbKv/scfgE/Cq/eiunSB7Gv6/DHt9vyurvhjqV61Hc
E1WBa1C2p+R/vxHzQQNzOxJnEfFAiTAKFwMQq+2njcsJUuCP3UdnEpaK86zJLaue
gd9Vxzr9acBjvm7iMGC87FbZXJ5iQh0BB2HPJpQwIiPomdyMxcWBRlkXKd4RV42W
gEdqC5nHCjEoVW1daCX/tG+f5gT2JwNq0iqGuowTOvl6qYaWYCLHDW8K4KOHJNdW
18ZMusZzAYpdrvCKaNXG2LvKmivFqo5foRJNzaMwy2oca7pZG58mE8+dFofbz+34
6iBgAHGbPeXDJdG4mCoLU/biVTtH5/vLuPbTIvzXMWoCDBw56twvInkmFPM/AR9O
Y8+9/v3dw5utccgEkbS7oIV1KNuClDOx1uZ2+dKEh9O61aUWb+3tdRj8ZdqAj3Fv
djDXgu9hmfSqJJ55En+p7fjwQMPQJi2wBntWDgqO9gowHrkdD3c=
=LgAq
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
