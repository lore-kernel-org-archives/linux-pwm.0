From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: ab8500: Fix wrong value shift for disable/enable pwm
Date: Tue, 17 Dec 2013 10:30:50 +0100
Message-ID: <20131217093049.GA13823@ulmo.nvidia.com>
References: <1387078339.22351.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:40151 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3LQJcR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Dec 2013 04:32:17 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so2727036bkg.35
        for <linux-pwm@vger.kernel.org>; Tue, 17 Dec 2013 01:32:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387078339.22351.2.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Linus Walleij <linus.walleij@linaro.org>, Arun Murthy <arun.murthy@stericsson.com>, linux-pwm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2013 at 11:32:19AM +0800, Axel Lin wrote:
[...]

s/pwm/PWM/ in the subject, please.

[...]
> @@ -64,7 +60,7 @@ static int ab8500_pwm_enable(struct pwm_chip *chip, str=
uct pwm_device *pwm)
> =20
>  	ret =3D abx500_mask_and_set_register_interruptible(chip->dev,
>  				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
> -				1 << (chip->base - 1), ENABLE_PWM);
> +				1 << (chip->base - 1), 1 << (chip->base - 1));

I think we really need to find some other way to do this. At some point
I imagine board will move to DT, at which point we can no longer rely on
chip->base being set to a meaningful value.

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsBnJAAoJEN0jrNd/PrOhvo0QAJ478y3rn5I8Vv87H/CRGPr9
kXpBwL/LkPq0WD2Q06vsYj63GohPgbSLf6PvH+0dWw5gvLefJ/EoUHGLi5CpiMDm
ADWSEk+O6TJeoY5Y06EURELZfInpMkTKBWcYY3kD5ZE2vyzY8IXyCVvVQNkobRta
6yepKODIcIdf8EF1fRpcJj0Oc994dd9DskvbL0+UgYMe80vL38U4WYLPlmL3ENgs
RjbbBCVDV7Ec4WPv2svPj1iis8OqSM7a/W8ZzTIsvTzbNScOFZF5C/vA1jpnyeYh
aWimjqGwt+D/bU3eGKMH0zlxL9/uKTDNjEtXMkboniJ0ofbwD53aXT68m9QaTK4I
4aiXLIlsw3TXMkd07pT9b1aByhNrpjNabi9PvimbFPueSKfjKq51Ow5wFEfxVdbE
Yfa6U7NNTH/JtNDhkftNcIuQN+YXKVfmsDw1kDdmLr6Yjmd4fpry5taA7OOLUdfF
ZArjVMcjvz0+JxljlZvJ9JpwNXS3kJ733BAOvjGloZ1NrRGe5sym4iMsJyFl/wGJ
1VuE0SuSXdzUCRqn7G6c+LLvSgBcX+RuF8xnM2PIe8rHTpaBsKGwC+ND9WJkYiWP
TNTUo7aRWgh3ZedywyigtNUK8MKPz3rIG3xUvd7NeYzSi+oSdRmSl8ttzrrS3chr
+BuEH0JYEottT7rgoiph
=voT6
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
