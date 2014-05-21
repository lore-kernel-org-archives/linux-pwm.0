From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] PWM: lp3943: Set pwm_chip can_sleep flag
Date: Wed, 21 May 2014 12:25:51 +0200
Message-ID: <20140521102550.GC22783@ulmo>
References: <1397579890.10787.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:40030 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaEUK2J (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 May 2014 06:28:09 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so1398145eek.40
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2014 03:28:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397579890.10787.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 12:38:10AM +0800, Axel Lin wrote:
> Read/write through I2C can sleep, thus set pwm_chip can_sleep flag.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-lp3943.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfH8uAAoJEN0jrNd/PrOhJXcP/iiEm0AZlsgCv80j+JOd20FP
qbS5F4lre4z+OFRmpPnqAGh5UdIitPO/rn/hFKbN59VdTXVbgYF6PKY6ehk7dlgt
zdOpawHAsPKMZ20yjBZJL+Vd2BqBzpcI3BcQf5wu5QDXCLWo01FsaAdS+GOyPna7
pDcK+l2vVuhxlnLafRC3fNqVFkHviX0cq1RHbfcHRD1Q5/LVIVuEvO78Fs5LAIcp
pgYXxeA7ZDdrukRK46c2/benRwyE5rmY3xYqqHkdjb6SktVoJCsCxyLato7rQF0Q
27DexfzDTCCKfKFHZ32NJt0MAx+y68ZGegSmlRqyrGOzwZWpNWoK1advn1zgq8E1
CTlCxF95WT2VlbDi0xi3oOOO56dqvxw7Sjpm+d94u5/W9NRbK1h/HW20Wl9FFMw+
bVTWIKhbpv68mpglfNnQV5i5F3MFDggiuedGhWCiTlded5xKIO7Bcc0dcY25ZEHU
gcYIECUw30rM/Q51+SFmV70rggWBIR2XeJRvF0GFQpU2WuBOrqCPZRTCI9lXZqJQ
lw8Es7vnuUxjwRY5lQAavBonMdlU90bSB3T24hLElOHiU0y3fv0P6R6pEb3tB0Hk
5bEPHWr9HYIgN0jByQTMyrlg97NPV1cySmrpEpfiEpHOavT5iGQ8T7HYAcr/7mRe
ldZNcAYuo3eH2yqQaMk4
=KCLi
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
