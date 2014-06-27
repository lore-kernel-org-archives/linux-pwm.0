From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Added possibility to use pwm_bl.c with percentage
 instead of levels
Date: Fri, 27 Jun 2014 08:12:31 +0200
Message-ID: <20140627061231.GD9258@ulmo>
References: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:40930 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaF0GMe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Jun 2014 02:12:34 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so4651284wes.29
        for <linux-pwm@vger.kernel.org>; Thu, 26 Jun 2014 23:12:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2014 at 07:32:20AM +0200, Johannes Pointner wrote:
> Hello,
>=20
> I'm new working on the linux device drivers, so if I made something wrong
> please point me into the right direction.
>=20
> I'd like to use the pwm_bl driver for a sitara based terminal and for this
> I would need the possibility to set the backlight within a percentage
> range. The following patch should add this possibility to the pwm_bl
> driver. The idea is to keep backward compatibility by moving the required
> option brightness levels to optional. Therefore if there is no node with
> brightness levels the percentage levels are used.
>=20
> Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
> ---
>  .../bindings/video/backlight/
> pwm-backlight.txt     | 11 +++---
>  drivers/video/backlight/pwm_bl.c                   | 46
> ++++++++++++----------
>  2 files changed, 31 insertions(+), 26 deletions(-)

Also adding the backlight maintainers on Cc.

This has been discussed a few times before. In fact the original device
tree binding had support for a continuous range of levels but that was
rejected during review. The reason was, as far as I remember, that the
number of levels and the corresponding duty cycle values is something
that's usually determined at system design time. Often backlights can't
properly light the whole surface of the panel at every level.

That said, there's always the possibility to fake this by adding a DT
property with a continuous range, such as this:

	brightness-levels =3D <0 1 2 ... 100>;

Thierry

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrQtPAAoJEN0jrNd/PrOhV2AP/jSrKwnjgsu/VAoG8TILlVuj
2OX1u1Uxhmu2ArkyqiXck6U7Hv3bkjBgO2V8xvSqsQCSJL+dZvTC3O06QL3AgzLk
Dhz83edUttj2bcZW9AvmlfkAfUfcYgUDXfWhqn214ahYvIAk/yslWbw9JVhtlV8Y
rs3wRmPfQsm9Ya5Qv4h+mmwPL9/w9guqU2PvCV41Rs3zcOisgY4nTZY7sTBPi8dL
26ULQYg42aEdIq2o/uk1ACNk2NSSzXRqEFFaujpTMaYBuxOiKsxqobg4+5EVP26W
lqFcho5fikdY+I6LX+JIdUjzLuQ/iJ1Wo6UbYqaKHomOUwamdweJRtOhSdcOylwI
ovJo5oL+SST8IePLlZYaBNb8I9A6Kc9p7csL4+kNg8cxudp663JUKmtTtc5DmcLb
7+PSCHAsV4fXm6E6UK06gOybzrvKqkwaQX1fhzZ7NzVEXx4QbuCtLvxf1/RQGrBk
HwXOTWmjwvZKoqNf6T1X9OjE2cjaSBfsNKUlqRG0UthB+P4Yqu51dZoTkSlXAlM4
Oa2lNISrIgHxepSXABmk5bYWl+dJWp48SLQnQlM84iHChPkxzWS79n/OB5BwOorF
exM5xlPaLBj1zguwVAw2gJ/H3Q7QEpc0Blp+8tw06naThT6pUmMyabt9YnP9d4gf
Sf8zEiFcregX9jAG6ymT
=mR7U
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
