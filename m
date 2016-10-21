From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: meson: Fix missing spin_lock_init
Date: Fri, 21 Oct 2016 09:12:06 +0200
Message-ID: <20161021071206.GB2670@ulmo.ba.sec>
References: <1473472549-20140-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36467 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbcJUHML (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 03:12:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so7805775pfg.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Oct 2016 00:12:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473472549-20140-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 10, 2016 at 09:55:49AM +0800, Axel Lin wrote:
> The driver uses the spin_lock but not initialize it, fix it.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-meson.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.9/fixes.

Thanks,
Thierry

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCb/GAAoJEN0jrNd/PrOhOzUP/0xL/VE65QvrQXQqalTDGD0S
1STtCAGlc00qQIGdio70WvMZ7TD1zmvGP7ZuPB89fYRWjqMzRraDMkPzl5zED2cX
M7S1anGdtyvkde4i+hZNhdPbVMHjOviUKTTNlLz8qa5fKoH4d6vtTQxSCrJGu0n7
wfBzI5PAv+Q1swPkLdnazqqxEaFMrhZ6hq65gOhrBAiMX3Ey+GrKq0VAgbDpq416
Np+YNj9PLkf0MZCLzNiUPXIfjuoeh7XGDArxAAh0sWiG0bypjrQl63K9l9yI/uj7
3yNhqyWQJ639w2mO/zwH47k15BnwHPaUNNJQsOhuMVp/Rwcz/dbzODwpauhpzxFH
/1Qf+d5p61r6YqB5vf1oNV5pgCf1ZjYlVJhyu050tuW9NbeQYMuqljJ5fuw0pU/l
kbtbNHw7ne4q9NbS3FfpD+C9o9NglggagyV3ZUBLl6EmwC9/8UOa+zg0KgbtDpgm
lX9yxBQE4RgBPPmwaK5TK+mfon4EAIzXQFOPNkPw4b5Fbk+BXDU99jNr+GT9NCtr
DRz/BC0+yKft+B1YbKgHbfogktxU5nmz5ZYqpoenm0a8rW2ku6pNwNKb3QoiUWmd
fNmUF8aslE1kTs/802zswU8DKCqfCH2af/yFOSr7UwzOpio2lQMoU29lFT5KB9kN
hofg4+pkr23JOTXo7usW
=mxV8
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
