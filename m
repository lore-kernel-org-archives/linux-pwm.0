From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sysfs: Convert to use ATTRIBUTE_GROUPS macro
Date: Wed, 4 Dec 2013 11:05:30 +0100
Message-ID: <20131204100529.GV19943@ulmo.nvidia.com>
References: <1386139970.9997.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlkQeOBdElZ1aiuH"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:45719 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab3LDKG3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 05:06:29 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so6514187bkh.37
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2013 02:06:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386139970.9997.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Rob Landley <rob@landley.net>, linux-pwm@vger.kernel.org


--BlkQeOBdElZ1aiuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 02:52:50PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/sysfs.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Looks good. Can you please add a commit message? If nothing else it
could say what the advantages are of using the macro, even if that may
be somewhat obvious.

Thierry

--BlkQeOBdElZ1aiuH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnv5pAAoJEN0jrNd/PrOhhxoP/3UfyOh2aaBZ7UBQ4kPfFmHQ
wNyLEAIhyyUOIdp21jWNtmLhy24cBvyRPJjIkxg1BfqGvF4f3Pshwb+8OcbngvBo
xQmMEsjCx4wnvnqMYIPW7HCi0Vu0REuxJ6GS1c0P5VYH6WmpY0QLwj9pBHYReotq
HkqIRMgwiz8utWuVkYPDdI9th7TCcvgOJhdmGL7Z7oB1+fhtH7ouHp+hXcIOUeip
ooqZA9XcGGpWsnKE5J30Ft6m9XqEXKCk6xOTRcoi+qOqKQvkb5vcTVLY+2xBdg48
vVX6x0eCHZ5bKRkgP6Ic2foQi+z2tz/iAGPxzasbbkBg2k0gb1qkmJsanU+WBQ6M
Xp9gQoGYR+fyRc5yii7jwVbpknOehGX3r9Wb8I4Xy+vnGnu7cwxmFCgD1ab+njrJ
xmXZvozv46r5saICE/2moJUIHkyuGI7XJ3eQ2GqMEOvVN+hJ4EzALkPiWdIeYvvL
JMAbTgECjAwioQwvREXHiHFh4TULtHQAB67FjxgyOEyHV/ljVtQkIURjYPPczcwg
U5B3wAfPoEQhapHnKA85DLc8vovD5UgI8Si9AZPKgW1qsjgYlUhpsvT014/qQWXl
SgTOoMOIARjwkTJJVy5pdeeMeZW/WwO3cDMV9psUqsxqck3LJizcCy1vb/24WClG
eYtAFTwD8FcH2YQAdysL
=av4Z
-----END PGP SIGNATURE-----

--BlkQeOBdElZ1aiuH--
