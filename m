From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: stm32-lp: Remove pwm_is_enabled check before
 calling pwm_disable
Date: Tue, 5 Dec 2017 09:35:32 +0100
Message-ID: <20171205083532.GB7386@ulmo>
References: <20171107033041.10905-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:32878 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbdLEIff (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 03:35:35 -0500
Received: by mail-wr0-f173.google.com with SMTP id v22so20069047wrb.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 00:35:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171107033041.10905-1-axel.lin@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: linux-pwm@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 11:30:41AM +0800, Axel Lin wrote:
> The same checking is done by the implementation of pwm_disable().
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I don't think I ever mentioned that I had applied this for v4.15-rc1, so
just letting you know in case you were wondering.

Thierry

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomWlQACgkQ3SOs138+
s6HfLA//Xag9Zs5k6AAcxjbJvDv5SpJ55BUnRZvVAHeZGjsnkJazxrVPEvlSLkg/
sDDpOmBa62Rxpb+Bzg/eYth8i6s3TEi/kg9W2RpyucY9f4Ef95fJRZ8ziQ+lB4AL
wJPaTpfUbWjeo63AeRT+uB8AbQ1HxnKFfwFLi13Y48BdFOpN6lFa3TCxFGDTzPDj
l9qwHODREzxRkDb6L8nVo0BgA9tU9PZzRkC/PVzs2bdekvXK2MkqGroiH9hha8ck
dlT9xFyt/VSRCw3SxGwUSRWYcmkaThUg6XJ6Xnv2kNjF+uVdN35xOpeq/WmD+q1V
nYkxW4BYJqUQsJ609H65cQGkbbMSAfygX4l7m/cdGZIYrDDCo3khoHBqJh+lK6Zq
Gpd7yC7lCnyKUiagLYpBy4wF70yXRZpAMsYVSxAhgRXrwEJbx5lhoZA7MdQxSrF0
uVC5hxeHC5kiPqJDps4p4hR4wLxvCT+129PxQN9Rnw7HJY5lG9GtG931s6r+gpsh
SJS3316vI5rl2fvDD0+tgQSi5EttE7tQ5Eov6uIeJ3k2EKYAuoW+RUL55JvQ6P2T
gzPbY3Gkk3VBH72dKI6GJRkJXkcqcD0xXffzkM3heFwYtOd8RPDP0qChxBHKYfnX
ilk0k5u6fsWZX6I2EmIAWbJQUBmzliYUxJ4zHfeP5VW1OHVZfkc=
=cy+h
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
